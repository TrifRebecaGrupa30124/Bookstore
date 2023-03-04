/*Numele beneficiarilor din Bucuresti?*/
SELECT Nume FROM Beneficiar
WHERE Oras = 'Bucuresti'

/*Numele beneficiarilor care sunt din Cluj sau Bucuresti?*/
SELECT Nume FROM Beneficiar
WHERE Oras IN('Cluj','Bucuresti')

/*Numele beneficiarilor care nu sunt din Cluj sau Bucuresti?*/
SELECT Nume FROM Beneficiar
WHERE Oras NOT IN('Cluj','Bucuresti')

/*Numele produselor pentru care s-a incheiat cel putin o tranzactie?*/
SELECT Nume FROM Produs, Tranzactii
WHERE Produs.CodP=Tranzactii.CodP

/*Numele beneficiarilor din Bucuresti care au cumparat calculatoare?*/
 SELECT Beneficiar.Nume FROM Beneficiar, Produs, Tranzactii 
WHERE Beneficiar.Oras='Bucuresti' AND Produs.Nume='calculatoare' 
AND Beneficiar.CodB=Tranzactii.CodB 
AND Produs.CodP=Tranzactii.CodP

/*Numele beneficiarilor care au cereri de calculatoare?*/
SELECT Beneficiar.Nume FROM Beneficiar, Produs, Cerere
WHERE Beneficiar.Oras='Bucuresti' AND Produs.Nume='calculatoare' 
AND Beneficiar.CodB=Cerere.CodB 
AND Produs.CodP=Cerere.CodP

SELECT Produs.Nume
FROM Produs
INNER JOIN Tranzactii ON Tranzactii.CodP = Produs.CodP
/*g.Numele beneficiarilor care au cereri de calculatoare si automobile?*/
SELECT DISTINCT Beneficiar.Nume
FROM Beneficiar, Produs, Cerere
WHERE Beneficiar.CodB=Cerere.CodB
AND Produs.Nume = 'calculatoare'
INTERSECT(SELECT DISTINCT Beneficiar.Nume 
FROM Cerere, Produs, Beneficiar
WHERE Cerere.CodP = Produs.CodP
AND Produs.Nume = 'automobil'
AND Beneficiar.CodB = Cerere.CodB)

/*h. Numele beneficiarilor care au cumparat cel putin doua tipuri de produse?*/
SELECT DISTINCT Beneficiar.Nume 
FROM Cerere C1, Cerere C2, Beneficiar 
WHERE Beneficiar.CodB= C1.CodB AND C1.CodB=C2.CodB AND C1.CodP=C2.CodB

/*i. Numele beneficiarilor care nu au nicio cerere?*/
SELECT Beneficiar.Nume 
FROM Beneficiar 
WHERE Beneficiar.CodB NOT IN( SELECT CodB FROM Cerere)

/*j. Numele beneficiarilor care nu au cereri de calculatoare, nici automobile?*/
SELECT DISTINCT Beneficiar.Nume 
FROM Beneficiar 
WHERE Beneficiar.CodB NOT IN(
SELECT CodB 
FROM Cerere, Produs 
WHERE Cerere.CodP= Produs.CodP
AND ( Produs.Nume= 'calculatoare' OR Produs.Nume='automobile'))

/*k. Numele beneficiarilor care au cereri pentru toate tipurile de produse?*/
SELECT DISTINCT Nume 
FROM Beneficiar B
WHERE NOT EXISTS ( SELECT * FROM Produs P WHERE NOT EXISTS ( SELECT * FROM Cerere WHERE B.CodB=Cerere.CodB AND Cerere.CodP=P.CodP))

/*l. Numele beneficiarilor care au cereri pentru toate tipurile de calculatoare si autoturisme?*//*m. Numele beneficiarilor care nu au cereri pentru toate tipurile de produse.*/SELECT DISTINCT Nume FROM Beneficiar B WHERE NOT (NOT EXISTS ( SELECT * FROM Produs P WHERE NOT EXISTS( SELECT * FROM Cerere WHERE B.CodB=Cerere.CodB AND Cerere.CodP=P.CodP)))/*n. Numele beneficiarilor care au cumparat toate tipurile de produse pentru care au cereri?*/