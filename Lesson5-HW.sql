use shop;

-- 1) ��������� ������������ ���� created_at � updated_at ������� �������� � �����
update users set created_at = now() where created_at = null;
update users set updated_at = now() where updated_at = null;

-- 2) ������������� created_at �� VARCHAR � DATETIME �� ������� ��������

create table less5(
	id SERIAL primary key,
	name VARCHAR(255) COMMENT '��� ����������',
	birthday_at VARCHAR(255) COMMENT '���� ��������'
);

insert into less5 (id, name, birthday_at) values 
	(null, '������', '1985-09-26'), (null, '�����', '1995-11-05'), (null, '��������', '1946-09-01'), (null, '�����', '1995-09-26'), (null, '�����', '1951-11-05'), (null, '����', '1946-12-01');

-- SELECT STR_TO_DATE(birthday_at,'%Y-%m-%d') from less5;
Alter table less5 modify column birthday_at date; 



-- 3) ������������� ������� �� �������� � ��������, �� 0 � ����� �������.
insert into storehouse_products (id, storehouse_id, product_id, value) values (1,'1','1','5'), (2,'1','2','2'), (3,'2','1','0');
insert into storehouse_products (id, storehouse_id, product_id, value) values (null,'1','4','2'), (null,'1','5','0'), (null,'2','2','7');
select id, storehouse_id, product_id, value from storehouse_products order by value=0, value;

-- 4) �� ������� users ���������� ������� �������������, ���������� � ������� � ���. ������ ������ � ���� ������ ���������� �������� (may, august)

select name, date_format(birthday_at, '%M') as birthday_month from users where date_format(birthday_at, '%M') in ('may','august');

-- 5) �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN.

select id, name, field(id, 5, 1, 2) as pos from catalogs where id in(5,1,2) order by pos;

-- ������������ ������� ���� ���������� �������
-- ����������� ������� ������� ������������� � ������� users.

select AVG(timestampdiff(year, birthday_at, now())) as age from users;

-- ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.

select date_format(concat_ws('-', year(now()), month(birthday_at), day(birthday_at)), '%W') as day, count(*) as num from users group by day order by num desc;

-- (�� �������) ����������� ������������ ����� � ������� �������.



