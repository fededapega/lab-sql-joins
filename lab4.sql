USE sakila;

#List the number of films per category.

SELECT *
FROM category;
#GROUP BY name;

SELECT COUNT(name), name
FROM film_category f
JOIN category c
on f.category_id = c.category_id
GROUP BY name
ORDER BY COUNT(name) DESC;

#Retrieve the store ID, city, and country for each store.

SELECT store_id, z.country, city
FROM country z
JOIN (
			SELECT store_id, c.city, country_id
			FROM city c
			JOIN (SELECT s.store_id, a.city_id
			      FROM store s
				  JOIN address a
				  ON s.address_id = a.address_id) m
			on c.city_id = m.city_id) x
on z.country_id = x.country_id;

#took me a while..

#Calculate the total revenue generated by each store in dollars.


SELECT SUM(amount), r.store_id
FROM payment p
JOIN			(
				SELECT e.store_id, staff_id
				FROM staff f	
				JOIN store e
				ON f.store_id = e.store_id) r
ON p.staff_id = r.staff_id
GROUP BY r.store_id;


#Determine the average running time of films for each category.




SELECT xi.name, AVG(length)
FROM film fm
JOIN (
			SELECT film_id, name
			FROM category ca
			JOIN film_category f
			ON ca.category_id = f.category_id) xi
ON fm.film_id = xi.film_id
GROUP BY xi.name;
# take an average of all of the entries (in this case xi.name)


#Identify the film categories with the longest average running time.

SELECT xi.name, AVG(length)
FROM film fm
JOIN (
			SELECT film_id, name
			FROM category ca
			JOIN film_category f
			ON ca.category_id = f.category_id) xi
ON fm.film_id = xi.film_id
GROUP BY xi.name
ORDER BY AVG(length) DESC;

#Display the top 10 most frequently rented movies in descending order.

SELECT COUNT(xin.film_id), fi.title
FROM film fi
JOIN (
				SELECT inv.film_id, re.rental_id
				FROM rental re
				JOIN inventory inv
				ON re.inventory_id = inv.inventory_id) xin
ON fi.film_id = xin.film_id
GROUP BY xin.film_id
ORDER BY COUNT(xin.film_id) DESC
LIMIT 10;

# Determine if "Academy Dinosaur" can be rented from Store 1.
USE sakila;

SELECT tory.store_id, title
FROM inventory tory
JOIN(
SELECT film_id, title
FROM film
WHERE title LIKE "%ACADEMY DINOSAUR%") dino
ON tory.film_id = dino.film_id;

# Provide a list of all distinct film titles, along with their availability status in the inventory. 
# Include a column indicating whether each title is 'Available' or 'NOT available.'
# Note that there are 42 titles that are not in the inventory, 
# and this information can be obtained using a CASE statement combined with IFNULL."



