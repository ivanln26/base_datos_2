USE sakila;

SELECT title, `length`
	FROM film
	WHERE `length` >= ALL (SELECT `length` FROM film);

UPDATE film SET length = 200 WHERE film_id = 182;

SELECT title, `length`
	FROM film f1
	WHERE `length` > ALL (SELECT `length`
								FROM film f2
								WHERE f1.film_id <> f2.film_id);

SELECT title, `length`
	FROM film f1
	WHERE NOT `length` <= ANY (SELECT `length`
									FROM film f2
									WHERE f2.film_id <> f1.film_id);

UPDATE film SET length = 185 WHERE film_id = 182;

SELECT title, replacement_cost
	FROM film
	WHERE replacement_cost > ANY (SELECT replacement_cost
										FROM film)
	ORDER BY replacement_cost;

SELECT title, replacement_cost
	FROM film f1
	WHERE EXISTS (SELECT *
						FROM film f2
						WHERE f1.replacement_cost > f2.replacement_cost)
	ORDER BY replacement_cost;

SELECT *
	FROM (SELECT title, description, rental_rate, rental_rate * 15 AS in_pesos
				FROM film) g
	WHERE in_pesos > 10.0
	AND in_pesos < 70.0;

SELECT customer_id, first_name, last_name,
	(SELECT DISTINCT amount
		FROM payment
		WHERE customer.customer_id = payment.customer_id
		AND amount >= ALL (SELECT amount
								FROM payment
								WHERE customer.customer_id = payment.customer_id))
	AS max_amount
	FROM customer
	ORDER BY max_amount DESC, customer_id DESC;

SELECT customer_id, first_name, last_name, (SELECT MAX(amount)
												FROM payment
												WHERE payment.customer_id = customer.customer_id) AS amount
	FROM customer
	ORDER BY amount DESC, customer_id DESC;

SELECT customer.customer_id, first_name, last_name, MAX(amount) max_amount
	FROM customer, payment
	WHERE customer.customer_id = payment.customer_id
	GROUP BY customer_id, first_name, last_name
	ORDER BY max_amount DESC, customer_id DESC;





