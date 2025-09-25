use mavenmovies;
"Q1. Create a table called employees with constraints

Concept:

PRIMARY KEY → uniquely identifies each row.

NOT NULL → column can’t be empty.

CHECK → enforces a condition (like age ≥ 18).

UNIQUE → no duplicate values.

DEFAULT → assigns a value if none is given.";

CREATE TABLE employees (
    emp_id INT PRIMARY KEY NOT NULL,
    emp_name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000
);

"Q2. Purpose of constraints & examples

Concept: Constraints help maintain data integrity. They prevent invalid, duplicate, or inconsistent data.

NOT NULL → ensures a column always has a value.

PRIMARY KEY → ensures each row is unique.

FOREIGN KEY → ensures relationships between tables remain valid.

UNIQUE → prevents duplicate values.

CHECK → validates conditions (like age ≥ 18).



DEFAULT → auto-assigns a value if not given.";

"Q3. Why use NOT NULL? Can PK contain NULL?

NOT NULL ensures the column must always have a value (useful for required fields).

Primary Key cannot contain NULL → because PK is used to uniquely identify each row, and NULL means "unknown", so uniqueness breaks.";


"Q4. Steps to add/remove constraints

To add a constraint: use ALTER TABLE ... ADD CONSTRAINT.

To drop a constraint: use ALTER TABLE ... DROP CONSTRAINT.

Example (Add):";
ALTER TABLE employees
ADD CONSTRAINT chk_age CHECK (age >= 18);


"Example (Drop):"

ALTER TABLE employees
DROP CONSTRAINT chk_age;

"Q5. Consequences of violating constraints

If you try to insert/update/delete data violating constraints → SQL throws an error.

Example:";

INSERT INTO employees (emp_id, emp_name, age, email)
VALUES (1, 'John', 15, 'john@mail.com');

"Q6. Alter products table with constraints

Initial table:";

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

"Add constraints:";
ALTER TABLE products
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

"Q7. INNER JOIN student & class

Concept: INNER JOIN → returns only matching rows between two tables.

Example query:"

SELECT s.student_name, c.class_name
FROM students s
INNER JOIN classes c
ON s.class_id = c.class_id;

"Q8. Orders + Customers + Products (INNER + LEFT JOIN)

Use INNER JOIN to connect orders and customers.

Use LEFT JOIN with products → ensures all products are listed, even if not ordered.

Example query:"

SELECT o.order_id, c.customer_name, p.product_name
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
LEFT JOIN orders o ON od.order_id = o.order_id
LEFT JOIN customers c ON o.customer_id = c.customer_id;

"Q9. Total sales per product (SUM + JOIN)"

SELECT p.product_name, SUM(od.quantity * od.price) AS total_sales
FROM products p
INNER JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_name;

"Q10. Orders + Customers + Products with quantity";

SELECT o.order_id, c.customer_name, od.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id;

"SQL Commands (based on Maven Movies DB)"
"Q1. Identify primary keys and foreign keys in Maven Movies DB

Concept:

Primary Key (PK): uniquely identifies a row (e.g., customer_id in customers).

Foreign Key (FK): refers to PK in another table (used for relationships).

Examples from Sakila/Maven Movies DB:

actor.actor_id → Primary Key.

film.film_id → Primary Key.

inventory.film_id → Foreign Key (links to film).

rental.customer_id → Foreign Key (links to customer).

Difference:

PK → uniqueness in same table.

FK → maintains relationship across tables."

"Q2. List all details of actors";
SELECT * FROM actor;

"Q3. List all customer information";

"Q4. List different countries";
SELECT DISTINCT country 
FROM country;


"Q5. Display all active customers"

SELECT * 
FROM customer
WHERE active = 1;

"Q6. List all rental IDs for customer with ID 1";
SELECT rental_id 
FROM rental
WHERE customer_id = 1;


"Q7. Films with rental duration > 5";
SELECT * 
FROM film
WHERE rental_duration > 5;

"Q8. Count of films with replacement cost > 15 and < 20"
SELECT COUNT(*) AS film_count
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;


"Q9. Count unique first names of actors"
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;


"Q10. First 10 records from customer table";
SELECT * 
FROM customer
LIMIT 10;


