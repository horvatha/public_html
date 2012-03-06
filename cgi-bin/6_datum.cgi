#!/usr/bin/env python
# encoding: utf-8

"""
Lista és dátum megjelenítése CGI-ben.
"""

print "Content-Type: text/html\n" ## CGI

print """<html>
<body>
"""

for i in range(1,101):
  print i

print "<br>"

import time
helyi = time.localtime()
print helyi

print "<br>"

ev = helyi[0]
honap = helyi[1]
nap = helyi[2]
print "Év: ", ev, "<br>hónap:", honap, "nap:", nap

import calendar
print "<pre>"
calendar.prmonth(ev, honap)
print "</pre>"

print """</body>
</html>"""

