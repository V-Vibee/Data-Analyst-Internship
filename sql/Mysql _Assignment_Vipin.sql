USE genzdataset ;

SHOW tables;

SELECT * FROM manager_aspirations;

SELECT* from learning_aspirations ;

SELECT* from mission_aspirations ;

SELECT* from personalized_info ;

# Joining all Tables using common column Responseid
 
 SELECT *
 FROM manager_aspirations AS MA
 JOIN learning_aspirations AS LA
 ON LA.ResponseID = MA.ResponseID
 JOIN mission_aspirations AS MI
ON MI.ResponseID = LA.ResponseID
JOIN personalized_info AS PI
ON PI.ResponseID = LA.ResponseID;

# Excercise questions

# 1. How many males responded from India ? 
SELECT COUNT(ResponseID) AS Total_males
FROM personalized_info 
WHERE gender LIKE 'Male%' AND  currentcountry = 'India';


# 2. How many females responded from India ? 
 SELECT COUNT(ResponseID) AS Total_females
FROM personalized_info 
WHERE gender LIKE 'Female%' AND  currentcountry = 'India';


# 3. How many Gen-Z are influenced by their parents in regards to their career choices who belong to India? 
SELECT count(LA.ResponseID) AS Total_count
FROM learning_aspirations AS LA
JOIN personalized_info AS PI
ON PI.ResponseID = LA.ResponseID
WHERE LA.careerinfluencefactor = 'My Parents' AND PI.currentcountry = 'India';


# 4. How many of Female Gen-Z are influenced by their parents in regards to their career choices who belong to India ?
SELECT count(LA.ResponseID) AS Total_count_Females
FROM learning_aspirations AS LA
JOIN personalized_info AS PI
ON PI.ResponseID = LA.ResponseID
WHERE LA.careerinfluencefactor = 'My Parents' 
AND PI.currentcountry = 'India' 
AND PI.gender Like 'Female%';


# 5. How many of male Gen-Z are influenced by their parents in regards to their career choices who belong to India ?
SELECT count(LA.ResponseID) AS Total_count_males
FROM learning_aspirations AS LA
JOIN personalized_info AS PI
ON PI.ResponseID = LA.ResponseID
WHERE LA.careerinfluencefactor = 'My Parents' 
AND PI.currentcountry = 'India' 
AND PI.gender Like 'male%';


# 6. How many  Male and Female Gen-Z are influenced by their parents with regard to career choice who belong to India. ?
SELECT PI.gender, count(LA.ResponseID) AS Total_count
FROM learning_aspirations AS LA
JOIN personalized_info AS PI
ON PI.ResponseID = LA.ResponseID
WHERE LA.careerinfluencefactor = 'My Parents' 
AND PI.currentcountry = 'India' 
GROUP BY PI.gender;


# 7.  How many GenZ are influenced by both  media and influencers together from India? #
SELECT count(LA.ResponseID) AS Total_count
FROM learning_aspirations AS LA
JOIN personalized_info AS PI
ON PI.ResponseID = LA.ResponseID
WHERE  PI.currentcountry = 'India' AND CareerInfluenceFactor LIKE ('%influencer%') OR
CareerInfluenceFactor LIKE('%media%');


# 8.  How many GenZ are influenced by both social media and influencers together from India?, Display Male and Female Seperately #
SELECT PI.gender, count(LA.ResponseID) AS Total_count
FROM learning_aspirations AS LA
JOIN personalized_info AS PI
ON PI.ResponseID = LA.ResponseID
WHERE LA.careerinfluencefactor = 'My Parents' 
AND PI.currentcountry = 'India' AND CareerInfluenceFactor LIKE ('%influencer%') OR
CareerInfluenceFactor LIKE('%social%')
GROUP BY PI.gender;


# 9. How many GenZ influenced by the social media are looking forward to go abroad? 

SELECT count(LA.responseid) AS Looking_to_go_abroad
FROM learning_aspirations AS LA
JOIN personalized_info AS PI
ON PI.ResponseID = LA.ResponseID
WHERE CareerInfluenceFactor LIKE('%social%') AND highereducationabroad LIKE ('%yes%');

# 10. How many GenZ influenced by "people in their circle" are looking forward to go abroad? #
SELECT count(LA.ResponseID) AS Looking_to_go_abroad
FROM learning_aspirations AS LA
JOIN personalized_info AS PI
ON PI.ResponseID = LA.ResponseID
WHERE CareerInfluenceFactor LIKE('%people from my circle%') and highereducationabroad like ('%yes%');