"Q11. First 3 customers with first name starting with ‘b’";
SELECT * 
FROM customer
WHERE first_name LIKE 'B%'
LIMIT 3;

"Q12. Names of first 5 movies rated ‘G’";

SELECT title 
FROM film
WHERE rating = 'G'
LIMIT 5;

"Q13. Customers whose first name starts with "a"";
SELECT * 
FROM customer
WHERE first_name LIKE 'A%';

"Q14. Customers whose first name ends with "a"";
SELECT * 
FROM customer
WHERE first_name LIKE '%a';

"Q15. First 4 cities starting & ending with ‘a’";
SELECT city 
FROM city
WHERE city LIKE 'A%a'
LIMIT 4;


"Q16. Customers whose first name contains "NI"";

SELECT * 
FROM customer
WHERE first_name LIKE '%NI%';

		
"Q17. Customers with 'r' in second position";
SELECT * 
FROM customer
WHERE first_name LIKE '_r%';

"Q18. Customers with first name starting with "a" and length ≥ 5";
SELECT * 
FROM customer
WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

"Q19. Customers with first name starting with "a" and ending with "o"";
SELECT * 
FROM customer
WHERE first_name LIKE 'A%o';

"Q20. Films with PG or PG-13 rating";
SELECT * 
FROM film
WHERE rating IN ('PG', 'PG-13');


"Q21. Films with length between 50 and 100";
SELECT * 
FROM film
WHERE length BETWEEN 50 AND 100;

"Q22. Top 50 actors (using LIMIT)"
SELECT * 
FROM actor
LIMIT 50;


"Q23. Distinct film IDs from inventory table";
SELECT DISTINCT film_id
FROM inventory;


"Functions
Aggregate Functions"

"Q1. Total number of rentals";
SELECT COUNT(*) AS total_rentals
FROM rental;

"Q2. Average rental duration (in days)"
SELECT AVG(rental_duration) AS avg_duration
FROM film;

"String Functions

Q3. Display customer names in uppercase";
SELECT UPPER(first_name) AS first_name, 
       UPPER(last_name) AS last_name
FROM customer;

"Q4. Extract month from rental date";
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

"GROUP BY Functions

Q5. Count rentals per customer";
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

"Q6. Total revenue by each store";
SELECT store_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

"Q7. Total rentals per category"
SELECT c.name AS category, COUNT(*) AS rental_count
FROM film_category fc
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

"Q8. Average rental rate per language"
SELECT l.name AS language, AVG(f.rental_rate) AS avg_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

"Joins

Q9. Movie title + customer name who rented it"

SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

"Q10. Actors in “Gone with the Wind”";
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

"Q11. Customers + total spent";
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

"Q12. Movies rented by customers in London";
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.first_name, c.last_name, f.title;

"Advanced Joins + GROUP BY

Q13. Top 5 rented movies";
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;


"Q14. Customers who rented from both stores"
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;

Window Functions

"Q1. Rank customers by total spending"
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;


"Q2. Cumulative revenue per film over time"
SELECT f.title, p.payment_date, 
       SUM(p.amount) OVER (PARTITION BY f.title ORDER BY p.payment_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id;

"Q3. Avg rental duration per film length";

SELECT f.title, f.length,
       AVG(r.return_date - r.rental_date) OVER (PARTITION BY f.length) AS avg_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id;


"Q4. Top 3 films in each category by rental count";
SELECT c.name AS category, f.title,
       COUNT(r.rental_id) AS rental_count,
       RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank_within_category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name, f.title
HAVING RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) <= 3;


"Q5. Monthly revenue trend";
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS revenue
FROM payment
GROUP BY month
ORDER BY month;

"Q6. Customers in top 20% by spending"
WITH spending AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
)
SELECT customer_id, total_spent
FROM (
    SELECT customer_id, total_spent,
           NTILE(5) OVER (ORDER BY total_spent DESC) AS percentile
    FROM spending
) t
WHERE percentile = 1;

"Q7. Running total of rentals per category";
SELECT c.name AS category, r.rental_date,
       COUNT(r.rental_id) OVER (PARTITION BY c.name ORDER BY r.rental_date) AS running_total
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id;

