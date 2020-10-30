use cryptidtrade;

create or replace view user_activation(user_id, status, email, email_verification,api_trade,api_trade_secret,api_statistic,api_statistic_key,rules_flag,activation_date,created_at) as 
select 
	id,
	uc.status,
	u.email ,
	u.email_verification,
	u.api_trade ,
	u.api_trade_secret ,
	u.api_statistic ,
	u.api_statistic_key,
	u.rules_flag,
	u.activation_date ,
	u.created_at 
from users u left join user_conditions uc on u.id = uc.user_id where uc.status = 'not active';

select * from user_activation;

create or replace view active_users (user_id, activation_date, status, level_name, balance_binance, balance_wallet) as 
select
	id,
	activation_date,
	uc.status,
	uc.level_name,
	u.balance_binance,
	u.balance_wallet
from users u join user_conditions uc on u.id = uc.user_id where status <> 'not active';

select * from active_users;