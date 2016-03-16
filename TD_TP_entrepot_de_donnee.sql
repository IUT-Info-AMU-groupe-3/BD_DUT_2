---table tp fed ---
DROP TABLE TYPOLOGIE cascade constraints;
DROP TABLE PRODUIT cascade constraints;
DROP TABLE LIEU cascade constraints;
DROP TABLE MAGASIN cascade constraints;
DROP TABLE TEMPS cascade constraints;
DROP TABLE VENTE cascade constraints;

CREATE TABLE TYPOLOGIE	
	(IdCat VARCHAR2(10),  
	Designation VARCHAR2(30), 
	IdCatPere VARCHAR2(10),
	CONSTRAINT PK_TYPOLOGIE PRIMARY KEY(IdCat),
	CONSTRAINT FK_TYPOLOGIE 
			FOREIGN KEY(IdCatPere) REFERENCES TYPOLOGIE(IdCat));

CREATE TABLE PRODUIT	
	(IdP VARCHAR2(10),
	Designation VARCHAR2(30), 
	IdCat VARCHAR2(10),
	CONSTRAINT PK_PRODUIT PRIMARY KEY(IdP),
	CONSTRAINT FK_PRODUIT 
			FOREIGN KEY(IdCat) REFERENCES TYPOLOGIE(IdCat));

CREATE TABLE LIEU	
	(IdL VARCHAR2(10),
	Nom VARCHAR2(30), 
	IdLPere VARCHAR2(10),
	CONSTRAINT PK_LIEU PRIMARY KEY(IdL),
	CONSTRAINT FK_LIEU 
			FOREIGN KEY(IdLPere) REFERENCES LIEU(IdL));

CREATE TABLE MAGASIN	
	(IdM VARCHAR2(10),
	Nom VARCHAR2(30), 
	IdL VARCHAR2(10),
	CONSTRAINT PK_MAGASIN PRIMARY KEY(IdM),
	CONSTRAINT FK_MAGASIN 
			FOREIGN KEY(IdL) REFERENCES LIEU(IdL));

CREATE TABLE TEMPS	
	(IdT VARCHAR2(10),
	DateV DATE, 
	CONSTRAINT PK_TEMPS PRIMARY KEY(IdT));

CREATE TABLE VENTE	
	(IdV VARCHAR2(10),
	IdM VARCHAR2(10),
	IdP VARCHAR2(10),
	IdT VARCHAR2(10),
	Quantite NUMBER(10,0), 
	Prix NUMBER(10,0),
	CONSTRAINT PK_VENTE PRIMARY KEY(IdV),
	CONSTRAINT FK1_VENTE 
			FOREIGN KEY(IdM) REFERENCES MAGASIN(IdM),
	CONSTRAINT FK2_VENTE 
			FOREIGN KEY(IdP) REFERENCES PRODUIT(IdP),
	CONSTRAINT FK3_VENTE 
			FOREIGN KEY(IdT) REFERENCES TEMPS(IdT));

/* Tuples de TYPOLOGIE */
INSERT INTO TYPOLOGIE VALUES (10001, 'TEXTILE', NULL);
INSERT INTO TYPOLOGIE VALUES (10010, 'HABILLEMENT', 10001);
INSERT INTO TYPOLOGIE VALUES (10011, 'LINGE DE MAISON', 10001);
INSERT INTO TYPOLOGIE VALUES (10110, 'HAB FEMME', 10010);
INSERT INTO TYPOLOGIE VALUES (10111, 'HAB HOMME', 10010);
INSERT INTO TYPOLOGIE VALUES (10112, 'HAB ENFANT', 10010);
INSERT INTO TYPOLOGIE VALUES (10120, 'LITERIE', 10011);
INSERT INTO TYPOLOGIE VALUES (10121, 'CUISINE', 10011);
INSERT INTO TYPOLOGIE VALUES (10122, 'SALLE DE BAIN', 10011);

