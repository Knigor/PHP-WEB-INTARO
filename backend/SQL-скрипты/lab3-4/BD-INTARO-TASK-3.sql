

-- Скрипт создания БД

CREATE TABLE lab3_php (
    id_form serial PRIMARY KEY,
    fio varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    phone varchar(100) NOT NULL,
    text_message text NOT NULL,
    data_send timestamp NOT NULL DEFAULT NOW(),
    interval_data timestamp
);


-- Тригер который срабатывает перед добавлением значения, берет текущее время, прибавляет 1.5 часа 

CREATE OR REPLACE FUNCTION insert_interval_data()
RETURNS TRIGGER AS $$
BEGIN
    -- Сохраняем текущее значение data_send в interval_data
    NEW.interval_data := NEW.data_send;
    
    -- Прибавляем к текущему значению data_send интервал 1.5 часа и сохраняем в interval_data
    NEW.interval_data := NEW.interval_data + INTERVAL '1 hour 30 minutes';
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_insert_interval_data
BEFORE INSERT ON lab3_php
FOR EACH ROW EXECUTE FUNCTION insert_interval_data();



select data_send  from lab3_php
where id_form = 1;

select * from lab3_php lp;


select data_send, interval_data  from lab3_php lp
where email = 'aboba@mail.ru'
order by id_form desc
limit 1;
	



-- 3 задание по БД



-- Запросы для 1 пункта

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
    order_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    field_name VARCHAR(50) NOT NULL,
    old_value VARCHAR(255),
    new_value VARCHAR(255)
);


INSERT INTO order_history (order_id, created_at, field_name, old_value, new_value) VALUES
(1, '2024-01-01 10:00:00', 'status_id', NULL, '1'),
(1, '2024-01-02 12:00:00', 'status_id', '1', '2'),
(1, '2024-01-03 14:00:00', 'status_id', '2', '3'),
(2, '2024-01-01 11:00:00', 'status_id', NULL, '1'),
(2, '2024-01-02 13:00:00', 'status_id', '1', '2'),
(3, '2024-01-01 12:00:00', 'status_id', NULL, '1'),
(3, '2024-01-03 15:00:00', 'status_id', '1', '3'),
(3, '2024-01-04 16:00:00', 'status_id', '3', '4');


WITH status_changes AS (
    SELECT 
        order_id,
        created_at,
        new_value AS status_id,
        LEAD(created_at) OVER (PARTITION BY order_id ORDER BY created_at) AS next_created_at
    FROM 
        order_history
    WHERE 
        field_name = 'status_id'
),
status_durations AS (
    SELECT 
        status_id,
        EXTRACT(EPOCH FROM (COALESCE(next_created_at, '2024-06-13 15:00:00') - created_at)) / 60 AS duration -- Перевод в минуты
    FROM 
        status_changes
)
SELECT 
    status_id,
    AVG(GREATEST(duration, 0)) AS average_duration
FROM 
    status_durations
GROUP BY 
    status_id
ORDER BY 
    status_id;



   
select * from order_history;

   
   
   
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


ALTER TABLE customer_visit_page
ADD CONSTRAINT fk_customer_visit
FOREIGN KEY (visit_id) REFERENCES customer_visit (visit_id);


select * from customer_visit cv;

select * from customer_visit_page cvp;

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
   
   
   -- здесь мы выводим даты последних визитов у двух пользователей
   
select * from customer_visit cv;
select * from customer_visit_page cvp;
   
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
   
   
   -- 3 
   
 select * from customer_visit cv;

 select * from customer_visit_page cvp;




SELECT customer_id, landing_page, exit_page
FROM customer_visit cv
WHERE visit_length > (
    SELECT ROUND(AVG(visit_length), 0)
    FROM customer_visit
);


   
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

-- Предположим также, что у всех заказов есть по крайней мере один визит
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


SELECT 
    o.manager_id AS manager_id,
    AVG(EXTRACT(EPOCH FROM (o.created_at - v.visit_time)) / 3600) AS avg_order_completion_time,
    SUM(CASE WHEN o.status_id = 3 THEN 1 ELSE 0 END)::FLOAT / COUNT(*) AS cancellation_rate,
    SUM(o.total_sum) AS total_completed_orders,
    AVG(o.total_sum) AS avg_order_cost
FROM 
    orders o
JOIN 
    visits v ON o.customer_id = v.customer_id
GROUP BY 
    o.manager_id;


  
