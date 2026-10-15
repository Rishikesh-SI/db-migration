-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_user_emails(numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: labbsc_dev_get_user_emails(numeric, numeric, refcursor); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_user_emails(p_opt_type numeric, p_number_of_records numeric, p_user_email_data refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
v_user_id jsonb;
begin
if p_opt_type=1 ---- general
then

select  array_to_json(array_agg(row))
from (select user_id
from labbsc_dev.labbsc_dev_web_user 
where is_active=1
and coalesce(is_emailer_sent,0) =0
---and user_id in ( 8041,5201,5101,4161,4741,5001,7961,7781,4321,8021,7861)	  	  
  limit p_number_of_records) as row
into v_user_id;
								
								
open p_user_email_data for
 select first_name,last_name,email_id
from labbsc_dev.labbsc_dev_web_user 
where  user_id in ( 
				  select user_detail_id::numeric
from (select value->>'user_id' as user_detail_id from jsonb_array_elements(v_user_id) ) as tb)   ;
 
/*
update  labbsc_dev.labbsc_dev_web_user 
set general_emailer_sent_date=current_timestamp,
 is_emailer_sent=1
 where user_id in (  
				   select user_detail_id::numeric
from (select value->>'user_id' as user_detail_id from jsonb_array_elements(v_user_id) ) as tb) ;
*/
end if;

if p_opt_type=2 ---- newsletter
then

select  array_to_json(array_agg(row))
from (select user_id
from labbsc_dev.labbsc_dev_user_newsletter_subscription 
where  valid_till>=current_timestamp
and coalesce(is_emailer_sent,0) =0
---and user_id in ( 8041,5201,5101,4161,4741,5001,7961,7781,4321,8021,7861)	  
 limit p_number_of_records) as row
into v_user_id;

open p_user_email_data for								
 select first_name,last_name,email_id
from labbsc_dev.labbsc_dev_web_user 
where  user_id in ( 
				  select user_detail_id::numeric
from (select value->>'user_id' as user_detail_id from jsonb_array_elements(v_user_id) ) as tb)  ;
/*
update  labbsc_dev.labbsc_dev_user_newsletter_subscription 
set  emailer_sent_date=current_timestamp,
 is_emailer_sent=1
 where user_id in (  
				   select user_detail_id::numeric
from (select value->>'user_id' as user_detail_id from jsonb_array_elements(v_user_id) ) as tb) ;
*/
end if;

end;

$$;


--
