adns-P
======

This is a Pascal interface to use the GNU adns library from
applications written in Free Pascal.

It's an 1:1 conversion of the *adns.h* header from adns.

adns is an advanced, easy to use, asynchronous-capable DNS
client library and utilities. It is a GNU project avaiable at:

http://www.gnu.org/software/adns/

GNU adns is available under the GNU General Public License.

To Do
-----

- Proper testing against the C header (eg. struct sizes)
- Support and testing on other systems than Linux/i386
- Cover the logging functions
- Delphi and Kylix support


Dependencies
------------

Make sure you have libadns, libadns-dev and/or adns-tools 
package installed on your system.


How To Use
----------

For now, simply build the test app using:

    fpc adnstest.dpr
