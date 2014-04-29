-- Bevihető a
-- psql -f hp.sql
-- paranccsal.

--
-- A relációk létrehozása
--

-- Ha már léteznek töröljük ezeket, hogy újra létrehozhassuk:
-- DROP VIEW betétesek;
DROP TABLE szemelyek CASCADE;
DROP TABLE kepek CASCADE;
DROP TABLE kepek_szemelyek;

CREATE TABLE szemelyek (
	szemelykod	SERIAL PRIMARY KEY,
	nev	VARCHAR(70) NOT NULL,
	apanev	VARCHAR(70),
	anyanev	VARCHAR(70),
	letrehozas TIMESTAMP DEFAULT now()
);


CREATE TABLE kepek (
	kepkod	SERIAL PRIMARY KEY,
	url	VARCHAR(256) NOT NULL
);


CREATE TABLE kepek_szemelyek (
	szemelykod INTEGER REFERENCES szemelyek,
	kepkod INTEGER REFERENCES kepek,
	szoveg	VARCHAR(128)
);


--
-- Személy beszúrása
--
CREATE OR REPLACE FUNCTION szemely_beszur(nev text)
  RETURNS boolean
  AS $$
	INSERT INTO szemelyek VALUES (
		DEFAULT, $1, null, null );
	SELECT true;
  $$ LANGUAGE 'SQL';

CREATE OR REPLACE FUNCTION szemely_beszur(nev text, apanev text, anyanev text)
  RETURNS boolean
  AS $$
	INSERT INTO szemelyek VALUES (
		DEFAULT, $1, $2, $3 );
	SELECT true;
  $$ LANGUAGE 'SQL';

CREATE VIEW adatok AS
 SELECT nev, apanev, anyanev, url, szoveg
	FROM szemelyek JOIN
	  (SELECT * FROM kepek_szemelyek JOIN kepek USING (kepkod)) AS ideiglenes
	USING (szemelykod);

GRANT SELECT ON adatok, szemelyek, kepek, kepek_szemelyek TO diak;

SELECT szemely_beszur ('Harry Potter', 'James Potter', 'Lily Evans');
SELECT szemely_beszur ('Ron Weasley', 'Arthur Weasley', 'Molly Prewett');
SELECT szemely_beszur ('Ginevra Weasley', 'Arthur Weasley', 'Molly Prewett');
SELECT szemely_beszur ('Sirius Black', 'Orion Black', 'Walburga Black');
SELECT szemely_beszur ('Regulus Black', 'Orion Black', 'Walburga Black');
SELECT szemely_beszur ('Draco Malfoy', 'Lucius Malfoy', 'Narcissa Black');
SELECT szemely_beszur ('Scorpius Malfoy', 'Draco Malfoy', 'Astoria Greengrass');
SELECT szemely_beszur ('James Potter');

CREATE OR REPLACE FUNCTION kep_beszur(szemelynev text, url text, szoveg text)
  RETURNS boolean
  AS $$
	INSERT INTO kepek VALUES (
		DEFAULT, $2);
	INSERT INTO kepek_szemelyek VALUES (
		(SELECT szemelykod FROM szemelyek WHERE nev LIKE '%' || $1 || '%'), 
		lastval(),
		$3
	);
	SELECT true;
  $$ LANGUAGE 'SQL';

SELECT kep_beszur('Harry Potter',
	'http://images3.wikia.nocookie.net/harrypotter/images/thumb/7/7b/Harryronhermoine.jpg/200px-Harryronhermoine.jpg',
	'Ronnal és Hermionéval');
INSERT INTO kepek_szemelyek VALUES (2, 1, 'Harryvel és Hermionéval');
SELECT kep_beszur('Harry Potter',
	'http://images3.wikia.nocookie.net/harrypotter/images/thumb/2/2a/HarryQuillSS.jpg/170px-HarryQuillSS.jpg',
	'Első éve a Roxsfortban.');
SELECT kep_beszur('Sirius Black',
	'http://images4.wikia.nocookie.net/harrypotter/images/thumb/d/d6/James_Sirius_youth.jpg/220px-James_Sirius_youth.jpg',
'Fiatalkorában, jobbra mellette Harry apja, James');
SELECT kep_beszur('Ginevra',
	'http://z.about.com/d/movies/1/0/O/5/P/harrypotter5pic35.jpg',
	'Arckép');
