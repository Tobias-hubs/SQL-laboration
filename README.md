# 📚 Bookstore SQL Project – Lab Assignment

This project creates a fully functional MySQL database for a bookstore, including schema design, test data, a summary view, and user access control. It is designed to be executed and tested within a Docker-based MySQL environment.

---

## 🧱 Database Structure

The database is named `bookstore` and includes the following tables:

- `author`: Stores author details (first name, last name, birth date)
- `language`: Stores unique language entries
- `book`: Stores book details including ISBN, title, language, price, publication date, and author reference
- `store`: Represents bookstore locations with name and city
- `inventory`: Tracks book stock per store using a composite primary key (`store_id`, `isbn`)

All tables include appropriate primary and foreign key constraints, and the `inventory.amount` column includes a `CHECK` constraint to prevent negative values.

---

## 📊 View: `total_author_book_value`

This view summarizes key metrics per author:

| Column              | Description                                      |
|---------------------|--------------------------------------------------|
| `name`              | Full name of the author                          |
| `age`               | Age calculated from birth date                   |
| `book_title_count`  | Number of distinct titles written by the author  |
| `inventory_value`   | Total stock value of the author's books          |

---

## 🔐 User Accounts and Permissions

Two MySQL users are created to manage access:

- **dev_user**: Full access to the `bookstore` database (SELECT, INSERT, UPDATE, DELETE, CREATE, DROP). Restricted from creating new databases or users.
- **web_user**: Limited access for web application use (SELECT, INSERT, UPDATE, DELETE). Cannot create or drop tables, databases, or users.

---

## ✅ Status

All components have been tested and verified using Docker and MySQL 8.0. The project is ready for submission.
