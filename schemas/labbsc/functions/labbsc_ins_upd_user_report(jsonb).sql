-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_ins_upd_user_report(jsonb)
-- Type: FUNCTION

-- Name: labbsc_ins_upd_user_report(jsonb); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_ins_upd_user_report(p_json jsonb, OUT p_result numeric, OUT p_user_data jsonb) RETURNS record
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
	
begin
	
	select p_json->>'user_guid', p_json->>'email_id', p_json->>'report_type', p_json->>'report_url'
	into v_user_guid, v_email_id, v_report_type, v_report_url;
	
	select user_id
	into strict v_user_id
	from labbsc.labbsc_web_user
	where email_id = v_email_id
	and user_guid = v_user_guid;
	
	if v_report_type = 1 then
		
		-- raise notice '%',v_user_id;
		
		select test_id
		into v_test_id
		from labbsc.labbsc_user_tests
		where user_id = v_user_id
		and is_attempted = 1
		order by attempted_on desc
		limit 1;
		
		update labbsc.labbsc_user_tests
		set report_url = v_report_url
		where test_id = v_test_id;
		
		p_result := 1;
		
		
		
		/*select '{"data":'||row_to_json(row)||'}' into p_user_data
          from
		(select wu.first_name,wu.last_name,wu.email_id,ut.report_url,
		 'Sporjo Test Score' as subject
		from labbsc.labbsc_web_user wu  
		left join labbsc.labbsc_user_tests ut on wu.user_id=ut.user_id
		where wu.user_id =v_user_id and test_id = v_test_id)row;*/
		select '{"data":'||row_to_json(row)||'}' into p_user_data
          from
		(select wu.first_name,wu.last_name,wu.email_id,v_report_url as report_url,
		 'Sporjo Test Score' as subject
		from labbsc.labbsc_web_user wu  
		--left join labbsc.labbsc_user_tests ut on wu.user_id=ut.user_id
		where wu.user_id =v_user_id --and test_id = v_test_id
		)row;
		
	else
		
		p_result := 0;
		p_user_data := '{}';
		
	end if;
	
-- 	if exists(select 1
-- 			  from labbsc.labbsc_user_reports
-- 			  where user_id = v_user_id
-- 			  and report_type = v_report_type) then
		
-- 		update labbsc.labbsc_user_reports
-- 		set report_url = v_report_url,
-- 			updated_date = v_current_timestamp
-- 		where user_id = v_user_id
-- 		and report_type = v_report_type;
		
-- 		p_result := 1;
		
-- 	else
		
-- 		insert into labbsc.labbsc_user_reports(user_id, report_type, report_url, created_date, updated_date)
-- 		values(v_user_id, v_report_type, v_report_url, v_current_timestamp, v_current_timestamp);
		
-- 		p_result := 1;
		
-- 	end if;
	
exception
	when no_data_found then
		p_result := 0;
	
	when others then
		p_result := -1;
	
end;
$$;


--
