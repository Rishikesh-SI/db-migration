-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_ingest_user_activity_master_bkp(jsonb)
-- Type: FUNCTION

-- Name: dhm_ingest_user_activity_master_bkp(jsonb); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_ingest_user_activity_master_bkp(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
v_activity_date date;
v_activity_json jsonb;
 
i jsonb;
v_email_id text;
  v_user_name varchar(500);
  v_user_id numeric;
  v_bib_no numeric;
  v_kilometer_covered varchar(500);
  v_start_lat text;
  v_start_long text;
  v_end_lat text;
  v_end_long text;
  v_time_taken varchar(500);
  v_run_date date;
  v_run_start_time varchar(500);
  v_run_end_time varchar(500);
 

 v_group_name varchar(500);
 v_group_id varchar(500);
 v_state_name varchar(500);
 v_city varchar(500);
 v_state_id numeric;

begin

select  
       p_json->>'activities'
	   into 
	   v_activity_json;
	   
	 
	   
	
	 if v_activity_json is not null then
	 
	 
	 for i in (select * from jsonb_array_elements(v_activity_json))
	loop
 
	select i->>'emailid',
	i->>'userName',
	i->>'userID',
	i->>'bibNo',
    i->>'kilometer_covered',
    i->>'start_lat',
    i->>'start_long',
	i->>'end_lat',
	i->>'end_long',
	i->>'time_taken',
	i->>'run_date',
	i->>'run_start_time',
	i->>'run_end_time'
	into v_email_id ,
  v_user_name ,
  v_user_id ,
  v_bib_no ,
  v_kilometer_covered ,
  v_start_lat,
  v_start_long ,
  v_end_lat ,
  v_end_long ,
  v_time_taken ,
  v_run_date ,
  v_run_start_time ,
  v_run_end_time;

  select  group_name ,
 group_id ,
 state_name ,
 city ,
 state_id
 from dhm.dhm_user_master
 where upper(email_id)=upper(v_email_id)
	into v_group_name ,
 v_group_id ,
 v_state_name ,
 v_city ,
 v_state_id;
	 
	
 
	   if (not exists(select 1 from dhm.dhm_user_activity_detail
				 where upper(email_id)=upper(v_email_id)
				 
				 )  and v_email_id is not null )
	 then   
	    insert into dhm.dhm_user_activity_detail
	 (user_activity_id  ,
		email_id ,
  user_name ,
  user_id ,
  bib_no ,
  kilometer_covered ,
  start_lat,
  start_long ,
  end_lat ,
  end_long ,
  time_taken ,
  run_date ,
  run_start_time ,
  run_end_time,
  group_name ,
 group_id ,
 state_name ,
 city ,
 state_id)
	   select nextval('dhm.seq_dhm_user_activity_detail'),
	  v_email_id ,
  v_user_name ,
  v_user_id ,
  v_bib_no ,
  v_kilometer_covered ,
  v_start_lat,
  v_start_long ,
  v_end_lat ,
  v_end_long ,
  v_time_taken ,
  v_run_date ,
  v_run_start_time ,
  v_run_end_time,
  v_group_name ,
 v_group_id ,
 v_state_name ,
 v_city ,
 v_state_id;
	   
	  p_result:=1;  
	  
	  else
	  
 update dhm.dhm_user_activity_detail
 set user_name=  v_user_name ,
 user_id= v_user_id ,
 bib_no= v_bib_no ,
   kilometer_covered =v_kilometer_covered,
  start_lat=v_start_lat,
 start_long= v_start_long ,
 end_lat = v_end_lat ,
 end_long= v_end_long ,
 time_taken= v_time_taken ,
 run_date= v_run_date ,
 run_start_time= v_run_start_time ,
run_end_time=v_run_end_time
	  where upper(email_id)=upper(v_email_id);
	
	  
	 
	  end if;
	
	 
	 
 

  end loop;
	 end if;
	 
	 
	 if p_result=1 then
	 p_result:=1;  
	 end if;
 
end;
$$;


--