/* Tuples de PRODUIT */
INSERT INTO PRODUIT VALUES(9987, 'DRAP DE BAIN POISSON', 10011);
INSERT INTO PRODUIT VALUES(9988, 'SERVIETTE TOILETTE POISSON', 10011);
INSERT INTO PRODUIT VALUES(9989, 'GANT TOILETTE POISSON', 10011);
INSERT INTO PRODUIT VALUES(9800, 'JEAN DELAVE', 10010);
INSERT INTO PRODUIT VALUES(9801, 'PANTALON COTON NOIR', 10010);
INSERT INTO PRODUIT VALUES(9802, 'PANTALON KAKI', 10010);

/* Tuples de LIEU */
INSERT INTO LIEU VALUES(10, 'FRANCE', NULL);
INSERT INTO LIEU VALUES(875, 'PACA', 10);
INSERT INTO LIEU VALUES(879, 'AUVERGNE', 10);
INSERT INTO LIEU VALUES(1087, 'PUYS DE DOME', 879);
INSERT INTO LIEU VALUES(9087, 'CLERMONT FERRAND', 1087);
INSERT INTO LIEU VALUES(1478, 'BOUCHES DU RHONE', 875);
INSERT INTO LIEU VALUES(1479, 'VAR', 875);
INSERT INTO LIEU VALUES(1480, 'ALPES MARITIMES', 875);
INSERT INTO LIEU VALUES(8012, 'MARSEILLE', 1478);
INSERT INTO LIEU VALUES(8013, 'AIX-EN-PROVENCE', 1478);
INSERT INTO LIEU VALUES(8014, 'AUBAGNE', 1478);
INSERT INTO LIEU VALUES(8478, 'TOULON', 1479);
INSERT INTO LIEU VALUES(8479, 'FREJUS', 1479);
INSERT INTO LIEU VALUES(8503, 'NICE', 1480);
INSERT INTO LIEU VALUES(8504, 'CANNES', 1480);
INSERT INTO LIEU VALUES(8505, 'GRASSE', 1480);

/* Tuples de MAGASIN */
INSERT INTO MAGASIN VALUES(100, 'TOULON MAYOL', 8478);
INSERT INTO MAGASIN VALUES(101, 'TOULON GRAND VAR', 8478);
INSERT INTO MAGASIN VALUES(102, 'FREJUS LGT', 8479);
INSERT INTO MAGASIN VALUES(103, 'LINGOSTIERE', 8503);
INSERT INTO MAGASIN VALUES(104, 'TNL', 8503);
INSERT INTO MAGASIN VALUES(105, 'ST CLAUDE', 8504);
INSERT INTO MAGASIN VALUES(106, 'PASSE', 8504);
INSERT INTO MAGASIN VALUES(107, 'LE MERLAN', 8012);
INSERT INTO MAGASIN VALUES(108, 'BONNEVEINE', 8012);
INSERT INTO MAGASIN VALUES(109, 'GRAND LITTORAL', 8012);
INSERT INTO MAGASIN VALUES(110, 'LA PIOLINE', 8013);
INSERT INTO MAGASIN VALUES(111, 'LA PALUD', 8014);
INSERT INTO MAGASIN VALUES(112, 'JAUDE', 9087);
INSERT INTO MAGASIN VALUES(113, 'LES CEZEAUX', 9087);

/* Tuples de TEMPS */
INSERT INTO TEMPS VALUES(1, to_date('10/10/10', 'MM/DD/YY'));
INSERT INTO TEMPS VALUES(2, to_date('10/11/10', 'MM/DD/YY'));
INSERT INTO TEMPS VALUES(3, to_date('10/12/10', 'MM/DD/YY'));
INSERT INTO TEMPS VALUES(4, to_date('10/13/10', 'MM/DD/YY'));
INSERT INTO TEMPS VALUES(5, to_date('09/01/10', 'MM/DD/YY'));
INSERT INTO TEMPS VALUES(6, to_date('09/02/10', 'MM/DD/YY'));
INSERT INTO TEMPS VALUES(7, to_date('09/03/10', 'MM/DD/YY'));

