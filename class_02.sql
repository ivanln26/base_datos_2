DROP DATABASE IF EXISTS imdb;

CREATE DATABASE IF NOT EXISTS imdb;

USE imdb;

DROP TABLE IF EXISTS film;
DROP TABLE IF EXISTS actor;
DROP TABLE IF EXISTS film_actor;

CREATE TABLE IF NOT EXISTS film (
    film_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    description VARCHAR(100),
    release_year DATE,
    CONSTRAINT film_pk PRIMARY KEY (film_id)
);

CREATE TABLE IF NOT EXISTS actor (
    actor_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(25),
    last_name VARCHAR(25) NOT NULL,
    CONSTRAINT actor_pk PRIMARY KEY (actor_id)
);

CREATE TABLE IF NOT EXISTS film_actor (
	film_actor_id INT NOT NULL AUTO_INCREMENT,
	actor_id INT,
	film_id INT,
    CONSTRAINT film_actor_pk PRIMARY KEY (film_actor_id)
);

ALTER TABLE film ADD COLUMN last_update TIMESTAMP;
ALTER TABLE actor ADD COLUMN last_update TIMESTAMP;

ALTER TABLE film_actor ADD CONSTRAINT actor_fk FOREIGN KEY (actor_id) REFERENCES actor(actor_id);
ALTER TABLE film_actor ADD CONSTRAINT film_fk FOREIGN KEY (film_id) REFERENCES film(film_id);

INSERT INTO actor (first_name, last_name) VALUES ("Ivan", "Nuñez");
INSERT INTO actor (first_name, last_name) VALUES ("Juan Cruz", "Mare");

INSERT INTO film (title, description, release_year) VALUES ("Spiderman", "Esto es spiderman", "2010-10-26");

INSERT INTO film_actor (actor_id, film_id) VALUES (1, 1);
