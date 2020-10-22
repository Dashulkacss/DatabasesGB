
-- 1) В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

start transaction;
insert into sample.users select * from shop.users where id = 1;
commit;


-- 2) Создайте представление, которое выводит название name товарной позиции из таблицы products и 
-- соответствующее название каталога name из таблицы catalogs.

use shop;

create or replace view prod_cat(name, catalog_name) as
	select p.name, c.name from products p left join catalogs as c on p.catalog_id = c.id;

select * from prod_cat;


-- 3) (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи 
-- за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список 
-- дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.




-- 4 (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

drop table datetbl ;
create table datetbl (
	created_at date	
);

insert into datetbl values
	('2016-08-01'),
	('2018-08-04'),
	('2020-08-16'),
	('2020-08-04'),
	('2018-08-16'),
	('2018-08-17');

select * from datetbl ;
delete from datetbl where created_at not in 
	(select * from (select * from datetbl order by created_at desc limit 5) as foo);
select * from datetbl ;


--- Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)
-- 1) Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.

create user shop_read;
create user shop identified;

grant select on shop.* to shop_read;
grant all on shop.* to shop;
grant grant option on shop.* to shop;


create user shop identified with sha256_password by 'pass';

-- 2) (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, 
-- содержащие первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts, 
-- предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts, 
-- однако, мог бы извлекать записи из представления username.

create table accounts(
	id serial primary key,
	name varchar(45),
	password varchar(45)
);

insert into accounts values
	(NULL, 'Jhon', '1234'),
	(NULL, 'Leo', '1234'),
	(NULL, 'Nill', '1234');

create or replace view username(user_id, user_name) as
	select id, name from accounts;

drop user if exists 'shop_reader'@'localhost';
create user 'shop_reader'@'localhost' identified with sha256_password by '123';
grant select on shop.username to 'shop_reader'@'localhost';


-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 1) Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

delimiter //
create procedure hello()
begin
	case 
		when curtime() between '06:00:00' and '12:00:00' then 
			select 'Доброе утро';
		when curtime() between  '12:00:00' and '18:00:00' then 
			select 'Добрый день';
		when curtime() between  '18:00:00' and '00:00:00' then 
			select 'Добрый вечер';
		else 
			select 'Доброй ночи';
	end case;
end //

call hello();

-- 2) В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение 
-- необходимо отменить операцию.

select * from products p 
delimiter //
create trigger products_update before insert on products
	for each row
	begin 
		if(isnull(new.name) and isnull(new.description)) then
		signal sqlstate '45000' set message_text = 'Ты поставил везде Null так нельзя';
	end if; 
		
	end //
	
	insert into products (name, description, price, catalog_id)
values (NULL, NULL, 10000, 2);


-- 3) (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность 
-- в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.




