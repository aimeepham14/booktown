-- ### Order
-- 1. Find all subjects sorted by subject
booktown=# SELECT subjects FROM subjects;
             subjects             
----------------------------------
 (0,Arts,"Creativity St")
 (1,Business,"Productivity Ave")
 (2,"Children's Books","Kids Ct")
 (3,Classics,"Academic Rd")
 (4,Computers,"Productivity Ave")
 (5,Cooking,"Creativity St")
 (6,Drama,"Main St")
 (7,Entertainment,"Main St")
 (8,History,"Academic Rd")
 (9,Horror,"Black Raven Dr")
 (10,Mystery,"Black Raven Dr")
 (11,Poetry,"Sunset Dr")
 (12,Religion,)
 (13,Romance,"Main St")
 (14,Science,"Productivity Ave")
 (15,"Science Fiction","Main St")
(16 rows)


-- 2. Find all subjects sorted by location

booktown=# SELECT * FROM subjects;
 id |     subject      |     location     
----+------------------+------------------
  0 | Arts             | Creativity St
  1 | Business         | Productivity Ave
  2 | Children's Books | Kids Ct
  3 | Classics         | Academic Rd
  4 | Computers        | Productivity Ave
  5 | Cooking          | Creativity St
  6 | Drama            | Main St
  7 | Entertainment    | Main St
  8 | History          | Academic Rd
  9 | Horror           | Black Raven Dr
 10 | Mystery          | Black Raven Dr
 11 | Poetry           | Sunset Dr
 12 | Religion         | 
 13 | Romance          | Main St
 14 | Science          | Productivity Ave
 15 | Science Fiction  | Main St
(16 rows)


-- ### Where
-- 3. Find the book "Little Women"

booktown=# SELECT * FROM books WHERE title = 'Little Women';
 id  |    title     | author_id | subject_id 
-----+--------------+-----------+------------
 190 | Little Women |        16 |          6
(1 row)


-- 4. Find all books containing the word "Python"

booktown=# SELECT * FROM books WHERE TITLE LIKE 'P%';
  id   |        title         | author_id | subject_id 
-------+----------------------+-----------+------------
 41473 | Programming Python   |      7805 |          4



-- 5. Find all subjects with the location "Main St" sort them by subject

booktown=# SELECT * FROM subjects WHERE location = 'Main St';
 id |     subject     | location 
----+-----------------+----------
  6 | Drama           | Main St
  7 | Entertainment   | Main St
 13 | Romance         | Main St
 15 | Science Fiction | Main St
(4 rows)

-- ### Joins

-- 6. Find all books about Computers and list ONLY the book titles

booktown=# SELECT title FROM books WHERE subject_id = 4;
        title         
----------------------
 Programming Python
 Learning Python
 Perl Cookbook
 Practical PostgreSQL
(4 rows)


-- 7. Find all books and display a result table with ONLY the following columns
-- 	* Book title
-- 	* Author's first name
-- 	* Author's last name
-- 	* Book subject

booktown=# SELECT books.title, authors.first_name, authors.last_name, subjects.subject FROM authors JOIN books ON authors.id=books.author_id JOIN subjects ON subjects.id=books.subject_id;
            title            |    first_name    |  last_name   |     subject      
-----------------------------+------------------+--------------+------------------
 Practical PostgreSQL        | John             | Worsley      | Computers
 Franklin in the Dark        | Paulette         | Bourgeois    | Children's Books
 The Velveteen Rabbit        | Margery Williams | Bianco       | Classics
 Little Women                | Louisa May       | Alcott       | Drama
 The Shining                 | Stephen          | King         | Horror
 Dune                        | Frank            | Herbert      | Science Fiction
 Dynamic Anatomy             | Burne            | Hogarth      | Arts
 Goodnight Moon              | Margaret Wise    | Brown        | Children's Books
 The Tell-Tale Heart         | Edgar Allen      | Poe          | Horror
 Programming Python          | Mark             | Lutz         | Computers
 Learning Python             | Mark             | Lutz         | Computers
 Perl Cookbook               | Tom              | Christiansen | Computers
 2001: A Space Odyssey       | Arthur C.        | Clarke       | Science Fiction
 The Cat in the Hat          | Theodor Seuss    | Geisel       | Children's Books
 Bartholomew and the Oobleck | Theodor Seuss    | Geisel       | Children's Books


