-- 1 --
SELECT LIBELLE FROM OPTIONV O 
  JOIN CARAC C ON C.CODE = O.CODE 
  JOIN RESERVATION R ON C.IDV = R.IDV 
  JOIN CLIENT CL ON R.NUMCL = CL.NUMCL
  JOIN VOYAGE V ON V.IDV = R.IDV
  WHERE NOM = 'MARIN' AND PRENOM = 'HUBERT' AND DATEDEP = '04/05/04' AND V.VILLEARR = 'ISTAMBUL' AND PRIX IS NULL;
  
-- 2 --
SELECT DISTINCT LIBELLE FROM OPTIONV OPT
  WHERE EXISTS (SELECT * FROM VOYAGE JOIN CARAC C ON VOYAGE.IDV = C.IDV WHERE OPT.CODE = C.CODE AND PRIX IS NULL) 
  AND EXISTS (SELECT * FROM VOYAGE JOIN CARAC C ON VOYAGE.IDV = C.IDV WHERE OPT.CODE = C.CODE AND PRIX IS NOT NULL);
  
SELECT DISTINCT LIBELLE FROM OPTIONV OPT
  JOIN CARAC C1 ON C1.CODE = OPT.CODE AND C1.PRIX IS NULL
  JOIN CARAC C2 ON C2.CODE = OPT.CODE AND C2.PRIX IS NOT NULL;
  
-- 3 --
SELECT LIBELLE FROM OPTIONV OPT
  JOIN CARAC C1 ON C1.CODE = OPT.CODE
  WHERE PRIX IS NULL
  GROUP BY OPT.CODE, LIBELLE
  HAVING COUNT(*) = (SELECT COUNT(*) FROM CARAC C2 WHERE OPT.CODE = C2.CODE);
  
-- 4 --
SELECT DISTINCT NOM, PRENOM FROM CLIENT C1
  JOIN RESERVATION R ON R.NUMCL = C1.NUMCL
  WHERE IDV IN(
    SELECT IDV FROM RESERVATION R2 
      JOIN CLIENT C2 ON R2.NUMCL = C2.NUMCL WHERE PRENOM = 'ARNAUD' AND NOM = 'PEYROCHE'
    );
    
-- 5 --
SELECT SUM(NVL(R.NBPERS, 0)) + SUM:(NVL(R.NBENF, 0)) AS NBPERS, COUNT(R.IDV) AS NBRES FROM CLIENT C
  JOIN RESERVATION R ON R.NUMC == C.NUMCLIENT
WHERE CATEGORIE =D 'PRIVILEGIÉ aha';)

-- 6 --
SELECT NOM, C.NUMCL FROM CLIENT C
JOIN RESERVATION R ON R.NUMCL = C.NUMCL
WHERE NVL(R.NBPERS, 0) + NVL(R.NBENF, 0) = (SELECT MAX(NVL(NBPERS, 0) + NVL(NBENF, 0)) FROM RESERVATION);

-- 7 --
SELECT SUM(R.NBPERS * P.TARIF) + SUM(NVL(R.NBENF, 0) * NVL(P.TARIFENF, 0)) AS TOTAL FROM RESERVATION R
JOIN PLANNING P ON P.IDV = R.IDV AND P.DATEDEP = R.DATEDEP
WHERE NUMCL = 2101;

-- 8 --
SELECT DISTINCT HOTEL FROM VOYAGE
WHERE NBETOILES = (SELECT MAX(NBETOILES) FROM VOYAGE);

-- 9 --
SELECT DISTINCT PAYSARR FROM VOYAGE
MINUS SELECT PAYSARR FROM VOYAGE
WHERE NBETOILES = (SELECT MAX(NBETOILES) FROM VOYAGE);

-- 10 --
SELECT DISTINCT C.NUMCL, NOM, R.IDV, R.DATERES FROM CLIENT C
LEFT JOIN RESERVATION R ON R.NUMCL = C.NUMCL
WHERE R.DATERES < '10/11/03' OR R.DATEDEP IS NULL;

-- 11 --
SELECT DISTINCT C.NUMCL, NOM FROM CLIENT C
LEFT JOIN RESERVATION R ON R.NUMCL = C.NUMCL AND  R.DATERES < '10/11/03'
WHERE R.DATEDEP IS NULL;

-- 12 --

-- 13 --

-- 14 --

-- 15 --
SELECT DISTINCT C.NUMCL, NOM FROM CLIENT C
JOIN RESERVATION R ON C.NUMCL = R.NUMCL
LEFT JOIN VOYAGE V ON R.IDV = V.IDV AND PAYSARR = 'MAROC'
WHERE V.DUREE IS NULL;

SELECT DISTINCT C.NUMCL, NOM FROM CLIENT C
WHERE NOT EXISTS (SELECT * FROM RESERVATION R
JOIN VOYAGE V ON R.IDV = V.IDV WHERE PAYSARR = 'MAROC' AND C.NUMCL = R.NUMCL);

-- 16 --
SELECT COUNT(*), PAYSARR FROM VOYAGE GROUP BY PAYSARR;

