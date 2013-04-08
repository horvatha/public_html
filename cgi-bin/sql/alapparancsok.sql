Mire használható az SQL-nyelv?

Relációs adatbázisok esetén:

1. Táblák
a) létrehozására
CREATE TABLE
b) törlésére
DROP TABLE
c) mezőinek megváltoztatására (pl. új mező hozzáadása)
ALTER TABLE

2. A táblák tartalmának megváltoztatására
a) beszúrás
INSERT INTO TABLE ...
b) frissítés (pl. egy mező bizonyos elemeit szorozzuk 1.02-vel)
UPDATE ...
c) bizonyos tulajdonságú sorok törlése
DELETE 

3. Adatok lekérdezésére
SELECT

4. Adott felhasználóknak jogok adása és megvonása
GRANT
REVOKE

---------------------------------


SELECT * FROM ugyfelek;

-- Ez is ugyanaz:

select
*
from
ugyfelek
;

SELECT nev, cim FROM ugyfelek;

SELECT nev AS Nev, cim AS Cím FROM ugyfelek;

SELECT nev, cim FROM ugyfelek
WHERE ir_szam = 8000;

SELECT kolcsonzesek.filmcim, ugyfelek.nev, kolcsonzesek.datum
FROM kolcsonzesek INNER JOIN ugyfelek
	ON ugyfelek.ugyfelkod = kolcsonzesek.ugyfelkod;

SELECT kolcsonzesek.filmcim, ugyfelek.nev, kolcsonzesek.datum
FROM kolcsonzesek INNER JOIN ugyfelek
	ON ugyfelek.ugyfelkod = kolcsonzesek.ugyfelkod
ORDER BY ugyfelek.nev;

+ WHERE ugyfelek.ir_sz = 8000

Majdnem általános leírása:

SELECT { * | <mezőnév> [ AS <fejléc neve>] ...}
FROM <tábla neve> [ INNER JOIN <másik tábla> ]
WHERE <feltétel> [ {AND|OR} <feltétel2> ]...
ORDER BY <mezőnév> [, <mezőnév2>]...
GROUP BY <mezőnév> [, <mezőnév2>]...
;


SELECT sum(darab) FROM filmek
GROUP BY filmcim, temakod;

összegzések: sum, max, min, avg, count

CREATE TABLE kolcsonzesek (
  kolcs_kod integer PRIMARY KEY;
  datum date;
  filmcim varchar(20) NOT NULL;
  vissza date
  );

INSERT INTO TABLE kolcsonzesek
  (datum, filmcim)
  VALUES (2008.03.18, 'Hair');

CREATE TABLE
Példa látható a hp.sql fájlban.
https://github.com/horvatha/public_html/blob/master/cgi-bin/sql/hp.sql
