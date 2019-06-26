USE sakila;

-- 1
CREATE OR REPLACE VIEW list_of_customers AS
    SELECT
        c.customer_id,
        CONCAT_WS(" ", c.last_name, c.first_name) AS "name",
        a.address,
        a.postal_code,
        a.phone,
        ci.city,
        co.country,
        s.store_id,
        CASE c.active
            WHEN 1 THEN "Active"
            ELSE "Inactive"
        END AS "status"
    FROM customer c
        INNER JOIN address a ON c.address_id = a.address_id
        INNER JOIN city ci ON a.city_id = ci.city_id
        INNER JOIN country co ON ci.country_id = co.country_id
        INNER JOIN store s ON c.store_id = s.store_id;
    
SELECT * FROM list_of_customers;

-- 2
CREATE OR REPLACE VIEW film_details AS
    SELECT
        f.film_id,
        f.title,
        f.description,
        c.name,
        f.`length`,
        f.rating,
            (SELECT GROUP_CONCAT(a.last_name)
                FROM film f2
                INNER JOIN film_actor fa ON f2.film_id = fa.film_id
                INNER JOIN actor a ON fa.actor_id = a.actor_id
                WHERE f.film_id = f2.film_id
                GROUP BY f2.film_id) AS 'actors'
    FROM film f
        INNER JOIN film_category fc ON f.film_id = fc.film_id
        INNER JOIN category c ON fc.category_id = c.category_id;

SELECT * FROM film_details;

-- 3
SELECT * FROM sales_by_film_category;

SHOW CREATE VIEW sales_by_film_category;

-- 4
CREATE OR REPLACE VIEW actor_information AS
    SELECT
        a.actor_id,
        a.first_name,
        a.last_name,
        (SELECT COUNT(fa.actor_id)
            FROM actor a2 
            INNER JOIN film_actor fa ON a2.actor_id = fa.actor_id
            WHERE a.actor_id = a2.actor_id
            GROUP BY fa.actor_id) AS "ammount_of_films"
    FROM actor a;

SELECT * FROM actor_information;

-- 5
SELECT * FROM actor_info;

SHOW CREATE VIEW actor_info;
