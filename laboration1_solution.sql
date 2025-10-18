-- Task 1
-- Create a table with all columns from moon_mission
-- outcome = 'Successful', by CREATE TABLE ... AS SELECT
-- DROP TABLE IF EXISTS successfull_mission;
-- CREATE TABLE successful_mission AS
   -- SELECT
        -- mission_id,
      --  spacecraft,
      --  launch_date,
      --  carrier_rocket,
    --    operator,
    --    mission_type,
    --    outcome
  --  FROM moon_mission
-- where outcome = 'Successful';

-- Verify
SELECT COUNT(*) AS count_of_successful_missions FROM successful_mission;
SELECT * FROM successful_mission LIMIT 5;