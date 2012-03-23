#!/usr/bin/env python
# encoding: utf-8

"""
Lista és dátum megjelenítése CGI-ben.
"""
from __future__ import print_function


print("Content-Type: text/html\n") ## CGI

print("""<html>
<head>
<title>Stíluslappal megjelenített CGI-s oldal</title>
<link REL="stylesheet" TYPE="text/css" href="../styles/stilus.css">
</head>
<body>
""")

for i in range(1,30):
  print("<p>", i, i**2, i**3, "</p>")

print("<hr>")

import time
helyi = time.localtime()
#print(helyi)


ev = helyi[0]
honap = helyi[1]
nap = helyi[2]
print("Év: ", ev, "<b>hónap:", honap, "</b> nap:", nap)

print("<hr>")

import calendar
print("<pre>")
calendar.prmonth(ev, honap)
print("</pre>")

print("""</body>
</html>""")