/* Tuples de VENTE (IdM, IdP, IdT) */
INSERT INTO VENTE VALUES(1,100,9987, 1, 2, 60);
INSERT INTO VENTE VALUES(2,100,9987, 3, 1, 30);
INSERT INTO VENTE VALUES(3,100,9987, 4, 1, 30);
INSERT INTO VENTE VALUES(4,104,9987, 1, 2, 50);
INSERT INTO VENTE VALUES(5,102,9987, 7, 1, 25);
INSERT INTO VENTE VALUES(6,102,9987, 6, 5, 125);
INSERT INTO VENTE VALUES(7,103,9988, 1, 3, 45);
INSERT INTO VENTE VALUES(8,109,9988, 5, 2, 30);
INSERT INTO VENTE VALUES(9,110,9988, 6, 1, 15);
INSERT INTO VENTE VALUES(10,111,9988, 7, 2, 30);
INSERT INTO VENTE VALUES(11,112,9988, 7, 2, 30);
INSERT INTO VENTE VALUES(12,100,9989, 1, 2, 10);
INSERT INTO VENTE VALUES(13,105,9989, 2, 1, 4.5);
INSERT INTO VENTE VALUES(14,106,9989, 3, 2, 9);
INSERT INTO VENTE VALUES(15,107,9989, 1, 2, 10);
INSERT INTO VENTE VALUES(16,108,9989, 3, 1, 5);
INSERT INTO VENTE VALUES(17,109,9989, 1, 1, 5);
INSERT INTO VENTE VALUES(18,100,9800, 1, 1, 45);
INSERT INTO VENTE VALUES(19,100,9800, 2, 1, 45);
INSERT INTO VENTE VALUES(20,100,9800, 3, 1, 45);
INSERT INTO VENTE VALUES(21,103,9800, 1, 1, 48);
INSERT INTO VENTE VALUES(22,103,9800, 1, 1, 48);

---2)---

  CREATE TABLE CVENTE(
    IDM VARCHAR(10),
    IDP VARCHAR(10),
    IDT VARCHAR(10),
    QUANTITE NUMBER(10,0),
    PRIX NUMBER(10,0),
    CONSTRAINT PK_CVENTE PRIMARY KEY(IDM, IDP, IDT)
  );
INSERT INTO CVENTE
SELECT IDM,IDP,IDT,Sum(QUANTITE), SUM(PRIX) FROM VENTE GROUP BY IDP,IDM,IDT 
UNION
SELECT IDM,IDP,'ALL',Sum(QUANTITE), SUM(PRIX) FROM VENTE GROUP BY IDP,IDM 
UNION
SELECT IDM,'ALL',IDT,Sum(QUANTITE), SUM(PRIX) FROM VENTE GROUP BY IDM,IDT 
UNION
SELECT 'ALL',IDP,IDT,Sum(QUANTITE), SUM(PRIX) FROM VENTE GROUP BY IDP,IDT 
UNION
SELECT IDM,'ALL','ALL',SUM(QUANTITE), SUM(PRIX) FROM VENTE GROUP BY IDM 
UNION
SELECT 'ALL',IDP,'ALL',SUM(QUANTITE), SUM(PRIX) FROM VENTE GROUP BY IDP 
UNION
SELECT 'ALL','ALL',IDT,SUM(QUANTITE), SUM(PRIX) FROM VENTE GROUP BY IDT 
UNION
SELECT 'ALL','ALL','ALL',SUM(QUANTITE), SUM(PRIX) FROM VENTE;

SELECT *
FROM CVENTE;

---3)---
  ---3.1)---
    SELECT QUANTITE FROM CVENTE WHERE IDM = '100' AND IDP ='ALL' AND IDT='ALL';
  ---3.2)---
    SELECT PRIX CA FROM CVENTE WHERE IDM = 'ALL' AND IDP ='ALL' AND IDT='1';
  ---3.3)---
    SELECT PRIX CA_GLOBAL FROM CVENTE WHERE IDM = 'ALL' AND IDP ='ALL' AND IDT='ALL';
  --3.4)---
    SELECT IDM,QUANTITE  FROM CVENTE WHERE QUANTITE = (SELECT MAX(QUANTITE) FROM CVENTE WHERE IDP ='9987' AND IDM !='ALL') AND IDP ='9987';
    
---4)---
  SELECT COUNT(DISTINCT IDM)*COUNT(DISTINCT IDP)
  FROM CVENTE
  WHERE IDT = 'ALL' AND IDP <> 'ALL' AND IDM <> 'ALL';

