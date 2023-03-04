--Carti + info
SELECT * FROM Carte;

--Categorii
SELECT * FROM Categorie;

--Limbi
SELECT * FROM Limba;


--Carti + autor
SELECT titlu, CONCAT(Autor.nume,' ', Autor.prenume) AS Autor
FROM Carte 
JOIN Carte_Autor ON Carte.carteId = Carte_Autor.carteId 
JOIN Autor ON Autor.autorId = Carte_Autor.autorId;

--Editurile ordonate descrescator in functie de nume
SELECT nume
FROM Editura
ORDER BY nume DESC;

--Autori ordonati in ordine crescatoare in functie de numarul cartilor scrise
SELECT CONCAT(Autor.nume,' ', Autor.prenume) AS Autor, SUM(Carte.bucati) AS numarCarti
FROM Autor 
JOIN Carte_Autor ON Autor.autorId = Carte_Autor.autorId 
JOIN Carte on Carte_Autor.carteId = Carte.carteId
GROUP BY Autor.nume, Autor.prenume
ORDER BY SUM(bucati) 

--Carti apartinand editurii ,,Litera,, ordonate descrescator dupa pret
SELECT titlu, CONCAT(Autor.nume,' ', Autor.prenume) AS Autor, pret 
FROM Carte 
JOIN Carte_Autor ON Carte.carteId = Carte_Autor.carteId
JOIN Autor ON Autor.autorId = Carte_Autor.autorid
JOIN Editura ON Carte.edituraId = Editura.edituraId
WHERE Editura.nume = 'Litera'
ORDER BY pret DESC;


--Tara + Oras unde gasim autori
SELECT Tara, Oras.oras
FROM Tara
JOIN Oras on Tara.taraId = Oras.taraId
JOIN Adresa on Oras.orasid = Adresa.orasid 
JOIN Autor on Adresa.adresaId = Autor.adresaId
GROUP BY Tara, Oras.oras;



--Cartea cu pretul cel mai mare
SELECT Carte.carteId, titlu, CONCAT(Autor.nume,' ', Autor.prenume) AS Autor, pret 
FROM Carte
JOIN Carte_Autor ON Carte.carteId = Carte_Autor.carteId
JOIN Autor ON Autor.autorId = Carte_Autor.autorId
WHERE pret = (SELECT MAX(pret) FROM Carte);


--Carti ce se incadreaza in categoria ,,Istorie,,
SELECT DISTINCT Carte.carteId, titlu
FROM Carte
JOIN Carte_Categorie on Carte.carteId = Carte_Categorie.carteId
WHERE categorieId IN (SELECT categorieid FROM Categorie WHERE categorie = 'Istorie');

--Carti ce se incadreaza in categoria ,,Romance,,
SELECT DISTINCT Carte.carteId, titlu
FROM Carte
JOIN Carte_Categorie on Carte.carteId = Carte_Categorie.carteId
WHERE categorieId IN (SELECT categorieid FROM Categorie WHERE categorieid = 26);

ALTER TABLE Carte
ADD CHECK (pagini > 0);

ALTER TABLE Carte
ADD CHECK (pret >= 0);


ALTER TABLE Adresa
ADD CHECK (numar > 0);


--Cartea cu pretul cel mai mic
SELECT Carte.carteId, titlu, CONCAT(Autor.nume,' ', Autor.prenume) AS Autor, pret 
FROM Carte
JOIN Carte_Autor ON Carte.carteId = Carte_Autor.carteId
JOIN Autor ON Autor.autorId = Carte_Autor.autorId
WHERE pret = (SELECT MIN(pret) FROM Carte);


--Autorul cu cele mai multe carti
SELECT top 1 CONCAT(Autor.nume,' ', Autor.prenume) AS Autor, SUM(Carte.bucati) AS numarCarti 
FROM Autor
JOIN Carte_Autor ON Autor.autorId= Carte_Autor.autorId 
JOIN Carte ON Carte_Autor.carteId = Carte.carteId
GROUP BY Autor.nume, Autor.prenume
ORDER BY SUM(bucati) DESC;


--Carti care au cel putin 200 pagini
SELECT Carte.carteId, titlu, CONCAT(Autor.nume,' ', Autor.prenume) AS Autor, pagini
FROM Carte
JOIN Carte_Autor ON Carte.carteId = Carte_Autor.carteId
JOIN Autor ON Autor.autorId = Carte_Autor.autorId
WHERE pagini >= 200;

--Categoriile ordonate descrescator in functie de numarul de carti
SELECT Categorie, COUNT(Carte.carteId) AS numarCarti 
FROM Categorie
JOIN Carte_Categorie ON Categorie.categorieId = Carte_Categorie.categorieId
JOIN Carte ON Carte_Categorie.carteId = Carte.carteId
GROUP BY Categorie
ORDER BY COUNT(carte.carteId) DESC;


ALTER TABLE Carte
ADD CHECK (anAparitie >= 0);

--Editurile ce au cartile lui HOOVER COLLEEN
SELECT Editura.edituraId, Editura.nume 
FROM Editura
    JOIN Carte ON Editura.edituraId = carte.edituraId
    JOIN Carte_Autor ON Carte.carteId = Carte_Autor.carteId
    JOIN Autor ON Autor.autorid = Carte_Autor.autorid
WHERE Autor.nume = 'HOOVER' AND Autor.prenume = 'COLLEEN';





















