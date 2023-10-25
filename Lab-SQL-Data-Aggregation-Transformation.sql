-- Lab | SQL Data Aggregation and Transformation

USE sakila;

-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration

SELECT MIN(LENGTH) AS 'min_duration', MAX(LENGTH) AS 'max_duration' FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals

SELECT AVG(LENGTH) AS 'average_movie_duration' FROM film;

SELECT AVG(LENGTH) AS 'avg', CONCAT(FLOOR(AVG(LENGTH)/60),'h:', LPAD(MOD(AVG(LENGTH),60),2,0),'m') AS 'average_movie_duration' FROM film;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS 'operating_days' FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results

SELECT rental_date, DATE_FORMAT(rental_date,'%M') AS 'month', DATE_FORMAT(rental_date,'%a') AS 'weekday' 
FROM rental
LIMIT 20;

-- 3. retrieve the film titles and their rental duration. If any rental duration value is NULL, 
-- replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order

SELECT title, IFNULL(rental_duration,'Not Available') AS 'rental_duration' 
FROM film 
ORDER BY title ASC;

--- 4: Bonus

SELECT first_name, last_name, email, CONCAT(first_name,' ', last_name,' ', LEFT(email,3)) AS 'customer_name'
FROM customer ORDER BY last_name ASC;`


-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released

SELECT COUNT(release_year) AS 'total_released' 
FROM film 
WHERE release_year IS NOT NULL;

-- 1.2 The number of films for each rating

SELECT rating, COUNT(rating) AS 'films_each_rating' 
FROM film 
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.

SELECT rating, COUNT(rating) AS 'films_each_rating' 
FROM film 
GROUP BY rating 
ORDER BY films_each_rating DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, round(avg(LENGTH),2) AS 'mean_each_rating' 
FROM film 
GROUP BY rating 
ORDER BY mean_each_rating DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for 
-- customers who prefer longer movies

SELECT rating, round(avg(LENGTH)/60,2) AS 'mean_each_rating' 
FROM film 
GROUP BY rating 
HAVING mean_each_rating > 2
 
-- 3. Bonus: determine which last names are not repeated in the table actor

SELECT last_name, COUNT(last_name) AS 'last_name_occurance' 
FROM actor
GROUP BY last_name 
HAVING last_name_occurance = 1


