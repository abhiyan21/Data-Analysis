-- Q1
CREATE VIEW movies_legendary_technicians_v AS
SELECT DISTINCT title AS Movie, CONCAT (first_name, " ", last_name) AS Technicians, TIMESTAMPDIFF(YEAR, birth_date, NOW()) AS Age
FROM movies m
JOIN movie_cast mc
ON m.movie_id = mc.movie_id
JOIN artists a
ON mc.person_id = a.artist_id
WHERE TIMESTAMPDIFF(YEAR, birth_date, NOW())>40
ORDER BY Age;

SELECT * FROM movies_legendary_technicians_v;

-- Q2
DROP PROCEDURE IF EXISTS must_watch_movies;
DELIMITER //
CREATE PROCEDURE must_watch_movies()
BEGIN	
   DECLARE mTitle VARCHAR(45); 
   DECLARE mDistributor VARCHAR(45); 
   DECLARE mRelease int;
   DECLARE result VARCHAR(1000) DEFAULT "";
   DECLARE no_records INTEGER DEFAULT FALSE;
   DECLARE cursor_movies CURSOR FOR
   SELECT title, Distributor, year(release_date) 
   FROM movies
   WHERE gross > 2
   ORDER BY title;
   
   DECLARE CONTINUE HANDLER FOR NOT FOUND
	SET no_records = TRUE;
        
   OPEN cursor_movies;
    WHILE no_records = FALSE DO
	 FETCH cursor_movies INTO mTitle, mDistributor, mRelease;
     SET result = CONCAT(result, "'", mTitle, "','", mDistributor, "','", mRelease,"'", "|");
    END WHILE;
   CLOSE cursor_movies;
   SELECT result AS "Output";
END//

DELIMITER ;

CALL must_watch_movies();

