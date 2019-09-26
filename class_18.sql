-- 1
CREATE USER data_analyst@'%'
    IDENTIFIED BY 'password';

-- 2
GRANT SELECT, UPDATE, DELETE
    ON sakila.*
    TO data_analyst;

-- 3
CREATE TABLE data_analyst_table (
    id INT AUTO_INCREMENT,
    title VARCHAR(50),
    PRIMARY KEY (id)
);
-- CREATE command denied to user 'data_analyst'@'172.21.0.1' for table 'data_analyst_table'

-- 4
UPDATE film
    SET title = "ACADEMY"
    WHERE film_id = 1;

-- 5
REVOKE UPDATE
    ON sakila.*
    FROM data_analyst;

-- 6
UPDATE film
    SET title = "ACADEMY DINOSAUR"
    WHERE film_id = 1;
-- UPDATE command denied to user 'data_analyst'@'172.21.0.1' for table 'film'
