CREATE TABLE
DROP TABLE

INSERT INTO TABLE ...
UPDATE ...
DELETE 

SELECT
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

-- TODO INNER JOIN-nál on kell feljebb.

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

-- now()
