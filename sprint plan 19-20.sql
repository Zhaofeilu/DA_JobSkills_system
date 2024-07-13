-- Session 1: Set isolation level to READ COMMITTED
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;
UPDATE Job SET Title = 'Senior Developer' WHERE Job_Link = 'job123';
-- Do not commit yet

-- Session 2: Try to read the Job data
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;
SELECT Title FROM Job WHERE Job_Link = 'job123';
-- Session 2 will not see the 'Senior Developer' title yet because Session 1 has not committed
COMMIT;

-- Session 1: Now commit the transaction
COMMIT;

-- Session 1: Set isolation level to REPEATABLE READ
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;
SELECT Title FROM Job WHERE Job_Link = 'job123';
-- The title is 'Developer'

-- Session 2: Update the Job data
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;
UPDATE Job SET Title = 'Senior Developer' WHERE Job_Link = 'job123';
COMMIT;

-- Session 1: Read the Job data again
SELECT Title FROM Job WHERE Job_Link = 'job123';
-- The title is still 'Developer' due to REPEATABLE READ isolation
COMMIT;

-- Session 1: Set isolation level to SERIALIZABLE
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

START TRANSACTION;
INSERT INTO Job (Job_Link, Address_Id, Title, Company, Position, Job_Level, Job_Type) 
VALUES ('job999', 1, 'Data Scientist', 'Data Corp', 'Scientist', 'Senior', 'Full-Time');
-- Do not commit yet

-- Session 2: Try to insert a conflicting row
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

START TRANSACTION;
INSERT INTO Job (Job_Link, Address_Id, Title, Company, Position, Job_Level, Job_Type) 
VALUES ('job999', 1, 'Machine Learning Engineer', 'AI Corp', 'Engineer', 'Mid', 'Part-Time');
-- This insert will be blocked until Session 1 commits or rolls back
COMMIT;

-- Set the global isolation level
SET GLOBAL TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Set the session isolation level
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- FullTimeJob table inherits from Job
CREATE TABLE FullTimeJob (
    Salary DECIMAL,
    job_link varchar(100),
    Foreign key(job_link) REFERENCES job(job_link)
);

-- PartTimeJob table inherits from Job
CREATE TABLE PartTimeJob (
    HourlyRate DECIMAL,
    job_link varchar(100),
    Foreign key(job_link) REFERENCES job(job_link)
);
