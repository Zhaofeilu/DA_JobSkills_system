#Database Setting
		USE linkedin;    
			
		select * from address;
		select * from job;
		select * from job_skill;
		select * from skills;

###Understanding database###


	#Identify all tables and their relationships.
	#Understand the key columns and data types in each table.
		Describe job;
		Describe address;
		Describe job_skill;
		Describe skills;


		-- Summary Statistics For Address Table
		Select
			Count(*) As Total_Records,
			Count(Distinct Job_Location) As Unique_Job_Locations,
			Count(Distinct City) As Unique_Cities,
			Count(Distinct Country) As Unique_Countries
		From Address;
			
		-- Summary Statistics For Job Table
		Select
			Count(*) As Total_Records,
			Count(Distinct Job_Link) As Unique_Job_Links,
			Count(Distinct Title) As Unique_Titles,
			Count(Distinct Company) As Unique_Companies,
			Count(Distinct Position) As Unique_Positions,
			Count(Distinct Job_Level) As Unique_Job_Levels,
			Count(Distinct Job_Type) As Unique_Job_Types
		From Job;
			
		-- Summary Statistics For Skills Table
		Select
			Count(*) As Total_Records,
			Count(Distinct Skill_Id) As Unique_Skill_Ids,
			Min(Skill_Score) As Min_Skill_Score,
			Max(Skill_Score) As Max_Skill_Score,
			Avg(Skill_Score) As Avg_Skill_Score
		From Skills;
			
		-- Summary Statistics For Job_Skill Table
		Select
			Count(*) As Total_Records,
			Count(Distinct Job_Link) As Unique_Job_Links,
			Count(Distinct Skill_Id) As Unique_Skill_Ids
		From Job_Skill;

		-- Job Distribution By Country
		Select
			Country,
			Count(*) As Number_Of_Jobs
		From Job
		Join Address On Job.Address_Id = Address.Address_Id
		Group By Country;

		-- Job Distribution By Company
		Select
			Company,
			Count(*) As Number_Of_Jobs
		From Job
		Group By Company
		Order By Number_Of_Jobs Desc
		Limit 10;

		-- Job Distribution By Job Type
		Select
			Job_Type,
			Count(*) As Number_Of_Jobs
		From Job
		Group By Job_Type;

		-- Job Distribution By Job Level
		Select
			Job_Level,
			Count(*) As Number_Of_Jobs
		From Job
		Group By Job_Level;


		-- Number Of Skills Required Per Job
		Select
			Job_Link,
			Count(Skill_Id) As Number_Of_Skills
		From Job_Skill
		Group By Job_Link
		Order By Number_Of_Skills Desc;

		-- Distribution Of Skills And Their Scores
		Select
			Skill_Score,
			Count(*) As Frequency
		From Skills
		Group By Skill_Score
		Order By Skill_Score;

		-- Most Common Skills Required For Jobs
		Select
			S.Skill,
			Count(Js.Skill_Id) As Frequency
		From Job_Skill Js
		Join Skills S On Js.Skill_Id = S.Skill_Id
		Group By S.Skill
		Order By Frequency Desc
		Limit 10;

		-- Least Common Skills Required For Jobs
		Select
			S.Skill,
			Count(Js.Skill_Id) As Frequency
		From Job_Skill Js
		Join Skills S On Js.Skill_Id = S.Skill_Id
		Group By S.Skill
		Order By Frequency Asc
		Limit 10;


		-- Distribution Of Jobs By City
		Select
			A.City,
			Count(*) As Number_Of_Jobs
		From Job J
		Join Address A On J.Address_Id = A.Address_Id
		Group By A.City
		Order By Number_Of_Jobs Desc;


		-- Common Job Titles And Their Occurrences
		Select
			J.Title,
			Count(*) As Occurrences
		From Job J
		Group By J.Title
		Order By Occurrences Desc;