-- 8. Find all books that are listed in the stock table
-- 	* Sort them by retail price (most expensive first)
-- 	* Display ONLY: title and price


booktown=# SELECT books.title, stock.retail FROM stock JOIN editions ON stock.isbn=editions.isbn JOIN books ON editions.book_id=books.id ORDER BY stock.stock DESC;
            title            | retail 
-----------------------------+--------
 Dune                        |  45.95
 Dune                        |  21.95
 The Tell-Tale Heart         |  24.95
 The Shining                 |  36.95
 Goodnight Moon              |  28.95
 The Cat in the Hat          |  32.95
 Little Women                |  23.95
 The Tell-Tale Heart         |  21.95
 The Shining                 |  28.95
 The Velveteen Rabbit        |  24.95
 Dynamic Anatomy             |  28.95
 Franklin in the Dark        |  23.95
 Bartholomew and the Oobleck |  16.95
 2001: A Space Odyssey       |  22.95
 2001: A Space Odyssey       |  46.95
 The Cat in the Hat          |  23.95
(16 rows)



-- 9. Find the book "Dune" and display ONLY the following columns
-- 	* Book title
-- 	* ISBN number
-- 	* Publisher name
-- 	* Retail price

booktown=# SELECT books.title, editions.isbn, stock.retail, publishers.id FROM books, editions, stock, publishers WHERE title = 'Dune';
booktown=# SELECT books.title, editions.isbn, publishers.name, stock.retail FROM books
booktown-# JOIN editions ON books.id = editions.book_id
booktown-# JOIN publishers ON editions.publisher_id = publishers.id
booktown-# JOIN stock ON editions.isbn = stock.isbn
booktown-# WHERE title = 'Dune';
 title |    isbn    |   name    | retail 
-------+------------+-----------+--------
 Dune  | 0441172717 | Ace Books |  21.95
 Dune  | 044100590X | Ace Books |  45.95
(2 rows)



-- 10. Find all shipments sorted by ship date display a result table with ONLY the following columns:
-- 	* Customer first name
-- 	* Customer last name
-- 	* ship date
-- 	* book title

booktown=# SELECT customers.first_name, customers.last_name, shipments.ship_date, books.title FROM shipments
booktown-# JOIN editions ON shipments.isbn = editions.isbn
booktown-# JOIN books on books.id = editions.book_id
booktown-# JOIN customers ON shipments.customer_id = customers.id
booktown-# ORDER BY shipments.ship_date;
 first_name | last_name |       ship_date        |            title            
