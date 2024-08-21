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
-- LIMIT 10
;

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

-- 
SELECT id, name
FROM category;
