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
SELECT * FROM rental ORDER BY rental_id DESC;
SELECT * FROM inventory ORDER BY inventory_id DESC;
SELECT * FROM customer ORDER BY customer_id DESC;
SELECT * FROM staff WHERE store_id = 2;
SELECT * FROM rental ORDER BY rental_id DESC;

DELETE FROM rental WHERE rental_id = 16050;

INSERT INTO rental
    (rental_id, inventory_id, customer_id, staff_id)
    VALUES
    (16050, 4581, 600, 2);

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

-- 3
SELECT rental_id, rental_date, return_date
    FROM rental r
    WHERE r.return_date IS NULL
    ORDER BY r.rental_date DESC
    LIMIT 1;

-- 4
SELECT rental_id, rental_date, return_date FROM rental WHERE rental_id = 16050;

UPDATE rental SET return_date = NULL WHERE rental_id = 16050;

UPDATE rental SET return_date = NOW()
    WHERE rental_id = (SELECT rental_id
                            FROM (SELECT r2.rental_id
                                        FROM rental r2
                                        WHERE r2.return_date IS NULL
                                        ORDER BY r2.rental_date DESC
                                        LIMIT 1) r);    

-- 5
SELECT * FROM film f ORDER BY f.film_id DESC;

DELETE FROM film f WHERE f.film_id = 1000;

-- 6
SELECT *
    FROM store s
    INNER JOIN inventory i ON s.store_id = i.store_id
    INNER JOIN rental r ON i.inventory_id = r.inventory_id;







