-- Retrieving the names and capacities of the dataset, where the docks available are greater than 20 and the status of the station is Active

SELECT * FROM citibike.station_status
WHERE station_status = 'active'
AND num_docks_available >20;

-- Calculate the average number of bikes available for all stations.

SELECT Avg(num_bikes_available) FROM citibike.station_status;

-- Count the number of active and inactive stations.

SELECT * From citibike.station_status;

SELECT Count(station_status)
From citibike.station_status
Where station_status = 'out_of_service';

SELECT Count(station_status)
From citibike.station_status
Where station_status = 'active';

SELECT Count(station_id) From citibike.station_status;

-- Retrieve the 5 stations with the most available bikes.

SELECT * FROM citibike.station_status
ORDER BY num_bikes_available DESC
Limit 5;

-- Delete the row with null values

DELETE FROM citibike.station_status
WHERE station_id IS NULL;

-- Checking if the null is gone

SElect Count(station_id) FROM citibike.station_status
WHERE station_id IS NULL;

-- Find the station with the fewest available docks.

SELECT station_id, station_status,num_bikes_available,MIN(num_docks_available) AS fewest_docs
FROM citibike.station_status
WHERE num_docks_available >0 AND station_status ='active'
GROUP BY station_id, station_status,num_bikes_available
ORDER BY fewest_docs ASC;

-- Calculate the total number of docks available across all stations which are active

SELECT SUM(num_docks_available) AS total_sum
FROM citibike.station_status
WHERE station_status = 'active'
AND num_docks_available >0;

-- List the stations that have the word "Park" in their name.

SELECT * from CITIBIKE.station;

-- List the stations that have the word "Park" in their name.

SELECT * FROM citibike.station 
WHERE name Like '%PARK%';

-- Retrieve the station name, latitude, and longitude of the station with the highest bike-to-dock ratio 
(number of bikes available divided by the number of docks available).

ALTER TABLE citibike.station_status
ADD COLUMN bike_to_dock_ratio DECIMAL(10,2); 

UPDATE citibike.station_status
SET bike_to_dock_ratio = num_bikes_available/NULLIF(num_docks_available,0)
WHERE station_id>0;

-- Dealing with the error of restricted work environment
SET SQL_SAFE_UPDATES = 0;


select * from citibike.station_status;

UPDATE citibike.station_status
SET bike_to_dock_ratio =0 
WHERE bike_to_dock_ratio IS NULL;

select * from citibike.station_status
select * FROM citibike.station;

-- Creating a new table with all the columns in both the tables we have
CREATE TABLE citibike_combined AS
SELECT 
	station.station_id, 
    station.name,
    station.latitude,
    station.longitude,
    station.capacity,
    station_status.station_status,
    station_status.num_docks_available,
    station_status.bike_to_dock_ratio,
    station_status.num_bikes_available,
FROM citibike.station, citibike.station_status
JOIN citibike.station_status ON 
station.station_id = station_status.station_id;

DROP TABLE citibike_combined;


-- Creating a table with all the columns 
CREATE TABLE citibike_combined AS
SELECT
    station.station_id,
    station.name,
    station.latitude,
    station.longitude,
    station.capacity,
    station_status.station_status,
    station_status.num_docks_available,
    station_status.bike_to_dock_ratio,
    station_status.num_bikes_available
FROM citibike.station
JOIN citibike.station_status ON station.station_id = station_status.station_id;

SELECT * From citibike_combined;



