-- 2) Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
use snet1509;


select 
	count(*) `count_of_msg`,
	(select concat(name, ' ', surname) from users where id = m.from_user_id) as 'best friend'
from messages m where to_user_id = 17 and (from_user_id in (select friend_id from
			(select 
				case
					when initiator_user_id = 17 and status = 'approved' then target_user_id 
					when target_user_id = 17 and status = 'approved' then initiator_user_id 
				end as friend_id 
			from friends_requests) as fr_tbl 
		where friend_id is not null)) group by from_user_id order by `count_of_msg` desc limit 1;

	
-- 3) Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.	

select count(*) from user_likes ul 
INNER join 
	(select id from users order by birthday desc limit 10) as tbl_birth
	on ul.user_id = tbl_birth.id
where ul.is_like = 1	

-- 4) Определить кто больше поставил лайков (всего) - мужчины или женщины?

select gender, sum(try) as mostlikes from (
	select 
		gender 'gender',
		(select count(*) from user_likes ul where users.id = from_user_id and is_like = 1) as try
	from users
) as tbl_1
group by gender order by mostlikes desc limit 1;

-- 5) Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

-- Не успеваю
