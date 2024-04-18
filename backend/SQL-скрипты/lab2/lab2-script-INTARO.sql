
-- Разобраться с функцией uuid, разобраться json, jsonp, jsonb



-- Перечисление
create type mood as enum ('happy', 'sad'); 


-- Тип составной

create type address as (
	city varchar (255),
	street varchar (255),
	fiasHouse varchar (255)
);

-- Создание таблицы для задания 2

create table task2 (
	id uuid primary key,
	lastName VARCHAR (100),
	ageMember INTEGER,
	success BOOLEAN,
	date_exam date,
	moodPerson mood,
	tags varchar(50)[],
	xml_data xml,
	json_data json,
	user_address address,
	cash money,
	fileImages BYTEA,
	coordinates point,
	bit_data bit(8)
);


insert into task2 (id, lastName, ageMember, success, date_exam, moodPerson, tags, xml_data, json_data, user_address, cash, fileimages, coordinates, bit_data)
values
	(gen_random_uuid(), 'Maxim', 26, false, '2024-02-28', 'happy', '{"red","green","blue"}','<name>Maxim</name>','{"name": "Maxim"}', ('Lipetck','Moskovskaya','42301ab8-9ead-4f8e-8281-e64f2769a254'),'$50.20', '89504e470d0a1a0a0000000d4948445200000005000000070802000000dbeda', point(0,0), B'10101010');


select * from task2 t;

-- Обновляем данные в таблице

update task2
set success = true
where lastname = 'Igor';



update task2
set moodperson  = 'sad'
where lastname = 'Igor';

-- Запрос 

select lastname, agemember, date_exam, tags  from task2;

select * from task2 t
where agemember = 22;

