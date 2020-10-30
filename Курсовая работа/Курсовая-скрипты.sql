use cryptidtrade;	


-- все письма
select 
  user_id,
  status,
  nt.body 
from notification_types nt join notification_messages nm on nt.id = nm.notif_id 
	where status = 'new' or status = 'readed';
	
