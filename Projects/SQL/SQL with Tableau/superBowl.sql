-- SuperBowl Winners from 1967-2020
SELECT Winner AS Champions,
DATE AS Years
FROM superbowl;

-- SuperBowl champion with highest points tally
SELECT Winner AS Champions, 
Winner_Pts AS Points, 
Date
FROM superbowl
WHERE Winner_Pts = (
SELECT MAX(Winner_Pts)
FROM superbowl);

-- SuperBowl champion with lowest points tally
SELECT Winner AS Champions, 
Winner_Pts AS Points, 
Date
FROM superbowl
WHERE Winner_Pts = (
SELECT MIN(Winner_Pts)
FROM superbowl);

-- SuperBowl runner-up with highest point tally
SELECT Loser AS Runners_up, 
Loser_Pts AS Points, 
Date
FROM superbowl
WHERE Loser_Pts = (
SELECT MAX(Loser_Pts)
FROM superbowl);

-- SuperBowl runner-up with lowest point tally
SELECT Loser AS Runners_up, 
Loser_Pts AS Points, 
Date
FROM superbowl
WHERE Loser_Pts = (
SELECT MIN(Loser_Pts)
FROM superbowl);

-- Number of times the franchise has won the SuperBowl
SELECT Winner, COUNT(Winner) AS Count
FROM superbowl
GROUP BY Winner
ORDER BY COUNT(Winner) DESC;

-- Number of times the franchise has lost the SuperBowl
SELECT Loser AS Runners_up, COUNT(Loser) AS Count
FROM superbowl
GROUP BY Loser
ORDER BY COUNT(Loser) DESC;

-- Was curious to see how many Brady's lost, turns out it was 3
SELECT Loser, Date
FROM superbowl
WHERE Loser = 'New England Patriots';

-- Most amount of MVPs by a player and when
SELECT MVP, COUNT(MVP)
FROM superbowl
GROUP BY MVP
ORDER BY COUNT(MVP) DESC;

-- QUERY FOR TEAMS WHO'VE APPEARED IN THE SUPERBOWL. JUST RUNNING THE INNER QUERY WILL SUFFICE FOR THE LIST
SELECT COUNT(*) AS Count
FROM
(SELECT Winner FROM superbowl
UNION
SELECT Loser FROM superbowl)
superbowl;

-- STATE WHICH HELD THE MOST SUPERBOWLS
SELECT State, COUNT(STATE)
FROM superbowl
GROUP BY State
ORDER BY COUNT(STATE) DESC;

-- CITIES WHICH HELD THE MOST SUPERBOWLS
SELECT City, STATE, COUNT(City)
FROM superbowl
GROUP BY City, State
ORDER BY COUNT(City) DESC;

-- STADIUMS WITH THE MOST MATCHES HELD
SELECT Stadium, State, COUNT(Stadium)
FROM superbowl
GROUP BY Stadium, State
ORDER BY COUNT(Stadium) DESC;

-- CHECK HOW MANY TIMES A TEAM HAS WON; WAS 3 FOR BRONCOS. 
-- SIMILARLY REPLACING WINNER FOR LOSER WILL GIVE HOW MANY TIMES A TEAM HAS LOST
SELECT Winner, COUNT(Winner) AS Times
FROM superbowl
WHERE Winner = 'Denver Broncos';

-- CHECK HOW MANY TIMES A TEAM HAS APPEARED IN THE SB
-- RUN THE QUERY ABOVE AND THE ONE BELOW
SELECT Loser, COUNT(Loser) AS Times
FROM superbowl
WHERE Loser = 'Denver Broncos';

-- GIVES WON 3, LOST 5 WHICH EQUALS 8 APPEARANCES IN THE SB 




