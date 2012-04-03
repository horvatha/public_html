CGI-előkészületek
~~~~~~~~~~~~~~~~~~
Be kell állítani, hogy a cgi-bin működjön. Lásd
../apache/apache_beallitas .

A hp adatbázishoz
-------------------

Előkészületek
~~~~~~~~~~~~~~
Debianon és Ubuntun kipróbálva.

Telepíteni kell pár csomagot::

    apt-get install apache2 postgresql python-psycopg2

Létre kell hozni diak adatbázisfelhasználót és diak adatbázist.
Be kell állítani, hogy a diak jelszava diak legyen.
Ennek leírása a http://github.com/horvatha/linux/postgresql/ oldalon
található.

Be kell állítani, hogy jelszóval lehessen belépni.
/etc/postgresql/8.4/main/pg_hba.conf fájlban ident helyett password
kell::

    local   all         all                               ident

helyett::

    local   all         all                               password

És újraindítani a servert::

    /etc/init.d/apache2 restart


Órán
~~~~~~~~~

A sql/hp.sql táblát be kell olvastatni PostgreSQL adatbázisba így::

   psql -f sql/hp.sql

Az hp.py az így létrehozott táblákhoz egy Pythonban írt cgi program,
amely a htmltabla.py fájlt mint modult használja.

Az sql psql_lekerdezesek.txt ezekhez a táblákhoz készült.
