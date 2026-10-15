-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_timewise_user_list(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_get_timewise_user_list(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_timewise_user_list(p_json jsonb, OUT p_user_list jsonb, OUT p_record_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_created_date timestamp;
v_updated_date timestamp;
v_page_number numeric;
v_item_number numeric;
v_fromrownumber numeric;
v_torownumber numeric;
v_count numeric;
begin
select p_json->>'created_date',
        p_json->>'updated_date',
		p_json->>'page_number',
		p_json->>'item_number'
		into v_created_date,
		v_updated_date,
		v_page_number,
		v_item_number;
		
		
		
v_fromrownumber := (v_page_number * v_item_number - (v_item_number - 1));
v_torownumber   := (v_page_number * v_item_number);

select cnt, '{"userlist":['||string_agg(row_to_json(row)::text,',')||'],
              "pagination":{
			   "total_user_count": "",
               "next_page_number": ""
			  }}' 
		from(
		select data::jsonb,page_flag,created_date,updated_date,count(1)over() as cnt,sl_no,
			professional_score,
			passion_score,
			personality_code_1,
			personality_code_2,
			report_type,
			service,
			campaign_name,
			Source
			---report_url
			 from
		(
			select client_mod_json->>'data'   as data,
			client_mod_json->>'page_flag' as page_flag,
			row_number()over(order by created_date) as sl_no,
			created_date,updated_date,
			professional_score,
			passion_score,
			personality_code as  personality_code_1,
			report_type,
			personality_code2 as personality_code_2,
			university_code,
			service,
			campaign_name,
			Source
			--report_url
			from (
             select cw.client_mod_json,
			  (cw.created_date at time zone 'utc' +interval '330 minute') ::date as created_date, 
			(cw.updated_date at time zone 'utc' +interval '330 minute') ::date as updated_date,
				(ut.updated_date at time zone 'utc' +interval '330 minute') ::date as test_updated_date,
				ut.professional_score,
				ut.passion_score,
				ut.personality_code,
				ut.report_url,
				ut.report_type,
				ut.personality_code2,
				u.university_code,
				u.service,
				u.campaign_name,
				(case u.client_id when 5 then 'custom' else 'social' end) as Source
			 from
labbsc_dev.labbsc_dev_client_web_cust_model cw
join labbsc_dev.labbsc_dev_web_user u
				on u.user_guid=cw.user_guid
	left join labbsc_dev.labbsc_dev_user_tests ut
				on ut.user_id=u.user_id
 where  cw.module_name = 'user_profile'
			 ) as tb
		where created_date =  coalesce(v_created_date,created_date)  
			and (updated_date=
			case when v_created_date is null then  v_updated_date 
			else updated_date end or coalesce(test_updated_date,current_timestamp)= v_updated_date)
			)tc
		)
 as row
 where sl_no between v_fromrownumber and v_torownumber
 group by cnt
 into p_record_count,p_user_list;
  
 
		
		
		end;
$$;


--
