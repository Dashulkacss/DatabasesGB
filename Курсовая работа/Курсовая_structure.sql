-- create database cryptidtrade;

use cryptidtrade;	

drop table if exists balances;
drop table if exists daily_reports;
drop table if exists pass_reset;
drop table if exists notification_messages;
drop table if exists notification_types;
drop table if exists user_conditions;
drop table if exists users_level;
drop table if exists promo;
drop table if exists promo_codes;
drop table if exists promo_types;
drop table if exists users;


drop table if exists users;
create table users(
	id serial primary key,
	login varchar(50) unique,
	email varchar(120) unique,
	pass char(50),
	user_role enum('admin', 'user','partner') default 'user',
	balance_binance decimal(16,8)	,
	balance_wallet decimal(16,8)	,
	email_verification bool default false,
	api_trade varchar(200) default null,
	api_trade_secret varchar(200) default null,
	api_statistic varchar(200) default null,
	api_statistic_key varchar(200) default null,
	rules_flag bool default false,
	activation_date datetime, 
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp,
	index(email),
	index(login)
);

drop table if exists promo_types;
create table promo_types(
	id serial primary key,
	description text,
	value int
);

drop table if exists promo_codes;
create table promo_codes(
	id serial primary key,
	promo_type_id bigint unsigned not null,
	body varchar(50),
	from_user_id bigint unsigned not null,
	start_of_promo datetime,
	end_of_promo datetime,
	foreign key (from_user_id) references users(id),
	foreign key (promo_type_id) references promo_types(id),
	index (body),
	index(from_user_id)
);


drop table if exists promo;
create table promo(
	id serial primary key,
	user_id bigint unsigned not null,
	promocode_id bigint unsigned not null,
	is_active bool default true,
	created_at datetime default current_timestamp,
	foreign key (promocode_id) references promo_codes(id),
	foreign key (user_id) references users(id)
);


drop table if exists users_level;
create table users_level(
	name varchar(50) primary key,
	description text,
	value decimal(16,8)	
);

drop table if exists user_conditions;
create table user_conditions(
	user_id bigint unsigned not null,
	status enum ('not active','active','pause','stop','trial') default 'not active',
	level_name varchar(50),
	start_at datetime default current_timestamp,
	end_at datetime,
	foreign key (user_id) references users(id),
	foreign key (level_name) references users_level(name),
	index(user_id)
);

drop table if exists notification_types;
create table notification_types(
	id serial primary key,
	name varchar(200),
	body text,
	is_from_admin bool
);

drop table if exists notification_messages;
create table notification_messages(
	id serial primary key,
	user_id bigint unsigned not null,
	notif_id bigint unsigned not null,
	value int,
	status enum ('new', 'in progress','canceled','readed','done','deleted'), -- new, deleted, readed для юзера, остальные для админа
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp,
	foreign key(user_id) references users(id),
	foreign key(notif_id) references notification_types(id)
);

drop table if exists pass_reset;
create table pass_reset(
	email varchar(120),
	token varchar(200),
	is_actual bool default true,
	created_at datetime default current_timestamp,
	foreign key (email) references users(email),
	index(email)
);

drop table if exists daily_reports;
create table daily_reports(
	user_id bigint unsigned not null,
	date_rep date,
	balance_binance decimal(16,8)	,
	balance_wallet decimal(16,8)	,
	day_profit decimal(16,8)	,
	comission decimal(16,8)	,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp,
	primary key(user_id, date_rep),
	foreign key (user_id) references users(id)
);
	
drop table if exists balances;
create table balances(
	user_id bigint unsigned not null,
	date_balance date,
	balance decimal(16,8),
	profit decimal(16,8),
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp,
	foreign key (user_id) references users(id),
	index(user_id)
);



