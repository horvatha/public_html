PostgreSQL kezelése
--------------------
Indítás psql paranccsal, jelszó: diak.
\d
\d szemelyek


SQL-lekérdezések
-----------------

SELECT * FROM szemelyek;
SELECT nev, anyanev FROM szemelyek;
SELECT nev, anyanev FROM szemelyek WHERE szemelykod < 4;
SELECT nev, anyanev FROM szemelyek WHERE anyanev = 'Molly Prewett';
SELECT nev, anyanev FROM szemelyek WHERE anyanev LIKE 'Molly%';
SELECT nev, anyanev FROM szemelyek WHERE nev LIKE '%Potter';
SELECT nev, anyanev FROM szemelyek WHERE nev LIKE '%o%';
SELECT nev, anyanev FROM adatok WHERE anyanev = 'Molly Prewett';
SELECT count(nev) FROM szemelyek WHERE anyanev='Molly Prewett';

INSERT INTO kepek VALUES (5, 'http://images1.wikia.nocookie.net/__cb20100123225257/harrypotter/images/4/48/Rupert_Grint_as_Ron_Weasley_(GoF-03).jpg');
INSERT INTO kepek_szemelyek VALUES (2, 5, 'Elegans oltonyben');

Melyik működik?

DELETE FROM szemelyek WHERE szemelykod = 1;
DELETE FROM szemelyek WHERE nev LIKE "Harry%";
DELETE FROM szemelyek WHERE nev LIKE "Regulus%";
