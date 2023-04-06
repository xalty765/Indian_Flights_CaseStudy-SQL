

/* --------------------
        Case Study 
   --------------------*/
-- Author: Sankalp Sachan
-- Tool: MySQL Server

-- Data Cleaning 
/* 
Combining Date of journey and Departure Time into a new column names Departure
*/
ALTER TABLE flights 
ADD COLUMN departure DATETIME;

UPDATE flights
SET departure = STR_TO_DATE(CONCAT(date_of_journey,' ',dep_time),'%Y-%m-%d %H:%i');

/* 
Splitting durating in hours and mins 
Converting it all together in mins for new column duration_mins
*/

ALTER TABLE flights
ADD COLUMN duration_mins INT NULL,
ADD COLUMN arrival DATETIME;


SELECT 
    REPLACE(SUBSTRING_INDEX(duration, ' ', 1),
        'h',
        '') * 60 + CASE
        WHEN SUBSTRING_INDEX(duration, ' ', - 1) = SUBSTRING_INDEX(duration, ' ', 1) THEN 0
        ELSE (REPLACE(SUBSTRING_INDEX(duration, ' ', - 1),'m',''))
    END AS 'mins'
FROM
    flights;

UPDATE flights
SET duration_mins = REPLACE(SUBSTRING_INDEX(duration,' ',1),'h','') * 60 + 
CASE
	WHEN SUBSTRING_INDEX(duration,' ',-1) = SUBSTRING_INDEX(duration,' ',1) THEN 0
    ELSE REPLACE(SUBSTRING_INDEX(duration,' ',-1),'m','')
END;

