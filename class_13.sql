USE sakila;

-- 1
SELECT * FROM customer ORDER BY customer_id DESC;

DELETE FROM customer WHERE customer_id = 600;

INSERT INTO customer
    (customer_id, store_id, first_name, last_name, email, address_id, active)
    VALUES
    (600, 1, "Ivan", "Nuñez", "ivanluis.cba@gmail.com",
        (SELECT address_id
            FROM address a
            INNER JOIN city c ON a.city_id = c.city_id
            INNER JOIN country co ON c.country_id = co.country_id
            WHERE co.country LIKE 'United States'
            AND a.address_id >= ALL(SELECT a2.address_id
                                        FROM address a2
                                        INNER JOIN city c2 ON a2.city_id = c2.city_id
                                        INNER JOIN country co2 ON c2.country_id = co2.country_id
                                        WHERE co2.country LIKE 'United States')), 1);

-- 2
SELECT * FROM rental r ORDER BY rental_id DESC;

INSERT INTO rental
	(rental_date, inventory_id, customer_id, return_date, staff_id)
SELECT CURRENT_TIMESTAMP,
	(SELECT MAX(i.inventory_id) FROM inventory i INNER JOIN film f USING (film_id) WHERE f.title = "ARABIA DOGMA" LIMIT 1),
	600,
	NULL,
	(SELECT staff_id FROM staff s INNER JOIN store st USING (store_id) WHERE st.store_id = 2 LIMIT 1);

-- 3
-- G --> 2000
-- PG --> 2002
-- PG-13 --> 2004
-- R --> 2006
-- NC-17 --> 2010
SELECT f.film_id, f.title, f.release_year, f.rating FROM film f ORDER BY rating;

UPDATE film f SET f.release_year = 2000 WHERE f.rating LIKE 'G';
UPDATE film f SET f.release_year = 2002 WHERE f.rating LIKE 'PG';
UPDATE film f SET f.release_year = 2004 WHERE f.rating LIKE 'PG-13';
UPDATE film f SET f.release_year = 2006 WHERE f.rating LIKE 'R';
UPDATE film f SET f.release_year = 2010 WHERE f.rating LIKE 'NC-17';

-- 4
SELECT rental_id, rental_rate, customer_id, staff_id
	FROM film
	INNER JOIN inventory USING (film_id)
	INNER JOIN rental USING (inventory_id)
	WHERE rental.return_date IS NULL
	LIMIT 1;

UPDATE rental
	SET return_date = CURRENT_TIMESTAMP
	WHERE rental_id = 11496;

-- 5
SELECT * FROM film f ORDER BY f.film_id DESC;

DELETE FROM film WHERE film_id = 1000;

-- Steps
DELETE FROM payment
	WHERE rental_id IN (SELECT rental_id
							FROM rental
							INNER JOIN inventory USING (inventory_id)
							WHERE film_id = 1);

DELETE FROM rental
	WHERE inventory_id IN (SELECT inventory_id
								FROM inventory
								WHERE film_id = 1);

DELETE FROM inventory WHERE film_id = 1;

DELETE film_actor FROM film_actor WHERE film_id = 1;

DELETE film_category FROM film_category WHERE film_id = 1;

DELETE film FROM film WHERE film_id = 1;

-- 6
SELECT inventory_id, film_id
	FROM inventory
	WHERE inventory_id NOT IN (SELECT inventory_id
									FROM inventory
									INNER JOIN rental USING (inventory_id)
									WHERE return_date IS NULL);

# inventory id to use: 10
# film id to use: 2

INSERT INTO rental
	(rental_date, inventory_id, customer_id, staff_id)
VALUES (
	CURRENT_DATE(),	
	10,
	(SELECT customer_id FROM customer ORDER BY customer_id DESC LIMIT 1),
	(SELECT staff_id FROM staff WHERE store_id = (SELECT store_id FROM inventory WHERE inventory_id = 10))
);

INSERT INTO payment
	(customer_id, staff_id, rental_id, amount, payment_date)		
VALUES (	
	(SELECT customer_id FROM customer ORDER BY customer_id DESC LIMIT 1),
	(SELECT staff_id FROM staff LIMIT 1),
	(SELECT rental_id FROM rental ORDER BY rental_id DESC LIMIT 1) ,
	(SELECT rental_rate FROM film WHERE film_id = 2),
	CURRENT_DATE()
);
