-- use cryptidtrade;

insert into users (login, email, pass, user_role, activation_date) values
('admin','admin@admin.ru','12345s','admin','2020-09-25 22:09:27.0')
;

insert into users (login,email,pass, user_role,email_verification,api_trade,api_trade_secret,api_statistic,api_statistic_key,rules_flag,activation_date, balance_binance, balance_wallet) values 
('user1','user1@user.ru','123456789','user',true,'apitradekey','apitradesecret','apistatkey','apistatsecret',true,'2020-09-25 22:09:27.0',1000,20),
('user2','user2@user.ru','123456789','user',false,null,null,null ,null,true, null, 0,0),
('user3','user3@user.ru','123456789','user',true,'apitradekey','apitradesecret','apistatkey','apistatsecret',true,null,1000,20),
('user4','user4@user.ru','123456789','user',true,'apitradekey','apitradesecret','apistatkey','apistatsecret',true,'2020-09-25 22:00:27.0',1000,20),
('user5','user5@user.ru','123456789','user',true,'apitradekey','apitradesecret','apistatkey','apistatsecret',true,'2020-10-25 22:00:27.0',1000,20),
('user6','user6@user.ru','123456789','user',true,'apitradekey','apitradesecret','apistatkey','apistatsecret',true,'2020-10-20 22:00:27.0',1000,20),
('user7','user7@user.ru','123456789','user',true,'apitradekey','apitradesecret','apistatkey','apistatsecret',true,'2020-09-25 22:00:27.0',1000,20),
('user8','user8@user.ru','123456789','user',true,'apitradekey','apitradesecret','apistatkey','apistatsecret',true,'2020-09-25 22:00:27.0',1000,20),
('user9','user9@user.ru','123456789','partner',true,'apitradekey','apitradesecret','apistatkey','apistatsecret',true,'2020-09-25 22:00:27.0',1000,20),
('user10','user10@user.ru','123456789','user',true,'apitradekey','apitradesecret','apistatkey','apistatsecret',true,'2020-09-25 22:00:27.0',1000,20),
('user11','user11@user.ru','123456789','user',true,'apitradekey','apitradesecret','apistatkey','apistatsecret',true,'2020-09-25 22:00:27.0',1000,20)
;



insert into promo_types (description, value) values 
('personal', 5),
('personal vip',10),
('welcome',30);


insert into promo_codes (promo_type_id, body, from_user_id, start_of_promo, end_of_promo) values 
(1,'sdjak34',3,'2020-09-30 22:00:27.0','2099-09-30 22:00:27.0'),
(1,'sadafsc',4,'2020-09-30 22:00:27.0','2099-09-30 22:00:27.0'),
(1,'asdkcjie',12,'2020-09-30 22:00:27.0','2099-09-30 22:00:27.0'),
(2,'a2sdlk',11,'2020-09-30 22:00:27.0','2099-09-30 22:00:27.0'),
(3,'asldj231',1,'2020-11-30 22:00:27.0','2099-09-30 22:00:27.0');


insert into promo (user_id, promocode_id) values
(5,2),
(8,2),
(12,4);

insert into users_level (name, description, value) values 
('bronze','all users', 50),
('silver', 'users active more than 2 month or >10000$',40),
('gold','6 month more and 100000$',30);

-- select * from users_level;
-- select * from user_conditions uc ;
-- select * from users;
insert into user_conditions (user_id, status, level_name, start_at, end_at) values
(2, 'active','bronze','2020-09-25 22:09:27.0','2099-12-12 22:09:27.0'),
(3, 'not active','bronze','2020-09-25 22:09:27.0','2099-12-12 22:09:27.0'),
(4, 'not active','bronze','2020-09-25 22:09:27.0','2099-12-12 22:09:27.0'),
(5,'active','bronze','2020-09-25 22:09:27.0','2099-12-12 22:09:27.0'),
(6,'trial','bronze','2020-09-25 22:09:27.0','2099-12-12 22:09:27.0'),
(7,'trial','bronze','2020-09-25 22:09:27.0','2020-10-10 22:08:27.0'),
(8,'active','silver','2020-09-25 22:09:27.0','2099-12-12 22:09:27.0'),
(9,'active','bronze','2020-09-25 22:09:27.0','2099-12-12 22:09:27.0'),
(10,'active','bronze','2020-09-25 22:09:27.0','2099-12-12 22:09:27.0'),
(11,'pause','bronze','2020-09-25 22:09:27.0','2099-12-12 22:09:27.0'),
(12, 'stop','silver','2020-09-25 22:09:27.0','2099-12-12 22:09:27.0'),
(7,'active','bronze','2020-10-10 22:09:27.0','2099-12-12 22:09:27.0')
;

insert into notification_types (name, body, is_from_admin) values 
('bot activation','Бот активирован',1),
('bot pause','Бот приостановлен',1),
('bot stop', 'Бот полностью остановлен',1),
('add money', 'Запрос на пололнение счёта',2),
('bot activation','Активируйте бота',2),
('bot stop','Остановите бота',2);

insert into notification_messages (user_id, notif_id,value,status) values 
(2,5,null,'done'),
(2,1,null,'readed'),
(8,4,100,'new'),
(9,4,10,'done');

insert into pass_reset (email,token, is_actual) values
('user1@user.ru','kjasdcakjsnczc3r', false),
('user1@user.ru','kjasdcakdsaajsnczc3r', true);

insert into daily_reports (user_id, date_rep,balance_binance,balance_wallet,day_profit,comission) values
(2, '2020-10-10', 1000, 15,0,0),
(2, '2020-10-11', 1010, 10,10,5),
(2, '2020-10-12', 1030, 0,20,10),
(3, '2020-10-11', 1030, 0,20,10),
(4, '2020-10-11', 1040, 0,20,10),
(4, '2020-10-12', 1030, 0,20,10),
(3, '2020-10-12', 1060, 0,20,10);

insert into balances (user_id,date_balance, balance, profit) values
(2,'2020-10-11',1000,0),
(2,'2020-10-11',1001,0.01),
(2,'2020-10-11',1001,0),
(2,'2020-10-11',1005,0.04),
(2,'2020-10-11',1005,0.04),
(2,'2020-10-11',1010,0.05),
(2,'2020-10-11',1010,0);
