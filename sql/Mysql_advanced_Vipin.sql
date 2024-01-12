USE genzdataset;

SHOW tables;


SELECT * FROM learning_aspirations;
SELECT * FROM manager_aspirations;
SELECT * FROM mission_aspirations;
SELECT * FROM personalized_info;

-- Q1 What percentage of male and female genz want to go to office every day ?

SELECT 
Round((Sum(case when pi.Gender like 'Male%' Then 1 Else 0 End)/ Count(*))*100) As Males,
Round((Sum(case when pi.Gender like 'Female%' Then 1 Else 0 End)/ Count(*))*100) As Females
FROM personalized_info pi
INNER JOIN  learning_aspirations la
ON pi.ResponseID=la.ResponseID
WHERE la.PreferredWorkingEnvironment like 'Every Day%';



-- Q2 What percentage of Genz's who have choosen their career in Business Operations are most likely to be influenced by their parents?

SELECT (COUNT(ResponseID) / (SELECT COUNT(*) FROM learning_Aspirations)) * 100 AS Total_Percent
FROM learning_aspirations
WHERE ClosestAspirationalCareer LIKE 'Business Operations%' AND CareerInfluenceFactor LIKE 'My Parents%';



-- Q3 What Percentage of Genz prefer Opting for Higher studies, give a genderwise approach ?

SELECT 
     ROUND((COUNT(CASE WHEN pi.gender like 'Male%' THEN 1 END) / COUNT(*)) * 100) AS Male_percent,
     ROUND((COUNT(CASE WHEN pi.gender like 'Female%' THEN 1 END) / COUNT(*)) * 100) AS Female_percent
FROM personalized_info pi
INNER JOIN learning_aspirations la
ON pi.ResponseID = la.ResponseID
WHERE HigherEducationAbroad LIKE 'Yes%';



-- Q.4 What percentage of genz are willing & not willing to work for a company whose mission is misalligned with their public actions or even their product ?

SELECT
    COUNT(CASE WHEN Gender LIKE 'Male%' THEN 1 END) / (COUNT(*)) * 100  AS Male_Count,
    COUNT(CASE WHEN Gender LIKE 'Female%' THEN 1 END) / (COUNT(*)) * 100 AS Female_Count
FROM mission_aspirations
INNER JOIN personalized_info ON mission_aspirations.ResponseID = personalized_info.ResponseID 
WHERE MisalignedMissionLikelihood LIKE 'Will NOT%';




-- Q.5 What is most sutiable working environment according to female genz ?

SELECT PreferredWorkingEnvironment, Count(*) AS Count
FROM learning_aspirations la
INNER JOIN personalized_info pi
ON la.ResponseID=pi.ResponseID
WHERE pi.Gender like 'F%'
GROUP BY PreferredWorkingEnvironment
ORDER BY Count(*) DESC;



-- Q.6 Calculate the Total number of females who aspire to work in their closest aspirational career and have a social impact likelihood of 1 to 5?

SELECT count(pi.gender) AS female_total
FROM personalized_info pi
INNER JOIN mission_aspirations ma ON pi.ResponseID=ma.ResponseID 
INNER JOIN manager_aspirations la ON pi.ResponseID=la.ResponseID 
WHERE pi.gender like 'F%'
AND ma.NoSocialImpactLikelihood between 1 AND 5;



-- Q.7  Retrieve the Male asprants who are interested in Higher studies abroad and have career influence factor of 'My Parents' ?

SELECT Pi.ResponseID,pi.gender,la.HigherEducationAbroad, la.CareerinfluenceFactor
FROM personalized_info pi
INNER JOIN learning_aspirations la
ON pi.ResponseID=la.ResponseID
WHERE pi.gender like 'M%'
AND la.CareerInfluenceFactor='My Parents'
AND la.HigherEducationAbroad like 'Y%';



