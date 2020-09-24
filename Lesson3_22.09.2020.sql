drop database if exists snet1509;
create database snet1509;

use snet1509;

create table users(
	id serial primary key,
	name varchar(50),
	surname varchar(50),
	email varchar(120) unique,
	phone bigint,
	gender char(1),
	birthday date,
	hometown varchar(50),
	photo_id bigint unsigned,
	pass char(50),
	created_at datetime default current_timestamp,
	-- soft delete
	-- is_deleted bool
	-- deleted_at datetime
	index(phone),
	index(email),
	index(surname, name)
	
);

drop table if exists messages;
create table messages(
	id serial primary key,
	from_user_id bigint unsigned not null,
	to_user_id bigint unsigned not null,
	body text,
	is_read bool default 0,
	created_at datetime default current_timestamp,
	foreign key (from_user_id) references users (id),
	foreign key (to_user_id) references users (id)
); 


drop table if exists friends_requests;
create table friends_requests(
	-- id serial primary key,
	initiator_user_id bigint unsigned not null,
	target_user_id bigint unsigned not null,
	status enum('requested','approved','unfriended','declined') default 'requested',
	requested_at datetime default now(),
	confirmed_at datetime default current_timestamp on update current_timestamp,
	primary key(initiator_user_id, target_user_id),
	foreign key (initiator_user_id) references users (id),
	foreign key (target_user_id) references users (id)
);

alter table friends_requests add index(initiator_user_id); 


drop table if exists communities;
create table communities(
	id serial primary key,
	name varchar(150),
	index communities_name_idx (name)
);

-- group | people
-- 1  |  m
-- m  |  1
drop table if exists users_communities;
create table users_communities(
	user_id bigint unsigned not null,
	communities_id bigint unsigned not null,
	is_admin bool default 0,
	primary key(user_id, communities_id),	
	foreign key (user_id) references users (id),
	foreign key (communities_id) references communities (id)
);

drop table if exists posts;
create table posts(
	id serial primary key,
	user_id bigint unsigned not null,
	body text,
	metadata json,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp,
	foreign key (user_id) references users (id)
);

drop table if exists comments;
create table comments(
	id serial primary key,
	user_id bigint unsigned not null,
	post_id bigint unsigned not null,
	body text,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp,
	foreign key (user_id) references users (id),
	foreign key (post_id) references posts (id)
);


drop table if exists photos;
create table photos(
	id serial primary key,
	user_id bigint unsigned not null,
	file_name varchar(250),
	description text,
	created_at datetime default current_timestamp,
	foreign key (user_id) references users (id)
);

drop table if exists photos_likes;
create table photos_likes(
	from_user_id bigint unsigned not null,
	photos_id bigint unsigned not null,
	is_like bool,
	primary key(from_user_id, photos_id),
	foreign key (from_user_id) references users (id),
	foreign key (photos_id) references photos (id)
);

drop table if exists posts_likes;
create table posts_likes(
	from_user_id bigint unsigned not null,
	post_id bigint unsigned not null,
	is_like bool,
	primary key(from_user_id, post_id),
	foreign key (from_user_id) references users (id),
	foreign key (post_id) references posts (id)
);

drop table if exists user_likes;
create table user_likes(
	from_user_id bigint unsigned not null,
	user_id bigint unsigned not null,
	is_like bool,
	primary key(from_user_id, user_id),
	foreign key (from_user_id) references users (id),
	foreign key (user_id) references users (id)
);

