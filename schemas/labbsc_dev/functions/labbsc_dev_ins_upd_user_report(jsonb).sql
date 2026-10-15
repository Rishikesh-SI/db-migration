-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_user_report(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_user_report(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_user_report(p_json jsonb, OUT p_result numeric, OUT p_user_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_guid text;
	v_email_id text;
	v_report_type numeric;
	v_report_url text;
	v_user_id numeric;
	v_test_id numeric;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_professional_score varchar(50);
	v_passion_score varchar(50);
	v_personality_code varchar(50);
	v_personality_code2 varchar(50);
	v_communication_score varchar(50);
v_planning_score varchar(50);
v_problem_score varchar(50);
v_observation_score varchar(50);
v_verification_score varchar(50);
begin
	
	select p_json->>'user_guid', p_json->>'email_id', p_json->>'report_type', p_json->>'report_url',
	p_json->>'professional_score',
	p_json->>'passion_score',
	p_json->>'personality_code_1',
	p_json->>'personality_code_2',
	p_json->>'communication_score',
	p_json->>'planning_score',
	p_json->>'problem_score',
	p_json->>'observation_score',
	p_json->>'verification_score'
	into v_user_guid, v_email_id, v_report_type, v_report_url,
	v_professional_score,
	v_passion_score,
	v_personality_code,
	v_personality_code2,
	v_communication_score,
v_planning_score,
v_problem_score,
v_observation_score,
v_verification_score;
	
	select user_id
	into strict v_user_id
	from labbsc_dev.labbsc_dev_web_user
	where email_id = v_email_id
	and user_guid = v_user_guid;
	
	if v_report_type = 1 then
		
		 -- raise notice '%',v_user_id;
		
		select test_id
		into v_test_id
		from labbsc_dev.labbsc_dev_user_tests
		where user_id = v_user_id
		and is_attempted = 1
		order by attempted_on desc
		limit 1;
		
		update labbsc_dev.labbsc_dev_user_tests
		set report_url = v_report_url,
		professional_score=v_professional_score,
		passion_score=v_passion_score,
		personality_code=v_personality_code,
		personality_code2=v_personality_code2,
		communication_score=v_communication_score,
		planning_score=v_planning_score,
		problem_score=v_problem_score,
		observation_score=v_observation_score,
		verification_score=v_verification_score,
		report_type=v_report_type,
		updated_date=current_timestamp
		---is_attempted = 1
		where test_id = v_test_id;
		
		p_result := 1;
		
		
		
		/*select '{"data":'||row_to_json(row)||'}' into p_user_data
          from
		(select wu.first_name,wu.last_name,wu.email_id,ut.report_url,
		 'Sporjo Test Score' as subject
		from labbsc_dev.labbsc_dev_web_user wu  
		left join labbsc_dev.labbsc_dev_user_tests ut on wu.user_id=ut.user_id
		where wu.user_id =v_user_id and test_id = v_test_id)row;*/
		select '{"data":'||row_to_json(row)||'}' into p_user_data
          from
		(select wu.first_name,wu.last_name,wu.email_id,v_report_url as report_url,
		 'Sporjo Test Score' as subject,
		 v_professional_score as professional_score,
		 v_passion_score as passion_score,
		 v_personality_code as personality_code_1,
		 v_personality_code2 as personality_code_2
		from labbsc_dev.labbsc_dev_web_user wu  
		--left join labbsc_dev.labbsc_dev_user_tests ut on wu.user_id=ut.user_id
		where wu.user_id =v_user_id --and test_id = v_test_id
		)row;
		
	else
		
		p_result := 0;
		p_user_data := '{}';
		
	end if;
	
-- 	if exists(select 1
-- 			  from labbsc_dev.labbsc_dev_user_reports
-- 			  where user_id = v_user_id
-- 			  and report_type = v_report_type) then
		
-- 		update labbsc_dev.labbsc_dev_user_reports
-- 		set report_url = v_report_url,
-- 			updated_date = v_current_timestamp
-- 		where user_id = v_user_id
-- 		and report_type = v_report_type;
		
-- 		p_result := 1;
		
-- 	else
		
-- 		insert into labbsc_dev.labbsc_dev_user_reports(user_id, report_type, report_url, created_date, updated_date)
-- 		values(v_user_id, v_report_type, v_report_url, v_current_timestamp, v_current_timestamp);
		
-- 		p_result := 1;
		
-- 	end if;
/*	
exception
	when no_data_found then
		p_result := 0;
	
	when others then
		p_result := -1;
	*/
end;
$$;


--
