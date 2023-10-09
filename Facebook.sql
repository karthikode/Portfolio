


-- Retrieve the names and concentrations of all users from the 'concentration' table.

SELECT * from facebook.concentration;

-- Find the total number of profiles in the 'Profiles' table.

SELECT Count(ProfileID) from facebook.profiles;

-- List the names and favorite movies of users who are interested in women from the 'favorite movies' table.

USE Facebook;

SELECT Interestedin.ProfileID, Interestedin.Interestedin, Favoritemovies.Favoritemovie
FROM FavoriteMovies
RIGHT JOIN Interestedin  ON 
Favoritemovies.ProfileID = Interestedin.ProfileID
WHERE Interestedin.Interestedin = 'Women';


SELECT ProfileID
FROM Interestedin;

SELECT ProfileID
FROM FavoriteMovies;

-- Get the profiles of users who are currently looking for a friendship.

SELECT * FROM Lookingfor
WHERE LOOKINGFOR = 'Friendship';


-- Find the average school year of graduation from NYU among users who have specified their education status.

SELECT AVG(SUBSTRING(School, -2)+2000) AS AverageSchoolYear
FROM Profiles;

-- Medium Level:

-- Retrieve the names and hometowns of users who graduated from NYU in or after the year 2010.

SELECT name, "Home_Town", School
FROM Profiles
Where School LIKE "NYU '10" ;


-- List the top 5 most common political views among users.

SELECT PV, count(*) AS frequency
FROM PROFILES
WHERE PV IS NOT NULL
GROUP BY PV 
ORDER BY frequency DESC
Limit 5;

-- Find the names and interests of users who share the same interests as the user with a specific Profile ID.

SELECT Interests.Interests, Profiles.Name, Interests.ProfileID
FROM Profiles
LEFT JOIN Interests
ON Profiles.ProfileID = Interests.ProfileID;
WHERE Interests.Interests = Interests.Interests;

SELECT DISTINCT P1.Name, I1.Interests
FROM PROFILES AS P1
LEFT JOIN Interests AS I1 ON p1.ProfileID = I1.ProfileID
WHERE I1.Interests IN (
	SELECT I2.interests
    FROM INTERESTS AS I2
	WHERE I2.ProfileID = 'specific_profile_id')
    AND P1.profileID != 'specific_profile_id';

-- Ignore the following code
ALTER TABLE PROFILES
CHANGE COLUMN `Political Views` PV varchar(255);

SELECT PV from profiles;

SELECT COUNT(PV)

SELECT COUNT(PV)
FROM profiles
WHERE PV IS NOT NULL;

-- Get the names and favorite books of users who have not specified their favorite movies in the 'Favorite movies' table.

SELECT Profiles.Name, FavoriteBooks.Favoritebook
FROM Profiles
JOIN Favoritebooks ON 
Profiles.ProfileID = FavoriteBooks.Profile ID;

-- List the profiles of users who are interested in men and have a specific political view.

SELECT Profiles.ProfileID, Profiles.Name, Interestedin.Interestedin, Profiles.PV
FROM Interestedin
LEFT JOIN Profiles ON
Profiles.ProfileId = Interestedin.ProfileID
WHERE PV IS NOT NULL;

-- Find the names and TV shows of users who are interested in women and looking for a relationship from the 'Fav Tv shows' table.

SELECT Profiles.Name, FavoriteTVShows.FavoriteTVShow , FavoriteTVShows.ProfileID
FROM PROFILES
LEFT JOIN FavoriteTVShows ON
FavoriteTVShows.ProfileID = Profiles.ProfileID 
WHERE Profiles.ProfileID IN (
	SELECT Interestedin.ProfileID
    FROM Interestedin
    WHERE Interestedin = 'Women' 
)
AND Profiles.ProfileID IN (
	SELECT Lookingfor.ProfileID
    FROM Lookingfor
    WHERE lookingfor = 'A Relationship'
);





-- Retrieve the profiles of users who have the same concentration as another user with a specific Profile ID. XXX

SELECT Profiles.Name, Profiles.ProfileID, Concentration.concentration
FROM Profiles
LEFT JOIN Concentration ON
Profiles.ProfileID = Concentration.ProfileID
WHERE Profiles.ProfileID IN(
	SELECT Concentration.Concentration
    FROM Concentration
    WHERE concentration = concentration
);






-- List the names and interests of users who are interested in men and share at least two common interests.

SELECT * from Interests;
GROUP BY interests;

SELECT DISTINCT I1.ProfileID AS ProfileID1, I2.ProfileID AS ProfileID2, I1.Interests AS CommonInterest
FROM Interests I1
INNER JOIN Interests I2 ON I1.Interests = I2.Interests AND I1.ProfileID < I2.ProfileID;

SELECT I1.ProfileID AS ProfileID1, I2.ProfileID AS ProfileID2, COUNT(I1.Interests) AS CommonInterestsCount
FROM Interests I1
INNER JOIN Interests I2 ON I1.Interests = I2.Interests AND I1.ProfileID < I2.ProfileID
GROUP BY I1.ProfileID, I2.ProfileID
HAVING CommonInterestsCount >= 2;

SELECT I1.ProfileID AS ProfileID1, I2.ProfileID AS ProfileID2
FROM Interests I1
INNER JOIN Interests I2 ON I1.Interests = I2.Interests AND I1.ProfileID != I2.ProfileID
GROUP BY I1.ProfileID, I2.ProfileID
HAVING COUNT(*) >= 2;
