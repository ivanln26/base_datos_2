USE sakila;

SELECT film.title, language.name
    FROM film, `language`
    WHERE film.language_id = language.language_id AND film.`length` > 100 AND language.name = 'English';

-- 1
SELECT f.title, f.`length`, a.first_name, a.last_name
    FROM actor a INNER JOIN film_actor fa INNER JOIN film f
    ON a.actor_id = fa.actor_id AND fa.film_id = f.film_id
    WHERE f.`length` <= ALL (SELECT f2.`length` FROM film f2);

-- 2
SELECT co.country, c.city, a.address, a.district, a.postal_code
    FROM address a INNER JOIN city c INNER JOIN country co
    ON a.city_id = c.city_id AND c.country_id = co.country_id
    WHERE co.country LIKE '%a' AND c.city LIKE 'E%'
    ORDER BY co.country, c.city;

-- 3
SELECT c.name, f.title, f.`length`, l.name, f.rental_rate
    FROM film f INNER JOIN film_category fc INNER JOIN category c INNER JOIN `language` l
    ON f.film_id = fc.film_id AND fc.category_id = c.category_id AND f.language_id = l.language_id
    WHERE c.name IN ('Comedy', 'Children', 'Animation') AND rental_rate < 3
    ORDER BY c.name, f.rental_rate, f.title;
