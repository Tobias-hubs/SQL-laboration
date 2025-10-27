                        -- Task 1
-- Create a table with all columns from moon_mission
-- outcome = 'Successful', by CREATE TABLE ... AS SELECT
-- DROP TABLE IF EXISTS successful_mission;
-- CREATE TABLE successful_mission AS
   -- SELECT
        -- mission_id,
      --  spacecraft,
      --  launch_date,
      --  carrier_rocket,
    --    operator,
    --    mission_type,
    --    outcome
  --  FROM moon_mission
-- where outcome = 'Successful';

-- Verify
-- SELECT COUNT(*) AS count_of_successful_missions FROM successful_mission;
-- SELECT * FROM successful_mission LIMIT 5;


                        -- Task 2
-- Create a database with the following tables:
-- author, language, book, bookstore, inventory
--
DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;
USE bookstore;
SELECT DATABASE();
SHOW TABLES;

DROP TABLE IF EXISTS author;
CREATE TABLE author (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE

);

DROP TABLE IF EXISTS language;
CREATE TABLE language (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE
);

DROP TABLE IF EXISTS book;
CREATE TABLE book (
    isbn CHAR(13) PRIMARY KEY,
    title VARCHAR(100),
    language_id INT,
    price DECIMAL(10,2),
    publication_date DATE,
    author_id INT,
    FOREIGN KEY (language_id) REFERENCES language(id),
    FOREIGN KEY (author_id) REFERENCES author(id)
);

DROP TABLE IF EXISTS store;
CREATE TABLE store (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(100)

);

DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory (
    store_id INT,
    isbn CHAR(13),
    amount INT CHECK (amount >= 0),
    PRIMARY KEY (store_id, isbn),
    FOREIGN KEY (store_id) REFERENCES store(id),
    FOREIGN KEY (isbn) REFERENCES book(isbn)
);


INSERT INTO author (first_name, last_name, date_of_birth)
VALUES
    ('John', 'Doe', '1980-01-01'),
   ('Tobias', 'Larsson', '1999-07-06');

INSERT INTO language (name)
VALUES
    ('Swedish'),
    ('English');

INSERT INTO book (isbn, title, language_id, price, publication_date, author_id)
VALUES
    ('9781234567890', 'The Hobbit', 1, 19.99, '2010-01-01', 1),
    ('9781234567891', 'The Lord of the Rings', 2, 29.99, '2011-01-01', 2),
    ('9780008710279','This Way Up', 1, 21.33, '2025-10-23', 2);

INSERT INTO store (name, city)
VALUES
    ('Bokhörnan', 'Göteborg'),
    ('Bokcirkeln', 'Stockholm');

INSERT INTO inventory (store_id, isbn, amount)
VALUES
    (1, '9781234567890', 5 ),
    (2, '9781234567891', 10),
    (1, '9780008710279', 3);

-- Verify
SELECT * FROM author;
SELECT * FROM book;
SELECT * FROM store;
SELECT * FROM language;
SELECT * FROM inventory;

-- Total book value
DROP VIEW IF EXISTS total_author_book_value;
CREATE VIEW total_author_book_value AS
    SELECT
        CONCAT(a.first_name, ' ', a.last_name) AS name,
        TIMESTAMPDIFF(YEAR, a.date_of_birth, CURDATE()) AS age,
        COUNT(DISTINCT b.title) AS book_title_count,
        IFNULL(SUM(b.price * i.amount), 0) AS inventory_value
FROM author a
LEFT JOIN book b ON a.id = b.author_id
LEFT JOIN inventory i ON b.isbn = i.isbn
GROUP BY a.id;

SELECT * FROM total_author_book_value;

-- Create dev-account
CREATE USER IF NOT EXISTS 'dev_user'@'localhost' IDENTIFIED BY 'devpass';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON bookstore.* TO 'dev_user'@'localhost';

-- Create webserver account
CREATE USER IF NOT EXISTS 'web_user'@'localhost' IDENTIFIED BY 'webpass';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO 'web_user'@'localhost';

-- Limit creation of new users or databases
REVOKE CREATE USER, CREATE ON *.* FROM 'dev_user'@'localhost', 'web_user'@'localhost';

FLUSH PRIVILEGES;