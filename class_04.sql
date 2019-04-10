USE sakila;

-- 1
SELECT title, special_features FROM film WHERE rating LIKE 'PG-13';

-- 2
SELECT DISTINCT length FROM film
    ORDER BY length;

-- 3
SELECT title, rental_rate, replacement_cost
    FROM film
    WHERE replacement_cost BETWEEN 20.00 AND 24.00;

-- 4
SELECT f.title, c.name AS 'category', f.rating
    FROM film AS f INNER JOIN film_category AS fc INNER JOIN category AS c
    ON f.film_id = fc.film_id AND c.category_id = fc.category_id
    WHERE f.special_features LIKE '%Behind the Scenes%';

-- 5
SELECT a.first_name, a.last_name 
    FROM film AS f INNER JOIN film_actor AS fa INNER JOIN actor AS a
    ON f.film_id = fa.film_id AND a.actor_id = fa.actor_id
    WHERE f.title LIKE 'ZOOLANDER FICTION';

-- 6
SELECT a.address, c.city, co.country
    FROM store AS s INNER JOIN address AS a INNER JOIN city as c INNER JOIN country AS co
    ON s.address_id = a.address_id AND a.city_id = c.city_id AND c.country_id = co.country_id
    WHERE s.store_id = 1;

-- 7
SELECT DISTINCT f1.title, f2.title, f1.rating
    FROM film f1 INNER JOIN film f2
    ON f1.film_id <> f2.film_id
    WHERE f1.rating = f2.rating
    ORDER BY 3, 1, 2;

-- 8
SELECT DISTINCT f.title, st.first_name, st.last_name
    FROM store s INNER JOIN staff st INNER JOIN inventory AS i INNER JOIN film AS f
    ON s.manager_staff_id = st.staff_id AND s.store_id = i.store_id AND f.film_id = i.film_id
    WHERE s.store_id = 2;
