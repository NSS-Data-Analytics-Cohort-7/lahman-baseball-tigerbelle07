-- 1. What range of years for baseball games played does the provided database cover?
-- SELECT 
-- MIN(span_first) as first_game,
-- MAX(span_last) as lastest_game
-- FROM homegames
-- first_game = 1871-05-04; latest_game = 2016-10-02

-- 2.Find the name and height of the shortest player in the database. 
-- How many games did he play in? What is the name of the team for which he played?
-- A.Select * 
-- From people--start here for name, ht and weight,--join on playerid, 
--B.
-- Select *
-- From appearances--distinct count on playerid
--C.
-- Select *
-- From teams--get team info..join on teamid and maybe yearid...pull in name column to get name of team. 
-- SELECT 
-- p.namegiven,
-- p.weight,
-- p.height,
-- t.name AS team_name,
-- SUM(a.g_all) AS total_games

-- From appearances a
-- Inner Join people p
-- on a.playerid = p.playerid
-- Inner Join teams t
-- on a.teamid = t.teamid
-- and a.yearid = t.yearid

-- Group By 1,2,3,4
-- Order by p.height ASC
--edward carl - st louis browns -- 1

-- 3.Find all players in the database who played at Vanderbilt University. 
-- Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
-- Sort this list in descending order by the total salary earned. 
-- Which Vanderbilt player earned the most money in the majors?

--Tbls to pull from 
-- A. collegeplaying --filter to Vandy in WHERE clause; column schoolid=vandy
-- B. people --first & last name, 
-- C. salaries --DECS in WHERE clause
--possible tbls to use...schools, collegeplaying...and people first...then try to connect it to major leagues and salary 

-- Select 
-- p.namefirst,
-- p.namelast,
-- cp.schoolid,
-- s1.schoolname,
-- MONEY(CAST(SUM(s.salary)AS Numeric)) AS total_sal

-- From collegeplaying cp
-- Left Join schools s1 
-- on cp.schoolid = s1.schoolid
-- Left Join  people p
-- on cp.playerid = p.playerid

-- Inner Join  salaries s
-- on p.playerid = s.playerid

-- WHERE 
-- s1.schoolname = 'Vanderbilt University'
-- Group By 1,2,3,4
-- Order By total_sal DESC

-- 4.Using the fielding table, group players into three groups based on their position: 
-- label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". 
-- Determine the number of putouts made by each of these three groups in 2016.
--i think I need a CASE WHEN statement for this one. 

-- SELECT --help from team mebrs in group 3 in cleaning up my case statement
-- SUM (po), 
-- CASE WHEN pos = 'OF' THEN 'Outfield'
        
--     WHEN pos = 'SS' OR
--      pos = '1B' OR
--      pos = '2B' OR
--      pos = '3B' THEN 'Infield'
   
--  WHEN pos = 'P' OR 
--       pos = 'C' THEN 'Battery'
--      END AS Position
      
-- FROM fielding  
-- WHERE yearid = '2016'

-- Group BY position

-- 5.Find the average number of strikeouts per game by decade since 1920. 
-- Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?
--start with batting tbl  - note from Rob -"one is who struck them out and one is who stuck out"


-- SELECT 
-- teamid,
-- g as Games,
-- ((yearid/10)*10) as decade, --help from Becca
-- ROUND(AVG(SO),2) AS Avg_Strikeouts,
-- ROUND(AVG(HR),2) AS Avg_Homeruns

-- FROM batting

-- GROUP BY 1,2,3
-- ORDER BY decade DESC


--Redo 8.27.22 --help from Kevin 
-- SELECT
-- --teamid,
-- --g AS Games,
-- ((yearid/10)*10) as decade,
-- ROUND(ROUND(SUM(SO),2) / ROUND(SUM(g),2)) AS avg_so_game, --help from Tara
-- ROUND(ROUND(SUM(HR),2) / ROUND(SUM(g),2)) AS avg_hr_game

-- FROM teams
-- GROUP BY 1
-- ORDER BY decade DESC

-- 6.Find the player who had the most success stealing bases in 2016, 
--where success is measured as the percentage of stolen base attempts which are successful. 
-- (A stolen base attempt results either in a stolen base or being caught stealing.) 
-- Consider only players who attempted at least 20 stolen bases.
--possible tbls - teams for stolen bases (SB) --I need player info --so pl,--people & batting(help frm Tim) 

-- SELECT --help by tim and jake
-- p.namegiven,
-- CAST(b.sb as FLOAT)/CAST(b.sb + b.cs as FLOAT) AS pct_sb

-- FROM batting b
-- LEFT JOIN people p
-- on b.playerid = p.playerid

-- WHERE 
-- b.yearid = 2016
-- AND 
-- CAST(b.sb + b.cs as FLOAT) > 20

-- GROUP BY 1,2

-- 7.From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
-- What is the smallest number of wins for a team that did win the world series? 
-- Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. 
-- Then redo your query, excluding the problem year. 
-- How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?
--possible tbls - Teams--wrld series winner & wins

-- SELECT 
-- name,                                            
-- MAX(w) as total_wins
-- FROM teams
-- WHERE 
-- WSWin = 'Y'
-- and Yearid BETWEEN '1970' AND '2016'
-- GROUP BY 1
-- ORDER BY total_wins ASC