---5)---
CREATE OR REPLACE PROCEDURE UPDATE_VENTE (lastupd DATE) AS
    CUR_QUANTITE NUMBER;
    CUR_PRIX NUMBER;
    CURSOR NEW_SALES (lastupd DATE) IS 
    WITH NewSales AS (SELECT IDV, IDM, IDP, V.IDT, QUANTITE, PRIX FROM VENTE V JOIN TEMPS TPS ON V.IDT = TPS.IDT WHERE DATEV > lastupd)
    SELECT    IDM, IDP, IDT, QUANTITE, PRIX
    FROM      NewSales
    GROUP BY  IDM, IDP, IDT, QUANTITE, PRIX
    UNION
    SELECT    IDM, IDP, 'ALL', SUM(QUANTITE), SUM(PRIX)
    FROM      NewSales
    GROUP BY  IDM, IDP, 'ALL'
    UNION
    SELECT    IDM, 'ALL', IDT, SUM(QUANTITE), SUM(PRIX)
    FROM      NewSales
    GROUP BY  IDM, 'ALL', IDT
    UNION
    SELECT    'ALL', IDP, IDT, SUM(QUANTITE), SUM(PRIX)
    FROM      NewSales
    GROUP BY  'ALL', IDP, IDT
    UNION
    SELECT    IDM, 'ALL', 'ALL', SUM(QUANTITE), SUM(PRIX)
    FROM      NewSales
    GROUP BY  IDM, 'ALL', 'ALL'
    UNION
    SELECT    'ALL', IDP, 'ALL', SUM(QUANTITE), SUM(PRIX)
    FROM      NewSales
    GROUP BY  'ALL', IDP, 'ALL'
    UNION
    SELECT    'ALL', 'ALL', IDT, SUM(QUANTITE), SUM(PRIX)
    FROM      NewSales
    GROUP BY  'ALL', 'ALL', IDT
    UNION
    SELECT    'ALL', 'ALL', 'ALL', SUM(QUANTITE), SUM(PRIX)
    FROM      NewSales
    GROUP BY  'ALL', 'ALL', 'ALL';
BEGIN
  FOR I IN NEW_SALES (lastupd) LOOP
    IF I.IDT <> 'ALL' THEN 
      INSERT INTO CVENTE VALUES (I.IDM, I.IDP, I.IDT, I.Quantite, I.Prix);
    ELSE 
      SELECT QUANTITE, Prix INTO CUR_QUANTITE, CUR_PRIX FROM CVENTE WHERE IDM = I.IDM AND IDP = I.IDP AND IDT = I.IDT;
      UPDATE CVENTE SET QUANTITE = CUR_QUANTITE + I.QUANTITE, PRIX = CUR_PRIX + I.PRIX WHERE IDM = I.IDM AND IDP = I.IDP AND IDT = I.IDT;
    END IF;
    DBMS_OUTPUT.PUT_LINE(I.IDM||' '||I.IDT||' '||I.IDP||' '||I.QUANTITE||' '||I.PRIX);
  END LOOP;
END;

INSERT INTO TEMPS VALUES (8, TO_DATE('14/10/10','DD/MM/YY'));
INSERT INTO VENTE VALUES (23, 109, 9988, 8, 15, 3);

DECLARE
LAST_DATE DATE;
BEGIN
LAST_DATE := TO_DATE('14/10/10','DD/MM/YY');
UPDATE_VENTE (LAST_DATE);
END;

---6)--- 
DROP TABLE D_LIEU;
CREATE TABLE D_LIEU (
	IdD1 VARCHAR2(10 BYTE), 
	IdL1 VARCHAR2(10 BYTE), 
	IdL2 VARCHAR2(10 BYTE), 
	IdL3 VARCHAR2(10 BYTE), 
	IdL4 VARCHAR2(10 BYTE), 
	IdL5 VARCHAR2(10 BYTE), 
	NomL VARCHAR2(30 BYTE), 
	PRIMARY KEY (IdD1));


---7)---


---8)---


---9)---
  CREATE TABLE D_TEMPS
(
  IDT VARCHAR2(10),
  DATEV VARCHAR2(10),
  CONSTRAINT PK_DTEMPS PRIMARY KEY(IDT)
)

---10)---
