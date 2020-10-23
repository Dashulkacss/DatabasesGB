-- Практическое задание по теме “Оптимизация запросов”
-- 1.Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

use shop;
create table logs(
	created_at datetime not null,
	tbl_name varchar(45) not null,
	id bigint(20) not null,
	name varchar(45) not null
) Engine = archive;

drop trigger if exists log_users;
delimiter //
create trigger log_users after insert on users
for each row
begin
	insert into logs (created_at, tbl_name, id, name)
	values (NOW(), 'users', new.id, new.name);
end //


drop trigger if exists log_catalogs;
delimiter //
create trigger log_catalogs after insert on catalogs
for each row
begin
	insert into logs (created_at, tbl_name, id, name)
	values (NOW(), 'catalogs', new.id, new.name);
end //

drop trigger if exists log_products;
delimiter //
create trigger log_products after insert on products
for each row
begin
	insert into logs (created_at, tbl_name, id, name)
	values (NOW(), 'products', new.id, new.name);
end //


delimiter ;

-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.


-- Практическое задание по теме “NoSQL”

-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.



-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 
-- поиск электронного адреса пользователя по его имени.


-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.