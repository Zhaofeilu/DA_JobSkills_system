CREATE USER 'general_user'@'localhost' IDENTIFIED BY 'password1';
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'password2';
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'password3';

GRANT SELECT, INSERT, UPDATE, DELETE ON Linkedin.* TO 'general_user'@'localhost';
GRANT SELECT ON Linkedin.* TO 'readonly_user'@'localhost'; 
GRANT ALL PRIVILEGES ON Linkedin.* TO 'admin_user'@'localhost';

CREATE VIEW JobDetails AS
SELECT 
    j.Job_Link,
    j.Title,
    j.Company,
    j.Position,
    j.Job_Level,
    j.Job_Type,
    a.Job_Location,
    a.City,
    a.Country
FROM 
    Job j
JOIN 
    Address a ON j.Address_Id = a.Address_Id;

START TRANSACTION;

-- Insert into Address table
INSERT INTO Address (Job_Location, City, Country) VALUES ('Location1', 'City1', 'Country1');

-- Insert into Job table
INSERT INTO Job (Job_Link, Address_Id, Title, Company, Position, Job_Level, Job_Type) VALUES 
('link1', LAST_INSERT_ID(), 'Title1', 'Company1', 'Position1', 'Level1', 'Type1');

-- Insert into Skills table
INSERT INTO Skills (Skill_score, Skill) VALUES (90, 'Skill1');

-- Insert into Job_Skill table
INSERT INTO Job_Skill (Job_Link, Skill_Id) VALUES ('link1', LAST_INSERT_ID());

COMMIT;

-- Set isolation level
SET GLOBAL TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Or for a specific session
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Start the transaction
START TRANSACTION;

-- Insert a new address
INSERT INTO Address (Job_Location, City, Country) VALUES ('123 Main St', 'Springfield', 'USA');
-- Capture the last inserted Address_Id for reference in the next insert
SET @address_id = LAST_INSERT_ID();

-- Insert a new job with the newly inserted address ID
INSERT INTO Job (Job_Link, Address_Id, Title, Company, Position, Job_Level, Job_Type) 
VALUES ('job123', @address_id, 'Software Developer', 'Tech Corp', 'Developer', 'Mid', 'Full-Time');

-- Insert new skills
INSERT INTO Skills (Skill_score, Skill) VALUES (95, 'Java');
SET @skill_id_java = LAST_INSERT_ID();
INSERT INTO Skills (Skill_score, Skill) VALUES (85, 'SQL');
SET @skill_id_sql = LAST_INSERT_ID();

-- Link the job to its skills
INSERT INTO Job_Skill (Job_Link, Skill_Id) VALUES ('job123', @skill_id_java);
INSERT INTO Job_Skill (Job_Link, Skill_Id) VALUES ('job123', @skill_id_sql);

-- Commit the transaction if all operations succeed
COMMIT;

-- Set the isolation level globally
SET GLOBAL TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Set the isolation level for the current session
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
