-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labtcs_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
begin

/*
select * from labgt.labgt_get_user_data
(
    '{
    "opt_type": 1,
  "start_date_time": "2019-03-23 00:00:00",
  "end_date_time": "2019-03-23 23:20:02"
}',
    'a'
);
fetch all in "a";
*/


    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
    
 if v_opt_type = 1  then
	open p_user_cursor for
	select group_id,group_name,no_of_runners,total_fees,invoice_company_name,invoice_address,
	group_contact_name,group_contact_email,group_contact_number,group_pancard_name,group_pancard_number,
	state_name,corporate_type,state_id,created_date,participation_format,majjarun_registrants,seniorcitizen_registrants,
	majjarun_registrants_virtual,open10k_registrants_virtual,cwd_registrants,racetype from labtcs.labtcs_group
	where (created_date+ '5.5 hours' ::interval)::date >= v_start_date_time
	and (created_date+ '5.5 hours' ::interval)::date <= v_end_date_time;

end if;

 if v_opt_type = 2  then
	open p_user_cursor for
select first_name,last_name,distance_class as distance_covered,bib_no,activetimeinsec,elapsedtimeinsec,
finishstatus,avgpace,created_date at time zone 'utc' at time zone 'Asia/Calcutta'
from labtcs.labtcs_user_race_challange
where (created_date+ '5.5 hours' ::interval)::date >= v_start_date_time
	and (created_date+ '5.5 hours' ::interval)::date <= v_end_date_time;

end if;

 
end;
$$;


--
