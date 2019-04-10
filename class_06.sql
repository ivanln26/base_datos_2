USE sakila;

-- 1
SELECT a.first_name, a.last_name
    FROM actor a 
    WHERE EXISTS (SELECT * 
                    FROM actor a2
                    WHERE a.last_name = a2.last_name
                    AND a.actor_id <> a2.actor_id)
    ORDER BY a.last_name;

-- 2
SELECT a.first_name, a.last_name
    FROM actor a 
    WHERE EXISTS (SELECT * FROM film_actor fa WHERE fa.film_id IS NULL);

-- 3
SELECT c.first_name, c.last_name
    FROM customer c
    WHERE EXISTS (SELECT customer_id, COUNT(inventory_id)
                    FROM rental
                    GROUP BY customer_id
                    HAVING COUNT(inventory_id) = 1);

-- 4
SELECT c.first_name, c.last_name
    FROM customer c
    WHERE EXISTS (SELECT customer_id, COUNT(inventory_id)
                    FROM rental
                    GROUP BY customer_id
                    HAVING COUNT(inventory_id) > 1);

-- 5
SELECT *
    FROM actor a
    WHERE a.actor_id IN (SELECT fa.actor_id
                            FROM film_actor fa
                            WHERE fa.film_id IN (SELECT f.film_id 
                                            FROM film  f
                                            WHERE f.title LIKE 'BETRAYED REAR' OR f.title LIKE 'CATCH AMISTAD'));

-- 6
SELECT *
    FROM actor a
    WHERE a.actor_id IN (SELECT fa.actor_id
                            FROM film_actor fa
                            WHERE fa.film_id IN (SELECT f.film_id 
                                            FROM film  f
                                            WHERE f.title LIKE 'BETRAYED REAR' AND f.title NOT LIKE 'CATCH AMISTAD'));

-- 7
SELECT *
    FROM actor a
    WHERE a.actor_id IN (SELECT fa.actor_id
                            FROM film_actor fa
                            WHERE fa.film_id IN (SELECT f.film_id FROM film f WHERE f.title LIKE 'BETRAYED REAR')) 
    AND a.actor_id IN (SELECT fa.actor_id
                            FROM film_actor fa
                            WHERE fa.film_id IN (SELECT f.film_id FROM film f WHERE f.title LIKE 'CATCH AMISTAD'));

-- 8
SELECT *
    FROM actor a
    WHERE a.actor_id IN (SELECT fa.actor_id
                            FROM film_actor fa
                            WHERE fa.film_id NOT IN (SELECT f.film_id 
                                            FROM film  f
                                            WHERE f.title LIKE 'BETRAYED REAR' OR f.title LIKE 'CATCH AMISTAD'));