-- Q.8  Determine the percentage of gender who have a no social impact likelihood of 8-10 among those who are interested in Higher Education Abroad ?

SELECT 
Round((Sum(Case When pi.Gender like 'Male%' Then 1 Else 0 End)/Count(*))*100) AS Males,
Round((Sum(Case When pi.Gender like 'Female%' Then 1 Else 0 End)/Count(*))*100) AS Females
FROM personalized_info pi
INNER JOIN mission_aspirations ma on pi.ResponseID=ma.ResponseID
INNER JOIN learning_aspirations la on pi.ResponseID=la.ResponseID
WHERE ma.NoSocialImpactLikelihood Between 8 and 10
AND HigherEducationAbroad like 'Y%';



-- Q.9 Give a detailed split of the Genz preferences to work with Teams,Data should include Male,Female and overall in counts and overall in counts anas well as in  %.

SELECT
Sum(Case when pi.Gender like 'Male%' Then 1 else 0 End) As Males,
Sum(Case when pi.Gender like 'Female%' Then 1 else 0 End) As Females,
Round((Sum(Case When pi.Gender like 'Male%' Then 1 Else 0 End)/Count(*))*100,1) AS Male_Percent,
Round((Sum(Case When pi.Gender like 'Female%' Then 1 Else 0 End)/Count(*))*100,1) AS Female_Percent
FROM Personalized_info pi
INNER JOIN manager_aspirations ma
ON pi.ResponseId=ma.ResponseID
WHERE ma.PreferredWorkSetup like '%Team%';



-- Q. 10 Give a detailed breakdown of worklikelihood3years for each gender ?

SELECT ma.WorkLikelihood3years,
Sum(Case When pi.Gender like 'Male%' Then 1 Else 0 End) AS Males,
Sum(Case When pi.Gender like 'Female%' Then 1 Else 0 End) AS Females
FROM personalized_info pi
INNER JOIN manager_aspirations ma
ON pi.ResponseID = ma.ResponseID
GROUP BY ma.WorkLikelihood3years;



-- Q. 11 Give a detailed breakdown of worklikelihood3years for each state ?

-- getting confused in acquiring the state info coding


 
-- Q.12 What is the average starting salary expectations at 3Y mark for each gender?

SELECT pi.Gender,
 AVG (Cast(substring_index(ExpectedSalary3years, 'K', 1) as Signed)) AS avg_starting_salary
 FROM personalized_info pI
 INNER JOIN mission_aspirations ma
 ON pi.ResponseID=Ma.ResponseID
 GROUP BY pi.Gender;
 
 
 -- Q.13 What is the average starting salary expectations at 3Y mark for each gender?

SELECT pi.Gender,
 AVG (Cast(substring_index(ExpectedSalary5years, 'K', 1) as Signed)) AS avg_starting_salary
 FROM personalized_info pI
 INNER JOIN mission_aspirations ma
 ON pi.ResponseID=Ma.ResponseID
 GROUP BY pi.Gender;
 
 
 
 -- Q.14 What is the average higher bar  salary expectations at 3Y for each gender?
 
 SELECT pi.Gender,
 AVG (Cast(substring_index(substring_index(ExpectedSalary3years, 'to', -1),'k',1) as Signed)) AS avg_starting_salary
 FROM personalized_info pi
 INNER JOIN mission_aspirations ma
 ON pi.ResponseID=ma.ResponseID
 GROUP BY pi.Gender;
 
 
 
 -- Q.15 What is the average higher bar  salary expectations at 5Y for each gender?
 
 SELECT pi.Gender,
 AVG (Cast(substring_index(substring_index(ExpectedSalary5years, 'to', -1),'k',1) as Signed)) AS avg_starting_salary
 FROM personalized_info pi
 INNER JOIN mission_aspirations ma
 ON pi.ResponseID=ma.ResponseID
 GROUP BY pi.Gender;
 
 
 -- Q .16 - Q 20 
--Having doubts
