-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labrao_ingest_user_activity_master_bkp(jsonb)
-- Type: FUNCTION

-- Name: labrao_ingest_user_activity_master_bkp(jsonb); Type: FUNCTION; Schema: labmao_bkp; Owner: -
--

CREATE FUNCTION labmao_bkp.labrao_ingest_user_activity_master_bkp(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
v_activity_date date;
v_activity_json jsonb;
v_curr_date date:= '2020-08-15'; 
i jsonb;
v_distance numeric(10,4);
v_activity_link text;
v_runner_id numeric;
v_activity_start_time numeric;
v_run_id numeric;
v_activity_time  varchar(500);
v_datasource varchar(500);
v_user_id numeric;
v_bib_no numeric;
v_email_id text;
v_state_name varchar(500);
v_city varchar(500);
v_dob timestamp;
v_gender varchar(50);
v_group_name varchar(500);
v_activity_date_epoch date;
v_activity_time_epoch timestamp;
v_pledged_distance numeric(10,4);
v_user_name varchar(500);
v_group_id varchar(500);
v_pledged_state varchar(500);
v_pledged_city varchar(500);
v_age numeric;
v_verification_flag numeric;
begin

select  
       p_json->>'activities'
	   into 
	   v_activity_json;
	   
	   ---raise notice '%,% ',v_activity_date,v_activity_json ;
	   
	
	 if v_activity_json is not null then
	 
	 
	 for i in (select * from jsonb_array_elements(v_activity_json))
	loop
 
	select i->>'distance',
	i->>'activityLink',
	i->>'runnerId',
	i->>'activityStartTime',
    i->>'runId',
    i->>'time',
    i->>'dataSource'
	into v_distance,
	v_activity_link,
	v_runner_id,
	v_activity_start_time,
	v_run_id,
	v_activity_time,
	v_datasource;
	
	 
	  SELECT  
      TIMESTAMP 'epoch' + v_activity_start_time * INTERVAL '1 second'+ interval '330 minute'
	  into v_activity_time_epoch;
	  
	  select v_activity_time_epoch::date 
	  into v_activity_date;
	--	raise notice '%',v_runner_id ;
	
	 begin
	select user_id,email_id,bib_no,state_name,city,gender,dob,group_name,pledged_distance,
	user_name,group_id,pledged_state,pledged_city,extract('years' from age(dob))
	from labrao.labrao_user_master
	where  payment_status=1
	and external_user_id=v_runner_id
	 into v_user_id,v_email_id,v_bib_no,v_state_name,v_city,v_gender,v_dob,v_group_name,v_pledged_distance,
	v_user_name,v_group_id,v_pledged_state,v_pledged_city,v_age;
	v_verification_flag:= case when v_distance>=42.2 then 1 else 0 end;
	
	if v_activity_date >=v_curr_date then
	   if (not exists(select 1 from labrao.labrao_user_activity_detail
				 where runner_id=v_runner_id
				 and activity_date = v_activity_date 
				and activity_start_time= cast(v_activity_start_time as varchar(500))
				 ---and run_id=v_run_id
				 )  and v_email_id is not null )
	 then   
	    insert into labrao.labrao_user_activity_detail
	 (user_activity_id  ,
		user_id  ,
		email_id  ,
		activity_date  ,
		activity_time  ,
		distance  ,
		bib_no  ,
		run_id  ,
		runner_id  ,
		datasource  ,
		activity_link  ,
       activity_start_time,
	 state_name,city,gender,dob,group_name,
	 activity_start_time_epoch,
	 verification_flag)
	   select nextval('labrao.seq_labrao_user_activity_detail'),
	   v_user_id  ,
		v_email_id  ,
		v_activity_date  ,
		v_activity_time  ,
		  v_distance  ,
		v_bib_no  ,
		v_run_id  ,
		v_runner_id  ,
		v_datasource  ,
		v_activity_link  ,
       v_activity_start_time,
	   v_state_name,v_city,v_gender,v_dob,v_group_name,
	   v_activity_time_epoch,
	  v_verification_flag;
	   
	  p_result:=1;  
	  
	  else
	  
	  select case when verification_flag=1 then 0 else 3 end
	  from labrao.labrao_user_activity_detail
	  where runner_id=v_runner_id
				 and activity_date = v_activity_date 
				and activity_start_time= cast(v_activity_start_time as varchar(500))
			into v_verification_flag	;
	  
	  
	  update labrao.labrao_user_activity_detail
	  set distance = v_distance,verification_flag=0
	  where runner_id=v_runner_id
				 and activity_date = v_activity_date 
				and activity_start_time= cast(v_activity_start_time as varchar(500))
				and verification_flag=1;
	
	  
	 
	  end if;
	
	 
	 if (not exists(select 1 from labrao.labrao_user_activity_report
				 where user_id=v_user_id
				 )  and v_email_id is not null   )
	 then   
	    insert into labrao.labrao_user_activity_report
	 (  activity_report_id  ,
		user_id  ,
		email_id  , 
		distance  ,
		bib_no  , 
	    state_name,
	    city,
	    gender,
	    dob,
	    group_name,
	  pledged_distance,
	  user_name,
	  group_id,
	  pledged_state,
	  pledged_city,
	  first_activity,
	  reached_pledged_distance ,
	  reached_30km,
	  age,
	  runner_id
	 )
	   select nextval('labrao.seq_labrao_user_activity_report'),
	   v_user_id  ,
		v_email_id  ,
		case when v_verification_flag=0 then v_distance else 0 end  ,
		v_bib_no  ,
		v_state_name,
		v_city,
		v_gender,
		v_dob,
		v_group_name,
		v_pledged_distance,
		v_user_name,
		v_group_id,
		v_pledged_state,
	    v_pledged_city,
		1,
		case when v_distance>=100 then 1 else 0 end,
		case when v_distance>=30 then 1 else 0 end,
		v_age,
		v_runner_id;
	   
	  p_result:=1;  
	  else
	  update labrao.labrao_user_activity_report
	  set distance =distance+ case when v_verification_flag=0 then v_distance else 0 end,
	  reached_pledged_distance=case when distance>= 100 then 1 else 0 end,
		reached_30km=case when distance>=30 then 1 else 0 end,
		first_activity=1,
		age=v_age
	  where user_id =v_user_id;
	  p_result:=1;  
	 end if;
	  end if;
	 
	 
	  
   exception when no_data_found then  
 p_result:=2;
end;

  end loop;
	 end if;
	 
	 
	 if p_result=1 then
	 p_result:=1;  
	 end if;
 
end;
$$;


--
