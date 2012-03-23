#!/usr/bin/env python
# encoding: utf-8

from __future__ import print_function
import cgitb
cgitb.enable()

"""
CGI-hez alapfájl.
"""

print("Content-Type: text/html\n") ## CGI

print("""<html>
<body>
""")

print("<b>Ide jön a belseje</b>")

print("""</body>
</html>""")