------------+-----------+------------------------+-----------------------------
 Owen       | Bollman   | 2001-08-05 09:34:04-07 | Little Women
 Laura      | Bennett   | 2001-08-06 07:49:44-07 | Goodnight Moon
 Chad       | Allen     | 2001-08-06 09:29:21-07 | The Cat in the Hat
 Annie      | Jackson   | 2001-08-06 11:46:36-07 | Bartholomew and the Oobleck
 Annie      | Jackson   | 2001-08-07 10:58:36-07 | Bartholomew and the Oobleck
 Royce      | Morrill   | 2001-08-07 11:31:57-07 | The Tell-Tale Heart
 Christine  | Holloway  | 2001-08-07 11:56:42-07 | 2001: A Space Odyssey
 Eric       | Morrill   | 2001-08-07 13:00:48-07 | Little Women
 Jonathan   | Anderson  | 2001-08-08 08:36:44-07 | The Shining
 Ed         | Gould     | 2001-08-08 09:53:46-07 | The Shining
 Annie      | Jackson   | 2001-08-08 10:46:13-07 | Bartholomew and the Oobleck
 Dave       | Olson     | 2001-08-09 07:30:07-07 | The Velveteen Rabbit
 Wendy      | Black     | 2001-08-09 09:30:46-07 | The Velveteen Rabbit
 Rich       | Thomas    | 2001-08-10 07:29:52-07 | Franklin in the Dark
 Jean       | Black     | 2001-08-10 08:29:42-07 | The Tell-Tale Heart
 Eric       | Morrill   | 2001-08-10 13:47:52-07 | The Cat in the Hat
 Annie      | Jackson   | 2001-08-11 09:55:05-07 | Bartholomew and the Oobleck
 Richard    | Brown     | 2001-08-11 10:52:34-07 | Goodnight Moon
 James      | Williams  | 2001-08-11 13:34:08-07 | The Cat in the Hat
 Kate       | Gerdes    | 2001-08-12 08:46:35-07 | Dune
 Jean       | Owens     | 2001-08-12 12:09:47-07 | Franklin in the Dark
 Owen       | Becker    | 2001-08-12 13:39:22-07 | The Shining
 Julie      | Bollman   | 2001-08-13 09:42:10-07 | The Cat in the Hat
 Kathy      | Corner    | 2001-08-13 09:47:04-07 | The Cat in the Hat
 Tim        | Owens     | 2001-08-14 07:33:47-07 | Dynamic Anatomy
 Trevor     | Young     | 2001-08-14 08:42:58-07 | Dune
 Chuck      | Brown     | 2001-08-14 10:36:41-07 | The Shining
 Adam       | Holloway  | 2001-08-14 13:41:39-07 | The Tell-Tale Heart
 Jenny      | King      | 2001-08-14 13:45:51-07 | The Shining
 Tammy      | Robinson  | 2001-08-14 13:49:00-07 | Franklin in the Dark
 James      | Clark     | 2001-08-15 11:57:40-07 | Goodnight Moon
 Shirley    | Gould     | 2001-08-15 14:02:01-07 | 2001: A Space Odyssey
 Jenny      | King      | 2001-09-14 16:46:32-07 | The Cat in the Hat
 Annie      | Jackson   | 2001-09-14 17:42:22-07 | The Cat in the Hat
 Annie      | Jackson   | 2001-09-22 11:23:28-07 | Bartholomew and the Oobleck
 Annie      | Jackson   | 2001-09-22 20:58:56-07 | Bartholomew and the Oobleck
(36 rows)




-- ### Grouping and Counting

-- 11. Get the COUNT of all books

booktown=# SELECT COUNT(*) FROM books;
 count 
-------
    15
(1 row)

-- 12. Get the COUNT of all Locations


booktown=# SELECT COUNT(location) FROM subjects;
 count 
-------
    15
(1 row)


-- 13. Get the COUNT of each unique location in the subjects table. Display the count and the location name. (hint: requires GROUP BY).

booktown=# SELECT location, COUNT(location) FROM subjects GROUP BY location;
     location     | count 
------------------+-------
                  |     0
 Sunset Dr        |     1
 Kids Ct          |     1
 Black Raven Dr   |     2
 Creativity St    |     2
 Academic Rd      |     2
 Main St          |     4
 Productivity Ave |     3
(8 rows)



-- 14. List all books. Display the book_id, title, and a count of how many editions each book has. (hint: requires GROUP BY and JOIN)

booktown=# SELECT books.id, books.title, COUNT(edition)
booktown-# FROM books
booktown-# FULL OUTER JOIN editions ON books.id = editions.book_id
booktown-# GROUP BY books.id
booktown-# ;
  id   |            title            | count 
-------+-----------------------------+-------
 41477 | Learning Python             |     0
 25908 | Franklin in the Dark        |     1
 41478 | Perl Cookbook               |     0
   190 | Little Women                |     1
  1501 | Goodnight Moon              |     1
   156 | The Tell-Tale Heart         |     2
 41472 | Practical PostgreSQL        |     0
  2038 | Dynamic Anatomy             |     1
  7808 | The Shining                 |     2
  4267 | 2001: A Space Odyssey       |     2
 41473 | Programming Python          |     1
  1234 | The Velveteen Rabbit        |     1
  4513 | Dune                        |     2
  1608 | The Cat in the Hat          |     2
  1590 | Bartholomew and the Oobleck |     1
(15 rows)