-- 16 --
SELECT COUNT(*), PAYSARR, VILLEARR FROM VOYAGE GROUP BY PAYSARR, VILLEARR;

-- 18 --
SELECT COUNT(DISTINCT VILLEARR), PAYSARR FROM VOYAGE GROUP BY PAYSARR;

-- 19 --
SELECT COUNT(DISTINCT P.DATEDEP), V.IDV, V.VILLEARR FROM VOYAGE V
JOIN PLANNING P ON P.IDV = V.IDV
GROUP BY V.IDV, V.VILLEARR;

-- 20 --
SELECT COUNT(DISTINCT C.CODE), V.IDV, V.VILLEARR FROM VOYAGE V
JOIN CARAC C ON C.IDV = V.IDV
WHERE C.PRIX IS NULL
GROUP BY V.IDV, V.VILLEARR;

-- 21 --
SELECT CATEGORIE, COUNT(*) FROM CLIENT
GROUP BY CATEGORIE;

-- 22 --
SELECT COUNT(R.NUMCL) AS NBRESERV, V.IDV, V.VILLEARR, SUM(R.NBPERS + NVL(R.NBENF, 0)) AS TOTPERS FROM VOYAGE V
JOIN RESERVATION R ON R.IDV = V.IDV
GROUP BY V.IDV, V.VILLEARR;

-- 23 --
SELECT AVG(NVL(PRIX, 0)), IDV FROM CARAC GROUP BY IDV;

-- 24 --
SELECT COUNT(DISTINCT C1.CODE) AS NBGRATOS, COUNT(DISTINCT C2.CODE) AS NBPAYANT, V.IDV, V.VILLEARR FROM VOYAGE V
JOIN CARAC C1 ON C1.IDV = V.IDV
JOIN CARAC C2 ON C2.IDV = V.IDV
WHERE C1.PRIX IS NULL AND C2.PRIX IS NOT NULL
GROUP BY V.IDV, V.VILLEARR;

-- 25 --
SELECT COUNT(*), VILLE FROM CLIENT
GROUP BY VILLE
HAVING COUNT(*) > 5;

-- 26 --
SELECT V.IDV, V.VILLEARR, SUM(R.NBPERS * P.TARIF + NVL(R.NBENF, 0) * NVL(P.TARIFENF, 0)) FROM VOYAGE V
JOIN RESERVATION R ON V.IDV = R.IDV
JOIN PLANNING P ON P.IDV = R.IDV AND P.DATEDEP = R.DATEDEP
GROUP BY V.IDV, V.VILLEARR;

-- 27 --
SELECT R.IDV, R.DATEDEP, SUM(R.NBPERS * P.TARIF + NVL(R.NBENF, 0) * NVL(P.TARIFENF, 0)) FROM RESERVATION R
JOIN PLANNING P ON P.IDV = R.IDV AND P.DATEDEP = R.DATEDEP
GROUP BY R.IDV, R.DATEDEP;

-- 28 --
SELECT PAYSARR FROM VOYAGE V
JOIN RESERVATION R ON R.IDV = V.IDV
GROUP BY PAYSARR, V.IDV
HAVING COUNT(R.NUMCL) > (SELECT COUNT(R.NUMCL) 
  FROM VOYAGE 
  JOIN RESERVATION ON RESERVATION.IDV = VOYAGE.IDV
  WHERE PAYSARR = 'ESPAGNE'
  );

-- 29 --
SELECT NVL(CATEGORIE, 'PAS DE CATEGORIE') FROM CLIENT
GROUP BY CATEGORIE
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM CLIENT
  GROUP BY CATEGORIE);
  
-- 30 --
SELECT PAYSARR FROM VOYAGE V
JOIN RESERVATION R ON V.IDV = R.IDV
GROUP BY PAYSARR
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM VOYAGE V
  JOIN RESERVATION R ON V.IDV = R.IDV
  GROUP BY PAYSARR);
  
-- 31 --
SELECT C.NUMCL, NOM, COUNT(R.NUMCL) FROM CLIENT C
JOIN RESERVATION R ON C.NUMCL = R.NUMCL
JOIN RESERVATION R2 ON R2.NUMCL = C.NUMCL
JOIN VOYAGE V ON R2.IDV = V.IDV
WHERE V.PAYSARR = 'KENYA'
GROUP BY C.NUMCL, NOM;

-- 32 --
SELECT PAYSARR, COUNT(*) FROM VOYAGE
WHERE PAYSARR IN(SELECT PAYSARR FROM VOYAGE WHERE NBETOILES >= 5)
GROUP BY PAYSARR;

-- 33 --
SELECT TABLE_NAME FROM USER_TABLES;

--34--
SELECT COLUMN_NAME FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'CAPACITE';
--35--
SELECT COUNT(*) FROM USER_TAB_COLUMNS;
--36--
SELECT COLUMN_NAME,TABLE_NAME FROM USER_TAB_COLUMNS WHERE DATA_TYPE ='DATE'
--37--
SELECT * FROM USER_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'R'
--38--
SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME IN(
  SELECT TABLE_NAME FROM USER_TAB_COLUMNS
  WHERE DATA_TYPE = 'NUMBER');
  
