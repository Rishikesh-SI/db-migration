-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_user_counseller_detail(numeric)
-- Type: FUNCTION

-- Name: labbsc_get_user_counseller_detail(numeric); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_user_counseller_detail(p_user_id numeric, OUT p_result numeric, OUT p_profile_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_id numeric;
	v_email_id text;
	v_profile_picture_url text;
	v_first_name text;
	v_last_name text;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
 
	v_user_guid text;
	v_report_url varchar(500);
	v_moment varchar(500);
	v_sports_team varchar(500);
	v_sportsperson varchar(500);
	v_sport_to_watch varchar(500);
	v_sport_to_play varchar(500);
	v_work_exp_year varchar(50);
	v_work_exp_month varchar(50);
	v_education text;
	v_me_n_working_in_sports jsonb;
	v_contact text;
begin
	
	p_result := 0;
	
	 select user_id, email_id, profile_picture_url, first_name, last_name,user_guid
	into strict v_user_id, v_email_id, v_profile_picture_url, v_first_name, v_last_name,
	v_user_guid
	from labbsc.labbsc_web_user
	where user_id = p_user_id;
	
	 
	 	select client_mod_json->'data'->'world_of_sport'->>'favourite_sporting_moment',
		client_mod_json->'data'->'world_of_sport'->>'favourite_sports_team',
		client_mod_json->'data'->'world_of_sport'->>'favourite_sportsperson',
		client_mod_json->'data'->'world_of_sport'->>'sports_to_watch',
		client_mod_json->'data'->'me_and_my_sports'->>'favourite_Sports_to_play',
		client_mod_json->'data'->'aboutMe'->>'work_exp_year',
		client_mod_json->'data'->'aboutMe'->>'work_exp_month',
		client_mod_json->'data'->'aboutMe'->>'education',
		client_mod_json->'data'->>'me_and_working_in_sports',
		client_mod_json->'data'->'aboutMe'->>'mobile' 
		from labbsc.labbsc_client_web_cust_model
		where user_guid = v_user_guid
		and module_name = 'user_profile'
		into v_moment,
		v_sports_team,
		v_sportsperson,
		v_sport_to_watch,
		v_sport_to_play,
		v_work_exp_year,
		v_work_exp_month,
		v_education,
		v_me_n_working_in_sports,
		v_contact
		;
		
		
		
	begin
	select report_url
	from (select report_url
		from labbsc.labbsc_user_tests
		where user_id=p_user_id
		and is_attempted=1
		and report_url is not null
	order by cart_id desc
	limit 1) tc
		 into v_report_url;
	exception when others then
	null;
    end;
	
 
select '{"data":['|| row_to_json(row)::text ||']}'
		from ( select
     v_email_id as email_id,
	 v_profile_picture_url as profile_picture_url, 
	 v_first_name as first_name,
	 v_last_name as last_name,
	v_moment as favourite_sporting_moment,
	v_sports_team as favourite_sports_team,
	v_sportsperson as favourite_sportsperson,
		v_sport_to_watch as sports_to_watch,
		v_sport_to_play as favourite_Sports_to_play,
		v_report_url as report_url,
		v_work_exp_year as work_exp_year,
		v_work_exp_month as work_exp_month, 
		v_education as qualification,
			  v_contact as contact,
			 v_me_n_working_in_sports as me_n_working_in_sports 
			 ) as row
		into p_profile_json;
		
	
	
	if p_profile_json is not null then
		p_result := 1;
	end if;
	
exception
	when others then
		p_result := -1;
	
	when no_data_found then
		p_result := -2;
	
end;
$$;


--
