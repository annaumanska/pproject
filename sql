-- Создание бд и перенесение таблиц к себе
CREATE DATABASE project_Anna;
USE project_Anna;

USE project_220424ptm_Olessya_Moisseyenko;
CREATE TABLE project_Anna.actor AS
SELECT * FROM project_220424ptm_Olessya_Moisseyenko.actor;
CREATE TABLE project_Anna.category AS
SELECT * FROM project_220424ptm_Olessya_Moisseyenko.category;
CREATE TABLE project_Anna.film AS
SELECT * FROM project_220424ptm_Olessya_Moisseyenko.film;
CREATE TABLE project_Anna.film_actor AS
SELECT * FROM project_220424ptm_Olessya_Moisseyenko.film_actor;
CREATE TABLE project_Anna.film_category AS
SELECT * FROM project_220424ptm_Olessya_Moisseyenko.film_category;


SELECT * FROM search_history;
-- Создание таблицы для сохранение поисков пользователей
CREATE TABLE search_queries1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
	nick VARCHAR(50),
    query_text VARCHAR(255) NOT NULL,
    date DATETIME DEFAULT CURRENT_TIMESTAMP
);
SELECT 
    *
FROM
    search_queries1;


-- добавление айдишника у меня почему-то его не было...
ALTER TABLE project_Anna.category
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

-- поиск слов по описанию
SELECT 
    f.title, f.release_year, f.description
FROM
    film f
WHERE
    f.title LIKE '%ac%'
        OR f.description LIKE '%ac%'
LIMIT 10
;
SELECT 
    f.title, f.release_year, f.description
FROM
    film f;

-- джоиним таблицы (WHERE я проверила, что совпадает категория с названием фильма)
SELECT 
    f.title, c.name
FROM
    category c
        JOIN
    film_category fc ON c.id = fc.category_id
        JOIN
    film f ON f.film_id = fc.film_id
-- WHERE f.title = 'HEAVEN FREEDOM'
;
-- выбираем жанр
SELECT 
    name
FROM
    project_Anna.category
WHERE
    id = 1;
    
    
    
-- выбираем фильм, по категориям и дате, первый вариант, если клиент хочет выбрать между годами
SELECT f.title, f.release_year
FROM project_Anna.film f
JOIN project_Anna.film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id = 5 AND f.release_year BETWEEN 2021 AND 2022
-- order by добавить по какому выбору
-- LIMIT 10
;
SELECT *
FROM project_Anna.film f
JOIN project_Anna.film_category fc ON f.film_id = fc.film_id
-- WHERE fc.category_id = 5 AND f.release_year BETWEEN 2021 AND 2022
-- ORDER BY length DESC, rental_rate DESC, rental_duration DESC
;
-- сделать короткометражки до 60 , полные фильмы (>= 61, <=179) и свыше 3 часов
-- -------------------------------
-- -------------------------------------
SELECT CONCAT(UPPER(SUBSTRING(f.title, 1, 1)), LOWER(SUBSTRING(f.title, 2))) AS title, f.release_year
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id = 1 AND f.release_year = 2020
LIMIT 10;

-- в мою таблицу, где будет добавляться инфа от пользователей, надо что б показывала самый часто выполняемые запросы
SELECT query_text, COUNT(*) as search_count
FROM search_queries1
GROUP BY query_text
ORDER BY search_count DESC
LIMIT 10;



-- создаем таблицу с описанием рейтинга
CREATE TABLE rating_description(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
title VARCHAR(255) NOT NULL,
description VARCHAR(255) NOT NULL);


INSERT INTO rating_description(title, description)
VALUES ('G', 'Для всех');
INSERT INTO rating_description(title, description)
VALUES ('PG', 'Предлагается родительское руководство');
INSERT INTO rating_description(title, description)
VALUES ('PG-13', 'Только для взрослых, но 13+');
INSERT INTO rating_description(title, description)
VALUES ('R', 'Ограничение 18+');
INSERT INTO rating_description(title, description)
VALUES ('NC-17', 'Только для взрослых');
-- надо кое-что изменить
UPDATE rating_description
SET description = 'С родителями, с 13 лет'
WHERE title = 'PG-13';
UPDATE rating_description
SET description = 'Содержит сексуальные сцены, эпизоды с употреблением наркотиков, нецензурную брань, фрагменты с насилием и т.д.'
WHERE title = 'R';
UPDATE rating_description
SET description = 'Фильм может содержать довольно откровенные сексуальные моменты, соответствующий слэнг и эпизоды с чрезвычайным насилием.'
WHERE title = 'NC-17';

ALTER TABLE rating_description
ADD COLUMN rating INT UNIQUE;

UPDATE rating_description
SET rating = 4
WHERE title = 'NC-17';

SELECT * 
FROM rating_description;

-- Джоиним это все
SELECT f.title, f.rating, r.description
FROM film f 
LEFT JOIN rating_description r ON r.title=f.rating
;
SELECT * FROM rating_description;

SELECT rating, COUNT(*)
FROM film
GROUP BY rating
;
SELECT 
  *, 
  CASE 
    WHEN length <= 60 THEN 1
    WHEN length > 60 AND length < 180 THEN 2
    WHEN length >= 180 THEN 3
  END AS length_category
FROM film;
SELECT * FROM search_queries1
;

SELECT query_text, COUNT(*)
FROM search_queries1
GROUP BY query_text
;

SELECT * 
FROM search_queries1
WHERE query_text NOT LIKE 'Genre ID%' 
AND query_text NOT LIKE 'Номер ID%';

SELECT * 
FROM search_queries1
WHERE query_text LIKE '%Genre ID%' 
OR query_text LIKE '%Номер ID%';

SELECT title, description
FROM film;

SELECT *
FROM search_queries1;

SELECT *
FROM rating_description;


