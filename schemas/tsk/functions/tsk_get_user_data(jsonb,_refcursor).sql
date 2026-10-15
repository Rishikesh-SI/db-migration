-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: tsk_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from tsk.tsk_get_user_data
(
    '{
    "opt_type": 3,
  "start_date_time": "2019-04-08 20:00:00",
  "end_date_time": "2019-04-08 23:59:59"
}',
    'a'
);
fetch all in "a";
*/

declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
    
  
 if v_opt_type = 1 then
   open p_user_cursor for
 select *
 from tsk.tsk_group
 where (created_date+ '5.5 hours' ::interval)::date >= v_start_date_time
	and (created_date+ '5.5 hours' ::interval)::date <= v_end_date_time;
 end if;

end;
$$;


--
