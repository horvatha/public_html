Mi az SQL-nyelv?

Egy szabványos nyelv a relációs adatbázisokhoz történő hozzáférésre.
Minden jelentősebb adatbáziskezelő kezelhető SQL-nyelven keresztül.
Gyakran a weboldalak SQL-parancsokon keresztül férnek hozzá a szükséges
adatokhoz.

------------------------------

Mire használható az SQL-nyelv?

Relációs adatbázisok esetén:

1. Táblák
a) létrehozására
    CREATE TABLE ...
b) törlésére
    DROP TABLE ...
c) mezőinek megváltoztatására (pl. új mező hozzáadása)
    ALTER TABLE

2. A táblák tartalmának megváltoztatására
a) beszúrás
    INSERT INTO TABLE ...
b) frissítés (pl. egy mező bizonyos elemeit szorozzuk 1.02-vel)
    UPDATE ...
c) bizonyos tulajdonságú sorok törlése
    DELETE ...

3. Adatok lekérdezésére
    SELECT ... (kiválogat) 

4. Adott felhasználóknak jogok adása és megvonása. A fenti műveletek
  mindegyikére külön jog adható az egyes adatbázisfelhasználóknak, vagy
  azok csoportjainak.
    GRANT ... (adományoz)
    REVOKE ... (megvon)

---------------------------------
Mindig törölhető egy táblának bármely sora? Mindig törölhető egy tábla?

Ha jogosultságunk van rá, akkor sem mindig. Ha idegen kulcs hivatkozik
rá, akkor nem.

Például a bankos példában a következő táblák vannak:

                     bank_naplo(szamlaszam*, penzmozgas, idopont*)
                                    | N
                                    |
                                    V 1
bank_szemelyes_adatok(nev, cim, szamlaszam*)
                                    A 1
                                    |
                                    | 1
                  bank_egyenleg(szamlaszam*, egyenleg)

Itt az átutalásokat naplózza az adatbázis. A fenti kapcsolatok miatt nem
törölhető olyan ügyfél személyes adata, amelyre a bank_naplo táblában
hivatkozás van, vagy szerepel a bank_egyenleg táblában.

A táblák törlésekor is fontos a sorrend. A fentiek közül a
bank_szemelyes_adatok táblát csak utoljára tudjuk törölni, mert különben
az idegen kulcsok a semmibe mutatnának.

---------------------------------

Mi a nézet, és mi köze a táblákhoz?

A nézet nem egy valódi tábla, hanem az egy vagy több táblából van összerakva
egy lekérdezéssel. Lekérdezéskor a táblákhoz hasonlóan viselkedik.

Használata:

1. Átláthatóság: Gyakran egy lekérdezés átláthatóbban úgy oldható meg, ha előzőleg egy
  másik lekérdezéssel egy nézetet hozunk létre.

2. Jogosultságkezelés: A táblákból kigyűjthetjük azt, ami egy adott
  adatbázisfelhasználó számára szükséges, így, ha csak a nézetre adunk
  jogot, akkor a táblák többi adatát nem láthatja.

3. Táblák átalakítása (ezt nem kell tudni): Időnként előfordulhat, hogy a táblák az eredeti
  formájukban nem felelnek meg az újabb követelményeknek. Ilyenkor például
  felbonthatnak egy táblát több táblára. Ez viszont azt eredményezheti,
  hogy az addig működő függvények nem fognak működni. Ha a régi tábla
  helyett egy ugyanolyan nevű nézetet készítünk, amely tartalmazza a
  szükséges adatokat, akkor valószínűleg jóval kevesebb függvényt kell
  újraírni.

A bankos példában a bank_ugyfelek összegyűjti a nev, cim és egyenleg
adatokat két táblából. Sok szempontból (pl. lekérdezéskor) úgy
viselkedik, mintha egy 

bank_ugyfelek(nev, cim, egyenleg)

tábla lenne.

---------------------------------
A parancsok részletesen
---------------------------------


SELECT * FROM ugyfelek;

-- Ez is ugyanaz:

select
*
from
ugyfelek
;

SELECT nev, cim FROM bank_ugyfelek;

SELECT nev AS Név, cim AS Cím FROM bank_ugyfelek;

SELECT nev, cim FROM bank_ugyfelek
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