-- последний отчет
   
   
   WITH manager_metrics AS (
    SELECT 
        o.manager_id,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN o.status_id = 1 THEN 1 ELSE 0 END) AS completed_orders,
        AVG(EXTRACT(EPOCH FROM (o.created_at - v.visit_time)) / 3600) AS avg_order_completion_time,
        SUM(CASE WHEN o.status_id = 3 THEN 1 ELSE 0 END)::FLOAT / COUNT(*) AS cancellation_rate
    FROM 
        orders o
    JOIN 
        visits v ON o.customer_id = v.customer_id
    GROUP BY 
        o.manager_id
),
overall_metrics AS (
    SELECT 
        COUNT(*) AS total_orders,
        SUM(CASE WHEN status_id = 1 THEN 1 ELSE 0 END) AS completed_orders,
        AVG(EXTRACT(EPOCH FROM (o.created_at - v.visit_time)) / 3600) AS avg_order_completion_time,
        SUM(CASE WHEN status_id = 3 THEN 1 ELSE 0 END)::FLOAT / COUNT(*) AS cancellation_rate
    FROM 
        orders o
    JOIN 
        visits v ON o.customer_id = v.customer_id
)
SELECT 
    mm.manager_id,
    (mm.completed_orders::FLOAT / mm.total_orders - om.completed_orders::FLOAT / om.total_orders) +
    (mm.avg_order_completion_time - om.avg_order_completion_time) -
    (mm.cancellation_rate - om.cancellation_rate) AS manager_rating
FROM 
    manager_metrics mm,
    overall_metrics om;
   
   
   
   
   
-- 4 лаба Индексы 
   
   
  -- создаем таблицу
   
   CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP,
    active BOOLEAN,
    sort INT,
    price NUMERIC,
    code CHAR(255),
    name CHAR(255),
    description CHAR(255)
);


INSERT INTO products (created_at, active, sort, price, code, name, description) VALUES
('2023-01-01 12:00:00', TRUE, 1, 19.99, 'A001', 'Product 1', 'Description for Product 1'),
('2023-02-01 13:30:00', TRUE, 2, 29.99, 'A002', 'Product 2', 'Description for Product 2'),
('2023-03-01 14:45:00', FALSE, 3, 39.99, 'A003', 'Product 3', 'Description for Product 3'),
('2023-04-01 16:00:00', TRUE, 4, 49.99, 'A004', 'Product 4', 'Description for Product 4'),
('2023-05-01 17:15:00', FALSE, 5, 59.99, 'A005', 'Product 5', 'Description for Product 5'),
('2023-06-01 18:30:00', TRUE, 6, 69.99, 'A006', 'Product 6', 'Description for Product 6'),
('2023-07-01 19:45:00', TRUE, 7, 79.99, 'A007', 'Product 7', 'Description for Product 7');

select * from products;


-- Создание индекса B-дерева на поле active
CREATE INDEX idx_products_active ON products (active);


-- Создание хеш-индекса на поле code
CREATE INDEX idx_products_code_hash ON products USING hash (code);


-- Создание BRIN индекса на поле created_at
CREATE INDEX idx_products_created_at_brin ON products USING brin (created_at);


-- Создание частичного индекса на поле price для активных продуктов
CREATE INDEX idx_products_price_active_partial ON products (price) WHERE active = true;



-- Запрос 1  страница товара
EXPLAIN ANALYZE
SELECT * FROM products WHERE active = true AND id = 4;


-- Запрос 2  список товаров по умолчанию
EXPLAIN ANALYZE
SELECT * FROM products WHERE price > 50 ORDER BY created_at DESC;



-- Запрос 3 список товаров, отсортированный по цене
EXPLAIN ANALYZE
SELECT * FROM products WHERE name LIKE 'Product%' ORDER BY sort ASC;


-- Запрос 4 список товаров, отобранный менеджером

EXPLAIN ANALYZE
SELECT * FROM products WHERE created_at >= '2023-01-01' AND created_at < '2024-01-01';


-- Запрос 5 - поиск товаров
EXPLAIN ANALYZE
SELECT * FROM products WHERE code = 'A002';



-- Запрос 6 отчет по недавно добавленным товарам

EXPLAIN ANALYZE
SELECT * FROM products WHERE active = false ORDER BY price ASC;



-- для json таблицы



CREATE TABLE api_responses (
    id SERIAL PRIMARY KEY,
    json_data JSONB
);


INSERT INTO api_responses (json_data) VALUES
('{"status": "success", "data": {"id": 1, "name": "Test 1"}}'),
('{"status": "error", "message": "Invalid request"}'),
('{"status": "success", "data": {"id": 2, "name": "Test 2"}}'),
('{"status": "error", "message": "Server error"}');

select * from api_responses;

CREATE INDEX api_index ON api_responses USING gist(json_data);






   
   




















	
	