--Carti + info
SELECT * FROM Carte;

--Categorii
SELECT * FROM Categorie;

--Limbi
SELECT * FROM Limba;

--Carti + autor
SELECT titlu, CONCAT(Autor.nume,' ', Autor.prenume) AS Autor
FROM Carte 
JOIN Carte_Autor ON carte.carteId = Carte_Autor.carteId JOIN Autor ON Autor.autorId = Carte_Autor.autorId;

--Autori ordonati in ordine crescatoare in functie de numarul cartilor scrise
SELECT CONCAT(Autor.nume,' ', Autor.prenume) AS Autor, SUM(Carte.bucati) AS numarCarti
FROM Autor JOIN Carte_Autor ON Autor.autorId = Carte_Autor.autorId JOIN Carte on Carte_Autor.carteId = Carte.carteId
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

--Editurile ordonate descrescator in functie de nume
SELECT nume
FROM Editura
ORDER BY nume DESC;


--Carti ce se incadreaza in categoria ,,Istorie,,
SELECT DISTINCT Carte.carteId, titlu
FROM Carte
JOIN Carte_Categorie on Carte.carteId = Carte_Categorie.carteId
WHERE categorieId IN (SELECT categorieid FROM Categorie WHERE categorie = 'Istorie');

/*
--Books and their authors ordered descendently by price
SELECT title, CONCAT(a.first_name,' ', a.last_name) AS Author, priceperunit FROM book JOIN book_author ba ON book.bookid = ba.bookid JOIN author a ON a.authorid = ba.authorid
ORDER BY priceperunit DESC;

--the author who has the most books in out library
SELECT CONCAT(a.first_name,' ', a.last_name) AS Author, SUM(b.unitsinstock) AS nr_books FROM author a JOIN book_author ba on a.authorid = ba.authorid JOIN book b on ba.bookid = b.bookid
GROUP BY a.first_name, a.last_name
ORDER BY SUM(unitsinstock) DESC
LIMIT 1;



--the cities in function of the number of books
SELECT city, SUM(unitsinstock) FROM city JOIN address a on city.cityid = a.cityid JOIN author a2 on a.addressid = a2.addressid JOIN book_author ba on a2.authorid = ba.authorid JOIN book b on ba.bookid = b.bookid
GROUP BY city
ORDER BY SUM(unitsinstock) DESC;





--countries and their cities where there are publishers
SELECT country, c.city, p.name FROM country JOIN city c on country.countryid = c.countryid JOIN address a on c.cityid = a.cityid JOIN publisher p on a.addressid = p.addressid
GROUP BY country, c.city, p.name;



--Books in english containing romance
SELECT book.bookid, title, CONCAT(a.first_name,' ', a.last_name) AS Author FROM book
    JOIN book_author ba on book.bookid = ba.bookid
    JOIN author a on a.authorid = ba.authorid
    JOIN language l on book.languageid = l.languageid
    JOIN book_category bc on book.bookid = bc.bookid
    JOIN category c on bc.categoryid = c.categoryid
WHERE language = 'english' AND category = 'Romance';

--books with at least 500 pages
SELECT book.bookid, title, CONCAT(a.first_name,' ', a.last_name) AS Author FROM book
    JOIN book_author ba on book.bookid = ba.bookid
    JOIN author a on a.authorid = ba.authorid
WHERE pages >= 500;

--publishers that own Neil Gaiman's books
SELECT publisher.publisherid, name FROM publisher
    JOIN book b on publisher.publisherid = b.publisherid
    JOIN book_author ba on b.bookid = ba.bookid
    JOIN author a on a.authorid = ba.authorid
WHERE first_name = 'Neil' AND last_name = 'Gaiman';

--Most expensive book
SELECT book.bookid, title, CONCAT(a.first_name,' ', a.last_name) AS Author, priceperunit FROM book
    JOIN book_author ba on book.bookid = ba.bookid
    JOIN author a on a.authorid = ba.authorid
WHERE priceperunit = (SELECT MAX(priceperunit) FROM book);

--least expensive book
SELECT book.bookid, title, CONCAT(a.first_name,' ', a.last_name) AS Author, priceperunit FROM book
    JOIN book_author ba on book.bookid = ba.bookid
    JOIN author a on a.authorid = ba.authorid
WHERE priceperunit = (SELECT MIN(priceperunit) FROM book);



--the address of the publisher who published the most expensive book
SELECT address as "id, postalcode, housePhone, houseNr, CityID, street", city FROM address JOIN city c on address.cityid = c.cityid
    WHERE addressid = (SELECT addressid FROM publisher WHERE publisherid =
                           (SELECT publisherid FROM book WHERE bookid =
                                     (SELECT bookid FROM book WHERE priceperunit = (SELECT MAX(priceperunit) FROM book))));

--most used categories
SELECT category, COUNT(b.bookid) AS "Nr of books" FROM category
    JOIN book_category bc on category.categoryid = bc.categoryid
    JOIN book b on bc.bookid = b.bookid
GROUP BY category
ORDER BY COUNT(b.bookid) DESC;

ALTER TABLE address
ADD CHECK (housenumber > 0);

ALTER TABLE book
ADD CHECK (pages > 0);

ALTER TABLE category
ADD UNIQUE(category);

ALTER TABLE book
ADD CHECK (unitsinstock >= 0);

ALTER TABLE book
ADD CHECK (pages >= 0);

ALTER TABLE book
ADD CHECK (releaseyear >= 0);

ALTER TABLE author
ADD UNIQUE(email);
*/