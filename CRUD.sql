-- CRUD

-- create INSERT
-- read SELECT *
-- update 
-- delete, truncate

-- INSERT ... VALUES

INSERT INTO users (id, name, surname, email, phone, gender, birthday, hometown, photo_id, pass, created_at) 
VALUES ('1', 'Floy', 'Graham', 'emmett.predovic@example.com', '802', 'm', '1985-09-21', 'Geovannyport', NULL, 
'59322dcf916926dd02cef8d5658562c9', '2014-09-12 20:18:38');

insert into users (name, surname) values ('Ivan','Ivanov');

insert into users values
(1,'Floy', 'Graham', 'emmett.predovic@example.com', '802', 'm', '1985-09-21', 'Geovannyport', NULL, 
'59322dcf916926dd02cef8d5658562c9', '2014-09-12 20:18:38');

insert into users (id, name, surname, email, phone, gender, birthday, hometown, photo_id, pass, created_at) values
 (1, 'Floy', 'Graham', 'emmett.predovic@example.com', '802', 'm', '1985-09-21', 'Geovannyport', NULL, 
'59322dcf916926dd02cef8d5658562c9', '2014-09-12 20:18:38'),
 (2, 'Floy', 'Graham', 'emmett.predovic@example.com', '802', 'm', '1985-09-21', 'Geovannyport', NULL, 
'59322dcf916926dd02cef8d5658562c9', '2014-09-12 20:18:38'),
 (3, 'Floy', 'Graham', 'emmett.predovic@example.com', '802', 'm', '1985-09-21', 'Geovannyport', NULL, 
'59322dcf916926dd02cef8d5658562c9', '2014-09-12 20:18:38');


-- INSERT ... SET
insert into users
set
name = 'Кирилл', surname='Афанасьевич',email = 'k.afan@ya.ru', phone = '896450324568', gender ='m';

-- INSERT ... SELECT
insert into communities
select * from snet1.communities order by id; -- ASC сортировка по возрастанию DESC - по убыванию

select surname, name, phone from users;
select * from users limit 10;
select * from users limit 10 offset 10;
select * from users limit 3 offset 8;
select * from users limit 8, 3;

select concat(surname,' ',name) persons from users;
select substring(name,1,1) persons from users;
select concat(substring(name,1,1), '. ', surname) persons from users;

select distinct hometown from users;
select * from users where hometown = 'Челябинск';

select name, surname, birthday 
	from users where birthday >= '1985-01-01' 
	order by birthday desc ;

select name, surname, birthday 
	from users where birthday >= '1985-01-01' and birthday <= '1990-01-01'
	order by birthday desc ;

select name, surname, birthday 
	from users where birthday between '1985-01-01' and '1990-01-01'
	order by birthday desc ;

select name,surname, hometown from users where hometown != 'Москва';
select name,surname, hometown from users where hometown <> 'Москва';

select name,surname, hometown from users where hometown in ('Москва','Уфа');
select name,surname, hometown from users 
	where hometown = 'Москва'
	or hometown = 'Уфа';

select name,surname from users where surname like 'Ки%';
select name,surname from users where surname like '%ко';
select name,surname from users where surname like 'Иван_в';

select count(*) from users;
select min(birthday) from users;
select hometown, count(*) as citizens from users group by hometown;
select hometown, count(*) as citizens from users group by hometown having citizens >= 10;



-- TRUNCATE (полностью удалить содержимое)
use snet1509;
set foreign_key_checks = 0; -- Отключаем внешние ключи
truncate table communities;
set foreign_key_checks = 1; -- Включаем внешние ключи


-- update 
update friends_requests
	set status = 'approved'
	where initiator_user_id = 1 and target_user_id = 2;

-- перед этим надо еще выкл ключи при транкейте
delete from communities where name = 'Биология клетки';
delete from communities where id between 1 and 10;
delete * from communities;

show create table users_communities;







