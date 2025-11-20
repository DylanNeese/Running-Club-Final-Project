# Running-Club-Final-Project
```sql
1. SELECT member_id, first_name, last_name, email
FROM Members
ORDER BY last_name, first_name
LIMIT 10;

   +-----------+------------+-----------+------------------------+
| member_id | first_name | last_name | email                  |
+-----------+------------+-----------+------------------------+
|        24 | Ella       | Adams     | ella.a@example.com     |
|        16 | Evelyn     | Allen     | evelyn.a@example.com   |
|        26 | Scarlett   | Baker     | scarlett.b@example.com |
|        54 | Hazel      | Barnes    | hazel.b@example.com    |
|        52 | Nora       | Bennett   | nora.b@example.com     |
|        48 | Samantha   | Brooks    | sam.b@example.com      |
|         6 | Sophia     | Brown     | sophia.b@example.com   |
|        28 | Chloe      | Campbell  | chloe.c@example.com    |
|        30 | Grace      | Carter    | grace.c@example.com    |
|        12 | Amelia     | Clark     | amelia.c@example.com   |
+-----------+------------+-----------+------------------------+

2. SELECT 
        m.first_name, 
        m.last_name,
        r.race_name,
        rr.finish_time,
        ROUND(TIME_TO_SEC(rr.finish_time) / 60 / r.distance_km, 2) AS pace_min_per_km
   FROM RaceResults rr
   JOIN Members m ON rr.member_id = m.member_id
   JOIN Races r ON rr.race_id = r.race_id
   ORDER BY pace_min_per_km
   LIMIT 8;

+------------+-----------+--------------------------+-------------+-----------------+
| first_name | last_name | race_name                | finish_time | pace_min_per_km |
+------------+-----------+--------------------------+-------------+-----------------+
| Liam       | Garcia    | Turkey Trot 5K           | 00:19:12    |            3.84 |
| Amelia     | Clark     | Jingle Bell Run 5K       | 00:20:45    |            4.15 |
| Addison    | Edwards   | Frostbite 5K             | 00:20:50    |            4.17 |
| Noah       | Davis     | Turkey Trot 5K           | 00:20:55    |            4.18 |
| Penelope   | Jenkins   | Shamrock Shuffle 5K      | 00:20:55    |            4.18 |
| Nora       | Bennett   | Father’s Day 15K         | 01:02:50    |            4.19 |
| Aubrey     | Rogers    | Valentine’s Couples 5K   | 00:21:15    |            4.25 |
| Liam       | Garcia    | Beat the Heat Evening 5K | 00:21:15    |            4.25 |
+------------+-----------+--------------------------+-------------+-----------------+

3. SELECT MONTHNAME(race_date) AS month, COUNT(*) AS races_held
      FROM Races
      GROUP BY month, MONTH(race_date)
      ORDER BY races_held DESC;

+-----------+------------+
| month     | races_held |
+-----------+------------+
| April     |          3 |
| May       |          3 |
| October   |          3 |
| February  |          3 |
| March     |          2 |
| August    |          2 |
| June      |          2 |
| January   |          2 |
| December  |          2 |
| September |          1 |
| November  |          1 |
| July      |          1 |
+-----------+------------+

4. SELECT 
       FLOOR((YEAR(r.race_date) - YEAR(m.birth_date)) / 10) * 10 AS age_group,
       COUNT(*) AS runners,
       SEC_TO_TIME(AVG(TIME_TO_SEC(rr.finish_time))) AS avg_5k_time
    FROM RaceResults rr
    JOIN Members m ON rr.member_id = m.member_id
    JOIN Races r ON rr.race_id = r.race_id
    WHERE r.distance_km = 5.00
    GROUP BY age_group
    HAVING runners >= 5
    ORDER BY avg_5k_time;

+-----------+---------+---------------+
| age_group | runners | avg_5k_time   |
+-----------+---------+---------------+
|        20 |      79 | 00:24:01.4936 |
|        30 |     114 | 00:25:31.0964 |
|        40 |       7 | 00:25:59.2857 |
+-----------+---------+---------------+

5. SELECT 
         m.first_name, m.last_name,
         r.race_name, r.race_date, r.distance_km,
         rr.finish_time, rr.overall_place
     FROM Members m
     JOIN RaceResults rr ON m.member_id = rr.member_id
     JOIN Races r ON rr.race_id = r.race_id
     WHERE m.member_id = 1
     ORDER BY r.race_date DESC;

+------------+-----------+------------------------------+------------+-------------+-------------+---------------+
| first_name | last_name | race_name                    | race_date  | distance_km | finish_time | overall_place |
+------------+-----------+------------------------------+------------+-------------+-------------+---------------+
| Emma       | Johnson   | Turkey Trot 5K               | 2025-11-27 |        5.00 | 00:23:45    |            45 |
| Emma       | Johnson   | Beat the Heat Evening 5K     | 2025-08-16 |        5.00 | 00:26:05    |            70 |
| Emma       | Johnson   | Spring Classic Half Marathon | 2025-04-12 |       21.10 | 01:45:20    |            25 |
| Emma       | Johnson   | Shamrock Shuffle 5K          | 2025-03-15 |        5.00 | 00:26:10    |            70 |
| Emma       | Johnson   | Halloween Hustle 5K          | 2024-10-26 |        5.00 | 00:27:10    |            70 |
| Emma       | Johnson   | Resolution Predict 8K        | 2024-01-01 |        8.00 | 00:38:50    |            40 |
+------------+-----------+------------------------------+------------+-------------+-------------+---------------+

6. SELECT 
         m.member_id,
         m.first_name,
         m.last_name,
         m.join_date
     FROM Members m
     LEFT JOIN RaceResults rr ON m.member_id = rr.member_id
         AND rr.race_id IN (7, 17)  -- Spring Classic & Monster Dash Half Marathons
     WHERE rr.member_id IS NULL
     ORDER BY m.last_name, m.first_name
     LIMIT 15;
   
+-----------+------------+-----------+------------+
| member_id | first_name | last_name | join_date  |
+-----------+------------+-----------+------------+
|        24 | Ella       | Adams     | 2022-11-01 |
|        26 | Scarlett   | Baker     | 2024-02-28 |
|        54 | Hazel      | Barnes    | 2022-04-27 |
|        52 | Nora       | Bennett   | 2024-06-15 |
|        28 | Chloe      | Campbell  | 2022-05-18 |
|        30 | Grace      | Carter    | 2023-04-22 |
|        57 | Caleb      | Coleman   | 2022-02-05 |
|        37 | David      | Collins   | 2021-11-20 |
|        38 | Addison    | Edwards   | 2023-03-12 |
|        33 | Samuel     | Evans     | 2021-06-25 |
|        23 | Henry      | Green     | 2019-07-10 |
|        56 | Violet     | Henderson | 2023-08-11 |
|        21 | Benjamin   | Hill      | 2021-03-15 |
|        58 | Penelope   | Jenkins   | 2024-05-23 |
|        29 | Daniel     | Mitchell  | 2021-12-03 |
+-----------+------------+-----------+------------+

7. UPDATE RaceResults 
    SET finish_time = '00:18:55', overall_place = 1, age_group_place = 1
    WHERE member_id = 2 AND race_id = 1;

   SELECT * FROM RaceResults WHERE member_id = 2 AND race_id = 1;
+-----------+-----------+---------+-------------+---------------+-----------------+
| result_id | member_id | race_id | finish_time | overall_place | age_group_place |
+-----------+-----------+---------+-------------+---------------+-----------------+
|         2 |         2 |       1 | 00:18:55    |             1 |               1 |
+-----------+-----------+---------+-------------+---------------+-----------------+

8. DELETE FROM RaceResults
     WHERE race_id = 3
     AND member_id IN (23,34);


9. CREATE OR REPLACE VIEW v_5k_leaderboard AS
     SELECT 
         m.member_id,
         m.first_name,
         m.last_name,
         MIN(rr.finish_time) AS best_5k_time
     FROM RaceResults rr
     JOIN Races r ON rr.race_id = r.race_id
     JOIN Members m ON rr.member_id = m.member_id
     WHERE r.distance_km = 5.00
     GROUP BY m.member_id, m.first_name, m.last_name
     ORDER BY best_5k_time;

   SELECT * FROM v_5k_leaderboard LIMIT 10;
+-----------+------------+-----------+--------------+
| member_id | first_name | last_name | best_5k_time |
+-----------+------------+-----------+--------------+
|         2 | Liam       | Garcia    | 00:18:55     |
|        12 | Amelia     | Clark     | 00:20:45     |
|        38 | Addison    | Edwards   | 00:20:50     |
|        58 | Penelope   | Jenkins   | 00:20:55     |
|         4 | Noah       | Davis     | 00:20:55     |
|        44 | Aubrey     | Rogers    | 00:21:15     |
|        32 | Zoe        | Phillips  | 00:21:20     |
|        16 | Evelyn     | Allen     | 00:21:40     |
|        22 | Luna       | Scott     | 00:21:40     |
|        52 | Nora       | Bennett   | 00:21:45     |
+-----------+------------+-----------+--------------+

10. INSERT INTO RaceResults (member_id, race_id, finish_time, overall_place, age_group_place) VALUES
     (5, 3, '00:00:00', NULL, NULL),
     (12, 3, '00:00:00', NULL, NULL),
     (23, 3, '00:00:00', NULL, NULL),
     (34, 3, '00:00:00', NULL, NULL),
     (45, 3, '00:00:00', NULL, NULL),
     (56, 3, '00:00:00', NULL, NULL);

    ROLLBACK;

    SELECT COUNT(*) 
     FROM RaceResults
     WHERE race_id = 3
       AND member_id IN (5,12,23,34,45,56);
+----------+
| COUNT(*) |
+----------+
|        0 |
+----------+
