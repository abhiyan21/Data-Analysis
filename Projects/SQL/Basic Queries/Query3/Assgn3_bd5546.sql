-- Q1
SELECT DISTINCT CONCAT(first_name, ' ', last_name) AS 'Full Name', 
TIMESTAMPDIFF(YEAR, birth_date, NOW()) AS Age, address AS 'Address', contact_no AS 'Contact Number'
FROM artists
ORDER BY Age DESC
LIMIT 5;


-- Q2
SELECT CONCAT(first_name, ' ', last_name) AS 'Actors in Star Wars'
FROM artists
JOIN movie_cast
ON artists.artist_id = movie_cast.person_id
JOIN movies
ON movies.movie_id = movie_cast.movie_id
WHERE title = 'Star Wars'
AND Profession = 'Actor';


-- Q3
SELECT title AS 'Title'
FROM movies
NATURAL JOIN movies_ratings
WHERE number_of_stars =
	(SELECT MIN(number_of_stars) 
     FROM movies_ratings) 
     AND movie_id IN 
		(SELECT movie_id 
         FROM awards 
         WHERE category = 'Actor');


-- Q4
SELECT genre AS 'Genre', COUNT(movie_id) AS 'Number of Movies', YEAR(release_date) AS 'Release Year'
FROM movies 
GROUP BY YEAR(release_date), genre;


-- Q5
SELECT title AS 'Title'
FROM movies
JOIN awards
WHERE awards.movie_id = movies.movie_id
GROUP BY title
HAVING COUNT(awards_id)>=3;
     
     
-- Q6
SELECT title AS 'Title', year(release_date) AS 'Year', Distributor 
FROM movies m
JOIN movies_ratings mr
ON m.movie_id = mr.movie_id
WHERE number_of_stars IS NULL
ORDER BY release_date;


-- Q7
SELECT DISTINCTROW title AS 'Title' ,category AS 'Category'
FROM movies 
NATURAL JOIN awards 
WHERE Distributor = 'Disney';


-- Q8
SELECT DISTINCT Profession AS 'Professions in Music Industry'
FROM artists 
WHERE Profession NOT LIKE 'R%';