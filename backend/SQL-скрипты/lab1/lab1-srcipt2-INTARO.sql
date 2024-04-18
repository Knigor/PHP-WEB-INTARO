
-- Создание тестовых таблиц


CREATE TABLE example_table (
    id serial PRIMARY KEY,
    name VARCHAR(50)
);



create table test (
	id SERIAL,
	username VARCHAR (255) unique not null,
	password VARCHAR (55) not null
);




-- Выборка данных из таблиц

select * from anime a;

select * from "user";


-- Добавление данных в таблицу

insert into "user" (email, id_profile, name_user, hash_password, date_registration,type_user)
values 
	('aboba1@mail.ru', 1, 'aboba1', '123456', '2024-02-24', 'Regular'),
	('aboba2@mail.ru', 1, 'aboba2', '123456', '2024-02-24', 'Regular'),
	('aboba3@mail.ru', 1, 'aboba3', '123456', '2024-02-24', 'Regular'),
	('aboba4@mail.ru', 1, 'aboba4', '123456', '2024-02-24', 'Regular'),
	('aboba5@mail.ru', 1, 'aboba5', '123456', '2024-02-24', 'Regular'),
	('aboba6@mail.ru', 1, 'aboba6', '123456', '2024-02-24', 'Regular');



-- Join запросы


select * from anime;

select * from review;

select * from rating_anime ra;


-- Inner join запрос 

select anime.title_anime, ra.rating
from anime
inner join rating_anime ra
on anime.title_anime = ra.title_anime;


-- left join запрос

select anime.images, anime.director, ra.date_rating
from anime
left outer join rating_anime ra
on ra.title_anime = anime.title_anime;


select title_anime, rating, email 
from rating_anime ra;


select * from rating_anime ra;

-- Обновляем данные в таблице rating_anime

update rating_anime
set rating = 10
where email = 'user1@example.com' and  title_anime = 'Берсерк';


-- Удаление данных из таблицы rating_anime

delete from rating_anime
where date_rating = '2024-01-10' and title_anime = 'Берсерк';







