/* SQL BASIC DATA QUERYING */



/* 1. SIMPLE QUERIES - SELECT, FROM, WHERE, ORDER BY */

CREATE TABLE IMDb_Top_Ten_Movies (id INT PRIMARY KEY, name VARCHAR(50), release_year INT);
INSERT INTO IMDb_Top_Ten_Movies VALUES (1, "The Shawshank Redemption", 1994);
INSERT INTO IMDb_Top_Ten_Movies VALUES (2, "The Godfather", 1972);
INSERT INTO IMDb_Top_Ten_Movies VALUES (3, "The Dark Knight", 2008);
INSERT INTO IMDb_Top_Ten_Movies VALUES (4, "The Godfather Part II", 1974);
INSERT INTO IMDb_Top_Ten_Movies VALUES (5, "The Angry Men", 1957);
INSERT INTO IMDb_Top_Ten_Movies VALUES (6, "Schindler's List", 1993);
INSERT INTO IMDb_Top_Ten_Movies VALUES (7, "The Lord of the Rings: The Return of the King", 2003);
INSERT INTO IMDb_Top_Ten_Movies VALUES (8, "Pulp Fiction", 1994);
INSERT INTO IMDb_Top_Ten_Movies VALUES (9, "The Lord of the Rings: The Fellowship of the Ring", 2001);
INSERT INTO IMDb_Top_Ten_Movies VALUES (10, "The Good, the Bad and the Ugly", 1966);

SELECT * FROM IMDb_Top_Ten_Movies

SELECT * 
FROM IMDb_Top_Ten_Movies 
WHERE release_year >= 1972 
ORDER BY release_year

SELECT *
FROM IMDb_Top_Ten_Movies
WHERE release_year < 1990 OR release_year > 2000



/* 2. CREATING DATABASE AND QUERYING - SUM, CASE */

CREATE TABLE store(id INTEGER PRIMARY KEY, item_name VARCHAR(30), price INT, quantity INT, status VARCHAR(20));
INSERT INTO store VALUES(1,"nutella",10,21,"avail");
INSERT INTO store VALUES(2,"coke",10,32,"avail");
INSERT INTO store VALUES(3,"mars",25,12,"avail");
INSERT INTO store VALUES(4,"kitkat",10,34,"avail");
INSERT INTO store VALUES(5,"pepsi",5,43,"avail");
INSERT INTO store VALUES(6,"dairymilk",10,21,"avail");
INSERT INTO store VALUES(7,"fanta",5,76,"avail");
INSERT INTO store VALUES(8,"cheetos",5,23,"avail");
INSERT INTO store VALUES(9,"doritos",5,28,"avail");
INSERT INTO store VALUES(10,"chips ahoy",10,12,"avail");
INSERT INTO store VALUES(11,"m&ms",5,53,"avail");
INSERT INTO store VALUES(12,"icecream",10,65,"avail");
INSERT INTO store VALUES(13,"twix",15,43,"avail");
INSERT INTO store VALUES(14,"lindt",25,23,"avail");
INSERT INTO store VALUES(15,"oreos",20,23,"avail");

SELECT * FROM store ORDER BY id

SELECT SUM(price) AS total_price, SUM(quantity) AS total_quantity FROM store;

SELECT item_name,price,
CASE
WHEN price>10 THEN "costly"
ELSE "cheap"
END as cheap_or_costly
FROM store;



/* 3. IN AND SUB-QUERIES */

CREATE TABLE artists (id INT PRIMARY KEY, name VARCHAR(50), country VARCHAR (50), genre VARCHAR(50));
INSERT INTO artists VALUES (1, "Justin Bieber", "Canada", "Pop");
INSERT INTO artists VALUES (2, "Rihanna", "US", "Pop");
INSERT INTO artists VALUES (3, "Gloria Estefan", "US", "Pop");
INSERT INTO artists VALUES (4, "Bob Marley", "Jamaica", "Reggae");
INSERT INTO artists VALUES (5, "Taylor Swift", "US", "Pop");
INSERT INTO artists VALUES (6, "Led Zeppelin", "US", "Hard rock");

SELECT * FROM artists

CREATE TABLE songs (id INT PRIMARY KEY, artist VARCHAR(50), title VARCHAR(50));
INSERT INTO songs VALUES (1, "Justin Bieber", "Baby");
INSERT INTO songs VALUES (2, "Taylor Swift", "Shake it off");
INSERT INTO songs VALUES (3, "Rihanna", "Umbrella");
INSERT INTO songs VALUES (4, "Gloria Estefan", "Conga");
INSERT INTO songs VALUES (5, "Led Zeppelin", "Stairway to heaven");
INSERT INTO songs VALUES (6, "Led Zeppelin", "Rock and Roll");

SELECT * FROM songs

SELECT title 
FROM songs 
WHERE artist = "Justin Bieber"

SELECT name 
FROM artists 
WHERE genre = "Pop"

SELECT title 
FROM songs
WHERE artist IN(SELECT name FROM artists WHERE genre = "Pop")



/* 4. HAVING STATEMENTS */

