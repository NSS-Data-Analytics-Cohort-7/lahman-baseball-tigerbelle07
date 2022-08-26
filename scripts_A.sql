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