-- SELECT 
-- name,
-- MAX(w) as total_wins --help from tyler
-- FROM teams
-- WHERE 
-- WSWin = 'N'
-- and Yearid BETWEEN '1970' AND '2016'
-- GROUP BY 1
-- ORDER BY total_wins ASC

-- SELECT 
-- name,
-- MIN(w) as total_wins --help from tyler
-- FROM teams
-- WHERE 
-- WSWin = 'Y'
-- and Yearid BETWEEN '1970' AND '2016'
-- GROUP BY 1
-- ORDER BY total_wins ASC

-- SELECT 
-- name,
-- MIN(w) as total_wins --help from tyler
-- FROM teams
-- WHERE 
-- WSWin = 'N'
-- and Yearid BETWEEN '1970' AND '2016'
-- GROUP BY 1
-- ORDER BY total_wins ASC




-- 8.Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). 
-- Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. 
-- Repeat for the lowest 5 average attendance.
--possible tbs -homegames - attendance; games played. I need park info--parks also use homegames tbl to connect parks tbl. --teams tbl for team info.
--will have to create a sub query to connect teams to park and homegames--team from homegames can connect to teamid from teams tbl. 

-- SELECT
-- p.park_name, 
-- t.name,
-- ROUND(SUM(h.attendance),2)/ ROUND(SUM(h.games),2) as avg_attend    

-- FROM homegames h
-- LEFT JOIN parks p
-- ON h.park = p.park
-- LEFT JOIN teams t
-- ON h.team = t.teamid

-- WHERE h.games >10  
-- AND h.year = '2016'
-- GROUP BY 1,2

--Part B -lowest 5 AVG
-- SELECT
-- p.park_name, 
-- t.name,
-- ROUND(SUM(h.attendance),2)/ ROUND(SUM(h.games),2) as avg_attend    

-- FROM homegames h
-- LEFT JOIN parks p
-- ON h.park = p.park
-- LEFT JOIN teams t
-- ON h.team = t.teamid

-- WHERE h.games < 5  
-- AND h.year = '2016'
-- GROUP BY 1,2
--Fort Bragg Field(Park), Atlanta Braves(Team Name), 12,582
-- SELECT DATA_TYPE from INFORMATION_SCHEMA.COLUMNS where
-- table_schema = ’yourDatabaseName’ and table_name = ’yourTableName’.

-- 9.Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? 
-- Give their full name and the teams that they were managing when they won the award.
--possible tbls --awardsmangers, people tbl for full name, allstarfull tbl
--awardsmanagers tbl
--playerid -use to join to other tbls 
--awardid
--lgid- league info -- help from Abi, Christian & Alex

-- WITH NL AS (
    
--               SELECT 
--               playerid,
--               awardid,
--               lgid,
--               yearid
--           FROM awardsmanagers
--           WHERE lgid ='NL'
--           AND awardid ='TSN Manager of the Year'
--     ),
    
--    AL AS (
    
--               SELECT 
--               playerid,
--               awardid,
--               lgid,
--               yearid
--           FROM awardsmanagers
--           WHERE lgid ='AL'
--           AND awardid ='TSN Manager of the Year'
--     )
    
    
-- SELECT 
-- p.namegiven,
-- t.name,
-- al.lgid,
-- nl.lgid

-- FROM nl
-- INNER JOIN al
-- ON nl.playerid = al.playerid

-- LEFT JOIN people p 
-- ON nl.playerid = p.playerid AND al.playerid = p.playerid

-- LEFT JOIN teams t
-- ON nl.lgid = t.lgid AND al.yearid = t.yearid
--James Richard & David Allen...don't have teams info...ran out of steam
 


 






-- SELECT --come back to this 
-- p.namegiven,
-- t.name,
-- am.awardid,
-- am.lgid,
-- am2.awardid,
-- am2.lgid

-- FROM teams t

-- LEFT JOIN awardsmanagers am
-- ON t.yearid = am.yearid
-- and t.lgid = am.lgid
-- AND am.awardid = 'TSN Manager of the Year' 
-- AND am.lgid = 'NL'
-- AND am.lgid IS NOT NULL

-- LEFT JOIN 
-- (
-- SELECT 
-- awardid,
-- lgid    
-- FROM awardsmanagers 
 
-- WHERE    
-- awardid = 'TSN Manager of the Year' 
-- AND lgid = 'AL'
-- AND lgid IS NOT NULL
-- ) am2
-- ON t.yearid = am2.yearid
-- and t.lgid = am2.lgid

-- LEFT JOIN people p
-- ON am1.playerid = p.playerid







-- 10.Find all players who hit their career highest number of home runs in 2016. 
-- Consider only players who have played in the league for at least 10 years, and who hit at least one home run in 2016. 
-- Report the players' first and last names and the number of home runs they hit in 2016.
--possible tbls - teams, & people..maybe appearances to join to people tbl.

SELECT 
p.namegiven,
SUM(t.g)
--Max(t.hr)

FROM teams t
LEFT JOIN appearances a
ON t.yearid = a.yearid
LEFT JOIN people p
ON a.playerid = p.playerid

--WHERE
GROUP BY 1