CREATE TABLE books (author VARCHAR(50), title VARCHAR(50), words INT);
INSERT INTO books VALUES ("J.K. Rowling", "Harry Potter and the Philosopher's Stone", 79944);
INSERT INTO books VALUES ("J.K. Rowling", "Harry Potter and the Chamber of Secrets", 85141);
INSERT INTO books VALUES ("J.K. Rowling", "Harry Potter and the Prisoner of Azkaban", 107253);
INSERT INTO books VALUES ("J.K. Rowling", "Harry Potter and the Goblet of Fire", 190637);
INSERT INTO books VALUES ("J.K. Rowling", "Harry Potter and the Order of the Phoenix", 257045);
INSERT INTO books VALUES ("J.K. Rowling", "Harry Potter and the Half-Blood Prince", 168923);
INSERT INTO books VALUES ("J.K. Rowling", "Harry Potter and the Deathly Hallows", 197651);
INSERT INTO books VALUES ("Stephenie Meyer", "Twilight", 118501);
INSERT INTO books VALUES ("Stephenie Meyer", "New Moon", 132807);
INSERT INTO books VALUES ("Stephenie Meyer", "Eclipse", 147930);
INSERT INTO books VALUES ("Stephenie Meyer", "Breaking Dawn", 192196);
INSERT INTO books VALUES ("J.R.R. Tolkien", "The Hobbit", 95022);
INSERT INTO books VALUES ("J.R.R. Tolkien", "Fellowship of the Ring", 177227);
INSERT INTO books VALUES ("J.R.R. Tolkien", "Two Towers", 143436);
INSERT INTO books VALUES ("J.R.R. Tolkien", "Return of the King", 134462);
    
SELECT author, SUM(words) AS total_words FROM books 
GROUP BY author 
HAVING total_words > 1000000;

SELECT author, avg(words) AS AVG_words from books 
GROUP BY author 
HAVING AVG_words > 140000;



/* 5. CASE STATEMENTS */

CREATE TABLE student_grades (name VARCHAR(50), number_grade INT, fraction_completed FLOAT);
    
INSERT INTO student_grades VALUES ("Charles", 90, 0.805);
INSERT INTO student_grades VALUES ("Jude", 95, 0.901);
INSERT INTO student_grades VALUES ("Justin", 85, 0.906);
INSERT INTO student_grades VALUES ("Robert", 66, 0.7054);
INSERT INTO student_grades VALUES ("Tom", 76, 0.5013);
INSERT INTO student_grades VALUES ("Hailey", 82, 0.9045);
    
SELECT name, number_grade, ROUND(fraction_completed * 100) as percent_completed FROM student_grades;

SELECT
  COUNT(*) as 'number of students',
  CASE
    WHEN ROUND(fraction_completed * 100) > 90 THEN 'A'
    WHEN ROUND(fraction_completed * 100) > 80 THEN 'B'
    WHEN ROUND(fraction_completed * 100) > 70 THEN 'C'
    ELSE 'F'
  END as 'letter_grade'
FROM student_grades
GROUP BY CASE
  WHEN ROUND(fraction_completed * 100) > 90 THEN 'A'
  WHEN ROUND(fraction_completed * 100) > 80 THEN 'B'
  WHEN ROUND(fraction_completed * 100) > 70 THEN 'C'
  ELSE 'F'
END;



/* 6. INNER JOIN */

CREATE TABLE people (id INT PRIMARY KEY, name VARCHAR(30), age INT);
INSERT INTO people VALUES (1, "Khushi", 21);
INSERT INTO people VALUES (2, "Muskaan", 24);
INSERT INTO people VALUES (3, "Ivy", 3);
INSERT INTO people VALUES (4, "Vandana", 47);
INSERT INTO people VALUES (5, "Deepak", 50);

CREATE TABLE interests (person_id INT, interest VARCHAR(20));
INSERT INTO interests VALUES (1, "Music");
INSERT INTO interests VALUES (1, "Dance");
INSERT INTO interests VALUES (2, "Coding");
INSERT INTO interests VALUES (3, "Sleeping");
INSERT INTO interests VALUES (4, "Talking");
INSERT INTO interests VALUES (5, "Shopping");

SELECT people.name, interests.interest FROM people JOIN interests ON people.id = interests.person_id;

SELECT people.name, interests.interest 
FROM people 
JOIN interests ON people.id = interests.person_id 
WHERE people.name IN ("Khushi");


/* 7. OUTER JOIN */

CREATE TABLE people1 (id INT PRIMARY KEY, name VARCHAR(30), age INT);
INSERT INTO people1 VALUES (1, "Khushi", 21);
INSERT INTO people1 VALUES (2, "Muskaan", 24);
INSERT INTO people1 VALUES (3, "Ivy", 3);
INSERT INTO people1 VALUES (4, "Vandana", 47);
INSERT INTO people1 VALUES (5, "Deepak", 50);

CREATE TABLE interests1 (person_id INT, interest VARCHAR(20));
INSERT INTO interests1 VALUES (1, "Music");
INSERT INTO interests1 VALUES (1, "Dance");
INSERT INTO interests1 VALUES (2, "Coding");
INSERT INTO interests1 VALUES (4, "Talking");
INSERT INTO interests1 VALUES (5, "Shopping");

SELECT people1.name, interests1.interest FROM people1 LEFT JOIN interests1 ON people1.id = interests1.person_id;


CREATE TABLE customers (ID INT, name VARCHAR(50), email VARCHAR(50));
INSERT INTO customers VALUES (1, "Doctor Who", "doctorwho@timelords.com");
INSERT INTO customers VALUES (2, "Harry Potter", "harry@potter.com");
INSERT INTO customers VALUES (3, "Captain Awesome", "captain@awesome.com");

CREATE TABLE orders (customer_id INTEGER, item VARCHAR(50), price REAL);
INSERT INTO orders VALUES (1, "Sonic Screwdriver", 1000.00);
INSERT INTO orders VALUES (2, "High Quality Broomstick", 40.00);
INSERT INTO orders VALUES (1, "TARDIS", 1000000.00);
    
    
SELECT customers.name, customers.email, orders.item, orders.price 
FROM customers 
LEFT JOIN orders ON customers.id=orders.customer_id;

SELECT customers.name, customers.email, SUM(orders.price) AS 'TOTAL_SPENT'
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name, customers.email
ORDER BY 'TOTAL_SPENT' DESC;















