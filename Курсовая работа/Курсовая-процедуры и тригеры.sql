use cryptidtrade;

-- при опросе Binance, если баланс обновился, то меняем баланс у user.
drop trigger if exists balance_update
delimiter //
create trigger balance_update after insert on balances
for each row
	begin 
		update users 
		set balance_binance = new.balance
		where id = new.user_id;
end 
//

select u.id,u.balance_binance from users u where id = 2;
insert into balances (user_id,date_balance, balance, profit) values (2,'2020-10-11',1005,0.01);
select u.id,u.balance_binance from users u where id = 2;


-- В дневном репорте указываеются передвижения по кошельку. Если человек пополняет баланс, то это отражается в users
-- В дневном репорте снимается из user.balance_wallet и вписывается новое значение
drop trigger if exists balance_wallet_update
delimiter //
create trigger balance_wallet_update after insert on daily_reports
for each row
	begin 
		update users 
		set balance_wallet = new.balance_wallet
		where id = new.user_id;
end 
//

select u.id,u.balance_wallet from users u where id = 2;
insert into daily_reports (user_id, date_rep,balance_binance,balance_wallet,day_profit,comission) values
(2, '2020-10-15', 10005, 17.5,5,2.5);
select u.id,u.balance_wallet from users u where id = 2;

-- 
drop trigger if exists account_activation
delimiter //
create trigger account_activation after insert on users
for each row
	begin 
		insert into user_conditions (user_id,status,level_name,start_at) values
		(new.id, 'not active','bronze',now());
	end
//



select * from promo;

drop function if exists count_active_promo_users;
delimiter //
create function count_active_promo_users(user_id int)
returns int reads sql data
begin
	declare res int;
	select count(*) into res from promo p join promo_codes as pc 
		on p.promocode_id = pc.id 
	join user_conditions uc on uc.user_id = p.user_id where uc.status <> 'not active' and from_user_id = user_id;
	return res;
end //

select count_active_promo_users(4);
select * from user_conditions uc where uc.user_id = 5 or uc.user_id = 8;
