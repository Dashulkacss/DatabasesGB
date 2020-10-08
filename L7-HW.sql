-- 1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
insert into orders (id, user_id) values  ('1','3'), ('2','5');

select u.id, u.name
from users u where exists (select 1 from orders o2 where o2.user_id = u.id);

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

select p.id, p.name, c.name from products p left join catalogs c on p.catalog_id = c.id ;

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

create table flights(
	id serial primary key,
	`from` varchar(255),
	`to` varchar(255),
	foreign key (`from`) references cities (label),
	foreign key (`to`) references cities (label)
);

insert into flights values ('1','moscow','omsk'),('2','novgorod','kazan'),('3','irkutsk','moscow'),('4','omsk','irkutsk'),('5','moscow','kazan');

create table cities(
	label varchar(255),
	name varchar(255),
	primary key (label)
);

insert into cities values ('moscow','Москва'), ('irkutsk','Иркутск'),('novgorod','Новгород'),('kazan','Казань'),('omsk','Омск');

select
	f.id,
	(select c.name from cities c where f.`from` = c.label),
	(select c.name from cities c where f.`to` = c.label)
from flights f;
