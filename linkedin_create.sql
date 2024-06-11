SET Foreign_Key_Checks = 0;
DROP Database IF EXISTS LinkedIn;

CREATE Database LinkedIn;
USE LinkedIn;
SET Foreign_Key_Checks = 1;

CREATE TABLE Address (
    Address_Id INT Auto_Increment Primary Key,
    Job_Location VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(100)
);

CREATE TABLE Skills (
    Skill_Id INT Auto_Increment Primary Key,
    Skill TEXT
);

CREATE TABLE Job (
    Job_Link VARCHAR(600) Primary Key,
    Address_Id INT,
    Title VARCHAR(255),
    Company VARCHAR(255),
    Position VARCHAR(255),
    Job_Level VARCHAR(50),
    Job_Type VARCHAR(50),
    Foreign Key (Address_Id) References Address(Address_Id)
);

CREATE TABLE Job_Skill (
    Job_Skill_Id INT Auto_Increment Primary Key,
    Job_Link VARCHAR(600),
    Skill_Id INT,
    Foreign Key (Job_Link) References Job(Job_Link),
    Foreign Key (Skill_Id) References Skills(Skill_Id)
);
