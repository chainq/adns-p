{ simple test code for adns-p }

program adnstest;

uses
  adns, sockets, sysutils;

var
  adnss: adns_state;
  adnsa: Padns_answer;

procedure find_ip_sync(host: AnsiString);
begin
  writeln(adns_synchronous(adnss,PChar(host),adns_r_a,adns_qf_search or adns_qf_owner,adnsa));

  if adnsa^.status = adns_s_ok then
  begin
    if adnsa^.nrrs = 0 then
      writeln('ERROR: host ',host,' has no IP addresses!')
    else
    if adnsa^.nrrs > 1 then
      writeln('RESULT: ',host,' has ',adnsa^.nrrs,' IP addresses, using ',HostAddrToStr(NetToHost(adnsa^.rrs.inaddr[0])))
    else
      writeln('RESULT: ',host,' resolves to IP address ',HostAddrToStr(NetToHost(adnsa^.rrs.inaddr[0])));
  end
  else
    writeln('Status not OK');
end;

procedure find_ip_async(host: AnsiString);
var
  adnsq: adns_query;
begin
  adnsq:=nil;
  writeln(adns_submit(adnss,PChar(host),adns_r_a,adns_qf_search or adns_qf_owner,nil,adnsq));

  repeat
    write('.');
    sleep(1);
  until (adns_check(adnss, adnsq, adnsa, nil) = 0) and (adnsa^.status = adns_s_ok);
  writeln;

  if adnsa^.status = adns_s_ok then
  begin
    if adnsa^.nrrs = 0 then
      writeln('ERROR: host ',host,' has no IP addresses!')
    else
    if adnsa^.nrrs > 1 then
      writeln('RESULT: ',host,' has ',adnsa^.nrrs,' IP addresses, using ',HostAddrToStr(NetToHost(adnsa^.rrs.inaddr[0])))
    else
      writeln('RESULT: ',host,' resolves to IP address ',HostAddrToStr(NetToHost(adnsa^.rrs.inaddr[0])));
  end
  else
    writeln('Status not OK');
end;


begin
  adns_init(adnss,0,nil);
  writeln('Init OK!');

  writeln('Testing sync...');
  find_ip_sync('scene.org');
  find_ip_sync('microsoft.com');

  writeln('Testing async...');
  find_ip_async('pouet.net');
  find_ip_async('google.com');

  adns_finish(adnss);
  writeln('Done.');
end.
