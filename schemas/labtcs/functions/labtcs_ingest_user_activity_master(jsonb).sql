-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_ingest_user_activity_master(jsonb)
-- Type: FUNCTION

-- Name: labtcs_ingest_user_activity_master(jsonb); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_ingest_user_activity_master(p_json jsonb, OUT p_result numeric) RETURNS numeric
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
  v_run_date date:=current_date;
  v_run_start_time varchar(500);
  v_run_end_time varchar(500);
 

 v_group_name varchar(500);
 v_group_id varchar(500);
 v_state_name varchar(500);
 v_city varchar(500);
 v_state_id numeric;
 v_distance numeric(10,4);
 
 
 
  v_category varchar(500);
 v_gender varchar(10);
 v_dob timestamp;
 v_country varchar(500);
 v_run_club_name varchar(500);
v_age numeric;
begin

select  
       p_json->>'activities'
	   into 
	   v_activity_json;
	   
	 
	   
	
	 if v_activity_json is not null then
	 
	 
	 for i in (select * from jsonb_array_elements(v_activity_json))
	loop
 
	select  
	i->>'bib_no',
	i->>'time_taken',
	 i->>'gender',
	i->>'distance',
	i->>'age'
	into 
  v_bib_no ,
  v_time_taken,
   v_gender,
  v_distance,
  v_age; 
 


  select  group_name ,
 group_id ,
 state_name ,
 city , 
 user_id,
 user_name,
 email_id,
 category,
 dob,
 country,
 run_club_name
 from labtcs.labtcs_user_master
 where bib_no=v_bib_no
	into v_group_name ,
 v_group_id ,
 v_state_name ,
 v_city ,
 
 v_user_id,
 v_user_name,
 v_email_id,
 v_category,
 v_dob,
 v_country,
 v_run_club_name;
 
 /*
 v_distance := case when rtrim(v_category)= '10K (10 km)' then 10
                    when rtrim(v_category)= 'Great Delhi Run (5 km)' then 5
					when rtrim(v_category)= 'Open 10K (10 km)' then 10
					when rtrim(v_category)= 'Half Marathon (21.097 km)' then 21
					end;*/
    ----raise notice '%',v_user_id;
	 
	   
 if v_user_id is not null then
	   if not exists(select 1 from labtcs.labtcs_user_activity_detail
				 where user_id=v_user_id
				 
				 )  
	 then   
	    insert into labtcs.labtcs_user_activity_detail
	 (activity_detail_id  ,
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
 
 category,
 gender,
 dob,
 country,
 run_club_name,
	 distance)
	   select nextval('labtcs.seq_labtcs_user_activity_detail'),
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
 
  v_category,
 v_gender,
 v_dob,
 v_country,
 v_run_club_name,
 v_distance;
	   
	  p_result:=1;  
	  
	  else
	  
 update labtcs.labtcs_user_activity_detail
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
run_end_time=v_run_end_time,
 category=v_category,
gender= v_gender,
dob= v_dob,
 country=v_country,
run_club_name= v_run_club_name,
distance=v_distance
	  where user_id=v_user_id;
	
	   p_result:=1;  
	 
	  end if;	
	
	end if; 
	 
 

  end loop;
	 end if;
	 
	 
	 if p_result=1 then
	 p_result:=1;  
	 end if;
 
end;
$$;


--
