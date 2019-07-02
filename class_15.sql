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
        GROUP_CONCAT(DISTINCT CONCAT_WS(" " ,first_name, last_name) SEPARATOR ',') AS 'actors'
    FROM film f
        INNER JOIN film_category fc USING (film_id)
        INNER JOIN category c USING (category_id)
		INNER JOIN film_actor fa USING (film_id)
		INNER JOIN actor a USING (actor_id)
	GROUP BY 1, 4;

SELECT * FROM film_details;

-- 3

-- SHOW CREATE VIEW sales_by_film_category;

CREATE OR REPLACE VIEW sales_by_film_category AS
    SELECT DISTINCT
    	category.name,
    	SUM(amount) as total_rental
	FROM category
        INNER JOIN film_category USING(category_id)
	    INNER JOIN film USING(film_id)
        INNER JOIN inventory USING(film_id)
        INNER JOIN rental USING(inventory_id)
        INNER JOIN payment USING(rental_id)
    GROUP BY 1;

SELECT * FROM sales_by_film_category;

-- 4
CREATE OR REPLACE VIEW actor_information AS
    SELECT
        a.actor_id AS 'id',
        a.first_name,
        a.last_name,
        (SELECT COUNT(f.film_id)
            FROM film f 
            INNER JOIN film_actor fa USING (film_id)
            INNER JOIN actor a2 USING (actor_id)
            WHERE a.actor_id = a2.actor_id) AS "ammount_of_films"
    FROM actor a;

SELECT * FROM actor_information;

-- 5
SELECT * FROM actor_info;

SHOW CREATE VIEW actor_info;

-- This view fetches values from table actor, and joins them whenever it can with values from tables film_actor, film_category
-- and category. This meaning that they will only be joined in case the actor has acted in a film.
-- It displays the data in four columns. The first three of them are just basic actor data: its name, surname and id.
-- The fourth column, called film_info, displays every film the actor has acted on, grouped by category.
-- The query achieves this by concatenating every category with the group of films that belongs to it and, after that,
-- concatenating the groups of categories with its films together.

-- 6

-- Materialized views are a form of chaching query results.The main difference between this type of views the ordinary ones
-- is that Materialized views are concrete tables that store the results of a query.
-- They are used to improve performance and exist in a variety of DBMSs, but not in MySQL. In this last scenario you could
-- implement some workaround by using triggers or stored procedures.
