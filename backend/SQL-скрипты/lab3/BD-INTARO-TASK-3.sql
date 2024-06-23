CREATE TABLE transactions_table (
    operation_number SERIAL PRIMARY KEY,
    operation_type VARCHAR(50),
    amount NUMERIC
);


INSERT INTO transactions_table (operation_type, amount) VALUES
('Покупка в аптеке', 50.00),
('Возврат абонемента', -100.00),
('Покупка билета', 30.00),
('Покупка в аптеке', 70.00),
('Возврат билета', -30.00),
('Покупка абонемента', 200.00),
('Покупка билета', 50.00),
('Покупка в аптеке', 40.00);


SELECT ROW_NUMBER() OVER (ORDER BY operation_number) AS row_number, *
FROM transactions_table;

-- Запросы для 2 пункта

CREATE TABLE athletes (
    athlete_id SERIAL PRIMARY KEY,
    athlete_name VARCHAR(100),
    sport_type VARCHAR(100)
);


INSERT INTO athletes (athlete_name, sport_type) VALUES
('Алексей', 'шахматы'),
('Иван', 'шахматы'),
('Мария', 'шахматы'),
('Елена', 'настольный теннис'),
('Дмитрий', 'настольный теннис'),
('Ольга', 'настольный теннис'),
('Андрей', 'футбол'),
('Светлана', 'футбол'),
('Павел', 'футбол');



SELECT *,
       ROW_NUMBER() OVER (PARTITION BY sport_type ORDER BY athlete_id) AS row_number
FROM athletes;


-- Запросы для 3 пункта

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    operation_type VARCHAR(100),
    amount NUMERIC
);



INSERT INTO transactions (operation_type, amount) VALUES
('Покупка в аптеке', 50.00),
('Возврат абонемента', -100.00),
('Покупка билета', 30.00),
('Покупка в аптеке', 70.00),
('Возврат билета', -30.00),
('Покупка абонемента', 200.00),
('Покупка билета', 50.00),
('Покупка в аптеке', 40.00);

update transactions
set amount = 70
where transaction_id = 1;

select * from transactions;

SELECT 
    transaction_id,
    operation_type,
    amount,
    SUM(amount) OVER (ORDER BY transaction_id) AS final_balance
FROM transactions;

-- 4 пункт

ALTER TABLE transactions
ADD COLUMN percent_of_total NUMERIC;

UPDATE transactions
SET percent_of_total = (amount / (SELECT SUM(amount) FROM transactions)) * 100;


SELECT SUM(amount) FROM transactions;

SELECT 
    transaction_id,
    operation_type,
    amount,
    percent_of_total,
    SUM(amount) OVER (ORDER BY transaction_id) AS final_balance
FROM transactions;


-- Пункт 5

SELECT 
    transaction_id,
    operation_type,
    amount,
    percent_of_total,
    SUM(amount) OVER (ORDER BY transaction_id) AS final_balance,
    (SELECT SUM(percent_of_total) FROM transactions) AS total_percent
FROM transactions;


-- Пункт 6

SELECT 
    transaction_id,
    operation_type,
    amount,
    percent_of_total,
    final_balance,
    total_percent
FROM (
    SELECT 
        transaction_id,
        operation_type,
        amount,
        percent_of_total,
        SUM(amount) OVER (ORDER BY transaction_id) AS final_balance,
        (SELECT SUM(percent_of_total) FROM transactions) AS total_percent
    FROM transactions
) AS subquery
WHERE final_balance < 0;



-- Задание 3.1 История изменения заказа


CREATE TABLE order_history (
    id SERIAL PRIMARY KEY,
    order_id INTEGER,
    created_at date,
    field_name VARCHAR(255),
    old_value VARCHAR(255),
    new_value VARCHAR(255)
);

INSERT INTO order_history (order_id, created_at, field_name, old_value, new_value)
VALUES
    (1, '2024-03-03', 'status_id', '1', '2'),
    (1, '2024-03-05', 'status_id', '2', '3'),
    (2, '2024-03-02', 'status_id', '1', '3'),
    (2, '2024-03-06', 'status_id', '3', '4'),
    (3, '2024-03-03', 'status_id', '1', '2'),
    (3, '2024-03-07', 'status_id', '2', '3');
   

select * from order_history;  
   
SELECT
    new_value AS "Статус заказа",
    AVG(EXTRACT(DAY FROM AGE(created_at, lag_created_at))) AS "Среднее время пребывания заказа в этом статусе (в днях)"
FROM (
    SELECT
        order_id,
        new_value,
        created_at,
        LAG(created_at) OVER (PARTITION BY order_id ORDER BY created_at) AS lag_created_at
    FROM
        order_history
    WHERE
        field_name = 'status_id'
) AS status_changes
GROUP BY
    new_value;
   
   
   
