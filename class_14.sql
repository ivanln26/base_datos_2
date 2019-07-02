USE sakila;

-- 1
SELECT CONCAT_WS(" ", c.first_name, c.last_name) as 'name', a.address, ci.city
    FROM customer c
    INNER JOIN address a ON c.address_id = a.address_id
    INNER JOIN city ci ON a.city_id = ci.city_id
    INNER JOIN country co ON ci.country_id = co.country_id
    WHERE co.country = 'Argentina';

-- 2
SELECT f.title, l.name,
    CASE
        WHEN f.rating = 'G' THEN 'G (General Audiences)'
        WHEN f.rating = 'PG' THEN 'PG (Parental Guidance Suggested)'
        WHEN f.rating = 'PG-13' THEN 'PG-13 (Parents Strongly Cautioned)'
        WHEN f.rating = 'R' THEN 'R (Restricted)'
        WHEN f.rating = 'NC-17' THEN 'NC-17 (Adults Only)'
        ELSE f.rating
    END AS 'rating'
    FROM film f
    INNER JOIN `language` l ON f.language_id = l.language_id;

-- 3
SELECT f.title, f.release_year, CONCAT_WS(" ", a.first_name, a.last_name) as 'name'
    FROM film f
    INNER JOIN film_actor fa ON f.film_id = fa.film_id
    INNER JOIN actor a ON fa.actor_id = a.actor_id
    WHERE CONCAT_WS(" ", a.first_name, a.last_name) LIKE TRIM(UPPER(' PeNELope guiNESs'));
   
-- 4
SELECT
	f.title,
	CONCAT_WS(" ", c.first_name, c.last_name) AS 'name',
	MONTHNAME(r.rental_date) AS 'month',
    CASE
        WHEN r.return_date IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS 'was_returned'
FROM customer c
	INNER JOIN rental r ON c.customer_id = r.customer_id
	INNER JOIN inventory i ON r.inventory_id = i.inventory_id
	INNER JOIN film f ON i.film_id = f.film_id
	WHERE MONTH(r.rental_date) BETWEEN 5 AND 6;

-- 5

-- CAST and CONVERT have barely no differences between them.
-- While CAST has a slightly distinct syntax than CONVERT,they're both used to convert data from one type to another.

SELECT CAST(last_update AS DATE) AS only_date FROM rental;

SELECT CONVERT("2006-02-15", DATETIME);

-- 6

-- NVL() and IFNULL() functions work in the same way: 
-- they check whether an expression is NULL or not; if it is, they return a second expression (a default value).

-- NVL() is an Oracle function, so here is an IFNULL() example:

SELECT rental_id, IFNULL(return_date, 'La pelicula no fue devuelta aun') as 'fecha_de_devolucion'
	FROM rental
	WHERE rental_id = 1261
	OR rental_id = 12611;

-- ISNULL() function returns 1 if the expression passed is NULL, otherwise it returns 0.

SELECT rental_id, ISNULL(return_date) as pelicula_faltante
	FROM rental
	WHERE rental_id = 12610
	OR rental_id = 12611;

-- COALESCE() function returns the first non-NULL argument of the passed list.

SELECT COALESCE (
	NULL,
	NULL,
	(SELECT return_date
		FROM rental
		WHERE rental_id = 12610), -- null date
    (SELECT return_date
        FROM rental
        WHERE rental_id = 12611)
) as primer_valor_no_nulo;
