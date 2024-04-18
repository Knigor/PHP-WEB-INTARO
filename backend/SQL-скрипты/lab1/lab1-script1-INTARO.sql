-- добавление с условием

insert into rating_anime (email,title_anime, year_release , rating, date_rating)
values (
		(select email from "user" where email = 'user1@example.com'),
		'Манускрипт ниндзя',
		1993,
		7,
		'2024-01-10'
	);
	


insert into rating_anime (email, title_anime, year_release, rating, date_rating)
values 
	('user1@example.com', 'Берсерк', 1997, 9, '2024-03-01');

select * from anime;

-- обновление

update anime
set discription_plot = 'тест тест'
where title_anime = 'Одинокий рокер!';





-- удаление

delete from rating_anime
where email = 'user1@example.com' and id_rating = 101;


select * from rating_anime ra;

select * from anime;

-- left join Выводит то что в rating_anime и anime

select ra.email, ra.rating
from rating_anime ra
inner join anime
on ra.title_anime = anime.title_anime;





