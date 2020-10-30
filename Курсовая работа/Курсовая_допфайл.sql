-- sql-файл с комментариями
-- описание БД
-- Описание таблиц
-- ------------------------------------
Описание БД:
БД нужна для личного кабинета проекта cryptid.trade
Продукт внутри - предоставление в аренду бота для крипто рынка Binance.
В личном кабинете люди должны заполнить свои данные, необходимые для работы с ботом.
Внутри ЛК так же находится блок статистики, который отражает профит/баланс/комиссию за разные дни (настраиваемый параметр).



таблицы:

1) Users
	- id	
	- логин
	- почта
	- пароль
	- роль (админ/участник/партнер) (по умолчанию участник)
	

2) users_activation
	- user_id
	- email verification bool
	- api на торги
	- ключ api на торги
	- api на статистику
	- api key на статистику
	- promocode
	- rules_flag
	- activation_date
	
3) user_conditions
	- user_id
	- статус (не активен/активен/новые сделки остановлены/бот полностью остановлен)
	- level_id участия
	- процент комисии (наследуется сначала от промокода, если его нет, то от уровня аккаунта)
	- created_at
	- updated_at
	
4) promo_type
	- id
	- name
	- value

4) promocode
	- id
	- name
	- from_user_id
	- description
	- discount
	- created_at
	- end_of_activation
	
5) level аккаунта 
	- id 
	- название уровня
	- описание уровня
	- процент коммисии
	

	6); Notification_messages:
	- user_id
	- is_from_admin
	- notification_type_id
	- value
	- status
	- created_at
	- updated_at

7) Notification types:
	- id
	-  notofocation_name
	- notification_body
	
8) Password_resets
	- email
	- token
	- created_at
	
	
9) Daily reports
	- date
	- user_id
	- balance_Binance
	- balance_wallet
	- day_proffit
	- comisson
	- created_at
	- updated_at

10) Balances
	user_id
	date_balance
	balance
	profit
	created_at
	updated_at
	

	
	
типичные запросы:
	- вычилить рейтинг писателей?
	
представление:
	- самый продоваемый жанр?