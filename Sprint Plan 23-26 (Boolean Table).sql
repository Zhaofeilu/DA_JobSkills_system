-- Creating the tables
CREATE TABLE X (
    id INT PRIMARY KEY,
    value BOOLEAN
);

CREATE TABLE Y (
    id INT PRIMARY KEY,
    value BOOLEAN
);

-- Inserting rows into table X
INSERT INTO X (id, value) VALUES
(1, TRUE),
(2, FALSE),
(3, TRUE);

-- Inserting rows into table Y
INSERT INTO Y (id, value) VALUES
(1, FALSE),
(2, TRUE),
(3, TRUE);

-- Executing the queries

-- Query 1: Select all rows from table X
SELECT * FROM X;

-- Query 2: Select all rows from table Y
SELECT * FROM Y;

-- Query 3: Select rows where value is TRUE in table X
SELECT * FROM X WHERE value = TRUE;

-- Query 4: Select rows where value is FALSE in table Y
SELECT * FROM Y WHERE value = FALSE;

-- Query 5: Perform an inner join on tables X and Y on id
SELECT X.id, X.value AS value_X, Y.value AS value_Y
FROM X
INNER JOIN Y ON X.id = Y.id;

-- Query 6: Perform a left join on tables X and Y on id
SELECT X.id, X.value AS value_X, Y.value AS value_Y
FROM X
LEFT JOIN Y ON X.id = Y.id;

-- Query 7: Perform a right join on tables X and Y on id
SELECT X.id, X.value AS value_X, Y.value AS value_Y
FROM X
RIGHT JOIN Y ON X.id = Y.id;
