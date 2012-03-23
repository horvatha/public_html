#!/usr/bin/env python
# encoding: utf-8

"""
PostgreSQL-adatok lekérdezése Python-CGI-ből.
"""

import cgi
import cgitb; cgitb.enable()  # A hibafigyeléshez (debug) kell
import psycopg2 as database # PostgreSQL adatbázis kezeléséhez kell.
from htmltabla import htmltabla, html, fejlec

print "Content-Type: text/html\n" ## CGI


# Itt lehet állítani az adatbázist:
#connection = database.connect(database='diak', user='diak')
connection = database.connect(database='diak', user='diak', password='diak', host='localhost')

cursor = connection.cursor()

# Itt lehet az utasítást megadni:
#cursor.execute("""INSERT INTO szemelyek (nev) VALUES ('Igor Karkarov');""")
cursor.execute("""SELECT * FROM adatok;""")
# order by, where

# Ez akkor kell, ha az adatbázist módosítjuk (UPDATE, INSERT, DELETE). Lekérdezésnél nem kell.
connection.commit()

eredmeny = cursor.fetchall()

print fejlec
print "<h1>Képek a Harry Potter filmekből</h1>"

tablafejlec = ['Név', 'Kép', 'Képfelirat', 'Anyja neve', 'Apja neve']
print "\n".join(htmltabla(eredmeny, fejlec=tablafejlec))

for tabla in "szemelyek kepek kepek_szemelyek".split():
    print html(tabla, connection)


print "</body>\n</html>"
