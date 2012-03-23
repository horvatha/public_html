\d
\d szemelyek
SELECT * FROM szemelyek;
SELECT nev, anyanev FROM szemelyek;
SELECT nev, anyanev FROM szemelyek WHERE szemelykod < 4;
SELECT nev, anyanev FROM szemelyek WHERE anyanev = 'Molly Prewett';
SELECT nev, anyanev FROM szemelyek WHERE anyanev LIKE 'Molly%';
SELECT nev, anyanev FROM szemelyek WHERE nev LIKE '%Potter';
SELECT nev, anyanev FROM szemelyek WHERE nev LIKE '%o%';
SELECT nev, anyanev FROM adatok WHERE anyanev = 'Molly Prewett';
SELECT count(nev) FROM szemelyek WHERE anyanev='Molly Prewett';