-- Задание 3.2 Визиты клиентов

   
CREATE TABLE customer_visit (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    created_at TIMESTAMP,
    visit_length INTEGER,
    landing_page VARCHAR(255),
    exit_page VARCHAR(255),
    utm_source VARCHAR(255)
);


CREATE TABLE customer_visit_page (
    id SERIAL PRIMARY KEY,
    visit_id INTEGER,
    page VARCHAR(255),
    timeon_page INTEGER
);


INSERT INTO customer_visit (customer_id, created_at, visit_length, landing_page, exit_page, utm_source)
VALUES
    (1, '2024-03-01 08:00:00', 300, '/home', '/product', 'google'),
    (1, '2024-03-02 09:00:00', 400, '/product', '/cart', 'facebook'),
    (2, '2024-03-01 10:00:00', 200, '/home', '/product', 'instagram'),
    (2, '2024-03-03 11:00:00', 350, '/product', '/checkout', 'google');
   
   
 INSERT INTO customer_visit_page (visit_id, page, timeon_page)
VALUES
    (1, '/home', 60),
    (1, '/product', 120),
    (1, '/cart', 120),
    (2, '/home', 80),
    (2, '/product', 180),
    (2, '/checkout', 90),
    (3, '/home', 100),
    (3, '/product', 150),
    (4, '/home', 90),
    (4, '/product', 200),
    (4, '/checkout', 60);
   
   -- 1
   
   SELECT 
    customer_id AS "ID клиента",
    MAX(created_at) AS "Дата последнего визита"
FROM 
    customer_visit
GROUP BY 
    customer_id;
   
   
   -- 2 
   
   
SELECT 
    cv.customer_id AS "ID клиента",
    AVG(cvp.page_views) AS "Среднее количество просмотров страниц за визит"
FROM 
    (
        SELECT 
            visit_id,
            COUNT(*) AS page_views
        FROM 
            customer_visit_page
        GROUP BY 
            visit_id
    ) AS cvp
JOIN 
    customer_visit cv ON cv.id = cvp.visit_id
GROUP BY 
    cv.customer_id;
   
   
   -- 3  не сделано 
   
   
-- 3.3 Расчет конверсии

-- Создание таблицы с визитами
CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    visit_time TIMESTAMP
);

-- Создание таблицы с информацией о клиентах
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100)
);

-- Создание таблицы с заказами
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP,
    customer_id INTEGER,
    manager_id INTEGER,
    status_id INTEGER,
    is_paid BOOLEAN,
    total_sum DECIMAL(10, 2),
    utm_source VARCHAR(100)
);   
   

INSERT INTO customers (created_at, first_name, last_name, phone, email) VALUES
    ('2024-01-01', 'John', 'Doe', '123456789', 'john@example.com'),
    ('2024-02-01', 'Jane', 'Smith', '987654321', 'jane@example.com');

INSERT INTO orders (created_at, customer_id, manager_id, status_id, is_paid, total_sum, utm_source) VALUES
    ('2024-01-05', 1, 1, 1, true, 100.00, 'Google'),
    ('2024-01-10', 1, 1, 1, true, 150.00, 'Facebook'),
    ('2024-02-05', 2, 2, 1, true, 200.00, 'Google'),
    ('2024-02-10', 2, 2, 1, true, 250.00, 'Facebook');


   
INSERT INTO visits (customer_id, visit_time) VALUES
    (1, '2024-01-01 10:00:00'),
    (1, '2024-01-06 10:00:00'),
    (2, '2024-02-01 10:00:00'),
    (2, '2024-02-06 10:00:00');
   
   
   
   -- Среднее время между заказами для каждого клиента
   
 SELECT customer_id, AVG(days_between_orders) AS avg_days_between_orders
FROM (
    SELECT customer_id,
           EXTRACT(DAY FROM (lead(visit_time) OVER (PARTITION BY customer_id ORDER BY visit_time) - visit_time)) AS days_between_orders
    FROM visits
) AS subquery
WHERE days_between_orders IS NOT NULL
GROUP BY customer_id;  


	-- Кол-во визитов и заказов для каждого клиента 

SELECT c.id AS customer_id,
       COUNT(DISTINCT v.id) AS num_visits,
       COUNT(DISTINCT o.id) AS num_orders
FROM customers c
LEFT JOIN visits v ON c.id = v.customer_id
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;



	-- Информация об источнике трафика

SELECT utm_source,
       COUNT(DISTINCT v.id) AS num_visits,
       COUNT(DISTINCT o.id) AS num_orders_created,
       COUNT(DISTINCT CASE WHEN o.is_paid THEN o.id END) AS num_paid_orders,
       COUNT(DISTINCT CASE WHEN o.status_id = 1 THEN o.id END) AS num_completed_orders
FROM orders o
LEFT JOIN visits v ON o.customer_id = v.customer_id
GROUP BY utm_source;


-- Среднее время выполнения заказов
