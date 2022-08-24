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


