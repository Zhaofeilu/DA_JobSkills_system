/*Inserting row in address table */
INSERT INTO address VALUES (3, '101 Lane 2', 'Seoul', 'South Korea'); 

/*NULL Query*/
SELECT address.address_id, address.job_location, job.job_link from address LEFT JOIN job
ON address.address_id=job.address_id 
WHERE job_link IS NULL;

/*FULL OUTER JOIN query*/
SELECT address.address_id, address.job_location, job.job_link 
FROM address LEFT JOIN job ON address.address_id = job.address_id
UNION
SELECT address.address_id, address.job_location, job.job_link 
FROM address RIGHT JOIN job ON address.address_id = job.address_id;

/*CHECK CONSTRAINT 1*/
ALTER TABLE Skills ADD CONSTRAINT chk_skill_score CHECK 
(Skill_Score BETWEEN 0 AND 100);

/*CHECK CONSTRAINT 2*/
ALTER TABLE Job ADD CONSTRAINT chk_job_level CHECK 
(job_level BETWEEN 1 AND 5);
