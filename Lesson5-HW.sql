use shop;

-- 1) Заполнить незаполненые поля created_at и updated_at текущим временем и датой
update users set created_at = now() where created_at = null;
update users set updated_at = now() where updated_at = null;

-- 2) преобразовать created_at из VARCHAR в DATETIME не изменяя значения

create table less5(
	id SERIAL primary key,
	name VARCHAR(255) COMMENT 'Имя покупателя',
	birthday_at VARCHAR(255) COMMENT 'Дата рождения'
);

insert into less5 (id, name, birthday_at) values 
	(null, 'Сергей', '1985-09-26'), (null, 'Дарья', '1995-11-05'), (null, 'Геннадий', '1946-09-01'), (null, 'Алина', '1995-09-26'), (null, 'Арина', '1951-11-05'), (null, 'Надя', '1946-12-01');

-- SELECT STR_TO_DATE(birthday_at,'%Y-%m-%d') from less5;
Alter table less5 modify column birthday_at date; 



-- 3) отсортировать остатки от меньшего к большему, но 0 в конце таблицы.
insert into storehouse_products (id, storehouse_id, product_id, value) values (1,'1','1','5'), (2,'1','2','2'), (3,'2','1','0');
insert into storehouse_products (id, storehouse_id, product_id, value) values (null,'1','4','2'), (null,'1','5','0'), (null,'2','2','7');
select id, storehouse_id, product_id, value from storehouse_products order by value=0, value;

-- 4) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)

select name, date_format(birthday_at, '%M') as birthday_month from users where date_format(birthday_at, '%M') in ('may','august');

-- 5) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

select id, name, field(id, 5, 1, 2) as pos from catalogs where id in(5,1,2) order by pos;

-- Практическое задание теме «Агрегация данных»
-- Подсчитайте средний возраст пользователей в таблице users.

select AVG(timestampdiff(year, birthday_at, now())) as age from users;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

select date_format(concat_ws('-', year(now()), month(birthday_at), day(birthday_at)), '%W') as day, count(*) as num from users group by day order by num desc;

-- (по желанию) Подсчитайте произведение чисел в столбце таблицы.



