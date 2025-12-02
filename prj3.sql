-- prj3-queries.sql
-- Dylan Neese
-- CS415 Final Project - 10 Required Queries with Results

-- 1. Alphabetical member list
sql'''
SELECT member_id, first_name, last_name, email FROM Members ORDER BY last_name, first_name LIMIT 10;
'''
-- Returns 10 members: Adams → Clark

-- 2. Fastest pace per km
sql'''
SELECT m.first_name, m.last_name, r.race_name, rr.finish_time,
       ROUND(TIME_TO_SEC(rr.finish_time)/60/r.distance_km,2) AS pace_min_per_km
FROM RaceResults rr JOIN Members m ON rr.member_id=m.member_id
JOIN Races r ON rr.race_id=r.race_id
ORDER BY pace_min_per_km LIMIT 8;
'''
-- Liam Garcia: 3.84 min/km

-- 3. Races per month
sql'''
SELECT MONTHNAME(race_date) AS month, COUNT(*) AS races_held
FROM Races GROUP BY month, MONTH(race_date) ORDER BY races_held DESC;
'''
-- 4. Avg 5K time by age group
       sql'''
SELECT FLOOR((YEAR(r.race_date)-YEAR(m.birth_date))/10)*10 AS age_group,
       COUNT(*) AS runners,
       SEC_TO_TIME(AVG(TIME_TO_SEC(rr.finish_time))) AS avg_5k_time
FROM RaceResults rr JOIN Members m ON rr.member_id=m.member_id
JOIN Races r ON rr.race_id=r.race_id
WHERE r.distance_km=5.00 GROUP BY age_group HAVING runners>=5 ORDER BY avg_5k_time;
'''
-- 5. Emma Johnson race history
       sql'''
SELECT m.first_name, m.last_name, r.race_name, r.race_date, r.distance_km,
       rr.finish_time, rr.overall_place
FROM Members m JOIN RaceResults rr ON m.member_id=rr.member_id
JOIN Races r ON rr.race_id=r.race_id
WHERE m.member_id=1 ORDER BY r.race_date DESC;
'''
-- 6. Members who never ran a half marathon
       sql'''
SELECT m.member_id, m.first_name, m.last_name, m.join_date
FROM Members m LEFT JOIN RaceResults rr ON m.member_id=rr.member_id AND rr.race_id IN (7,17)
WHERE rr.member_id IS NULL ORDER BY m.last_name, m.first_name LIMIT 15;
'''
-- 7. Fix Liam Garcia's winning time
       sql'''
UPDATE RaceResults SET finish_time='00:18:55', overall_place=1, age_group_place=1
WHERE member_id=2 AND race_id=1;
'''
-- 8. Remove bad data
       sql'''
DELETE FROM RaceResults WHERE race_id=3 AND member_id IN (23,34);
'''
-- 9. 5K leaderboard view
       sql'''
CREATE OR REPLACE VIEW v_5k_leaderboard AS
SELECT m.member_id, m.first_name, m.last_name, MIN(rr.finish_time) AS best_5k_time
FROM RaceResults rr JOIN Races r ON rr.race_id=r.race_id
JOIN Members m ON rr.member_id=m.member_id
WHERE r.distance_km=5.00 GROUP BY m.member_id ORDER BY best_5k_time;

SELECT * FROM v_5k_leaderboard LIMIT 10;
'''
-- 10. Transaction with ROLLBACK
       sql'''
START TRANSACTION;
INSERT INTO RaceResults (member_id,race_id,finish_time) VALUES
(5,3,'00:00:00'),(12,3,'00:00:00'),(23,3,'00:00:00'),
(34,3,'00:00:00'),(45,3,'00:00:00'),(56,3,'00:00:00');
ROLLBACK;
       ''
SELECT COUNT(*) FROM RaceResults WHERE race_id=3 AND member_id IN (5,12,23,34,45,56);

-- Returns 0
