-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_reminder_email()
-- Type: FUNCTION

-- Name: labbsc_dev_get_reminder_email(); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_reminder_email(OUT p_reminder_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare 
 
 v_curr_date timestamp;
 v_from_date timestamp;
 v_48_session numeric[];
  v_1_session numeric[];
begin
select current_timestamp at time zone 'utc' + interval '330 minute'
into v_curr_date;
select current_timestamp at time zone 'utc' + interval '300 minute'
into v_from_date;

select '{"data":['||string_agg(row_to_json(row)::text,',')||']}',
ARRAY_AGG( case when  (mail_send_48 between v_from_date and v_curr_date) 
		  then session_id else null end) as v_session_48,
ARRAY_AGG( case when  (mail_send_1 between v_from_date and v_curr_date) then session_id else null end) as v_session_1
from(
	select * from (
select wu.first_name,wu.last_name,
u.display_name as consultant_name,
wu.email_id as user_email,
u.email_id as counseller_email,
u.bio as counsultant_bio,
us.session_date,
us.session_slot,
us.schedule_json as meet_link_info ,
	us.schedule_json->>'googlemeet_link' as google_meet_link,
(us.session_date||' '||s.start_time)::timestamp - interval '48 hours' as mail_send_48,
(us.session_date||' '||s.start_time)::timestamp - interval '1 hours' as mail_send_1,
	 us.session_id
from labbsc_dev.labbsc_dev_user_counselling_session us
join labbsc_dev.labbsc_dev_web_user wu
on wu.user_id=us.user_id
join labbsc_dev.labbsc_dev_user u
on u.user_id=us.counseller_id
join labbsc_dev.labbsc_dev_slot s
on s.session_slot=us.session_slot
	where us.status=0
		and coalesce(before_1,0)=0 or coalesce(before_48,0)=0
	) as tb
	where  ((mail_send_48 between v_from_date and v_curr_date)  or
			(mail_send_1 between v_from_date and v_curr_date)   )
	and  current_date<=session_date    
 
	)as row
into p_reminder_json,v_48_session,v_1_session;
 
   update  labbsc_dev.labbsc_dev_user_counselling_session
  set before_48=1
  where session_id in (
	  select session_id from (
  select unnest( v_48_session::numeric[]) as session_id) as tb
	  where session_id is not null
	);
	
	update  labbsc_dev.labbsc_dev_user_counselling_session
  set before_1=1
  where session_id in (  select session_id from (
  select unnest( v_1_session::numeric[]) as session_id)as tb
	  where session_id is not null
	); 
 
end;
$$;


--