"Q8. Films rented less than avg of their category";
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title, c.name
HAVING COUNT(r.rental_id) < (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(r2.rental_id) AS cnt
        FROM film f2
        JOIN film_category fc2 ON f2.film_id = fc2.film_id
        JOIN category c2 ON fc2.category_id = c2.category_id
        JOIN inventory i2 ON f2.film_id = i2.film_id
        JOIN rental r2 ON i2.inventory_id = r2.inventory_id
        WHERE c2.category_id = c.category_id
        GROUP BY f2.title
    ) sub
);


"Q9. Top 5 months with highest revenue";
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS revenue
FROM payment
GROUP BY month
ORDER BY revenue DESC
LIMIT 5;

"Q10. Difference between rentals per customer & average rentals";
WITH rental_counts AS (
    SELECT customer_id, COUNT(*) AS total_rentals
    FROM rental
    GROUP BY customer_id
),
avg_rentals AS (
    SELECT AVG(total_rentals) AS avg_rentals
    FROM rental_counts
)
SELECT r.customer_id, r.total_rentals, 
       (r.total_rentals - a.avg_rentals) AS diff_from_avg
FROM rental_counts r, avg_rentals a;

"1. First Normal Form (1NF)

1NF rule:

No repeating groups/columns.

Each cell must hold only atomic (single) values.

Each row should be unique.

Example (violation in Sakila):
Suppose a table customer_orders stores:

order_id	customer_id	product_ids
1	5	2,3,5

→ Violates 1NF because product_ids has multiple values.

Normalized (1NF):

order_id	customer_id	product_id
1	5	2
1	5	3
1	5	5"

"2. Second Normal Form (2NF)

Must be in 1NF.

All non-key attributes must depend on the whole primary key (not just part of it).

Example: If film_category(film_id, category_id, category_name) exists,

film_id + category_id = composite PK.

category_name depends only on category_id, not whole key → violates 2NF.

Fix: Make a separate category(category_id, category_name) table."

"3. Third Normal Form (3NF)

Must be in 2NF.

No transitive dependencies (non-key column depends on another non-key).

Example:
customer(customer_id, city_id, city_name)

city_name depends on city_id (non-key).

Better:

customer(customer_id, city_id)

city(city_id, city_name)"

"4. Normalization Process (example)

Take table:
rental_info(customer_name, film_title, category_name)

UNF → multiple categories per film.

1NF → break into single-valued columns.

2NF → remove partial dependencies (film_title → category_name).

3NF → remove transitive dependencies (category_name → category_description)."

"5. CTE Basics

Q: Distinct actor names & number of films";
WITH actor_films AS (
    SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT * FROM actor_films;

"6. CTE with Joins

Film title + language + rental rate";
WITH film_lang AS (
    SELECT f.title, l.name AS language, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM film_lang;

"7. CTE for Aggregation

Total revenue by each customer";
WITH customer_revenue AS (
    SELECT customer_id, SUM(amount) AS total_revenue
    FROM payment
    GROUP BY customer_id
)
SELECT * FROM customer_revenue;

"8. CTE with Window Functions

Rank films by rental duration"
WITH film_rank AS (
    SELECT title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM film
)
SELECT * FROM film_rank;

"9. CTE with Filtering

Customers with more than 2 rentals"
WITH frequent_customers AS (
    SELECT customer_id, COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > 2
)
SELECT c.*, f.rental_count
FROM customer c
JOIN frequent_customers f ON c.customer_id = f.customer_id;

"CTE for Date Calculations

Total rentals per month"
WITH monthly_rentals AS (
    SELECT DATE_FORMAT(rental_date, '%Y-%m') AS month, COUNT(*) AS rental_count
    FROM rental
    GROUP BY month
)
SELECT * FROM monthly_rentals;

"11. CTE with Self-Join

Pairs of actors in the same film";
WITH actor_pairs AS (
    SELECT fa1.film_id, fa1.actor_id AS actor1, fa2.actor_id AS actor2
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT * FROM actor_pairs;


"12. Recursive CTE

Employees reporting to a manager";
WITH RECURSIVE employee_hierarchy AS (
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE reports_to = 1   -- manager ID

    UNION ALL

    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    JOIN employee_hierarchy eh ON s.reports_to = eh.staff_id
)
SELECT * FROM employee_hierarchy;
