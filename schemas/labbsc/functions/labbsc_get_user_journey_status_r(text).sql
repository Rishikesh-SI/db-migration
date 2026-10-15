-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_user_journey_status_r(text)
-- Type: FUNCTION

-- Name: labbsc_get_user_journey_status_r(text); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_user_journey_status_r(p_user_guid text, OUT p_user_journey_status jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_id numeric;
	v_is_profile_filled numeric;
	v_profile_completion_percentage numeric;
	v_test_ever_attempted numeric := 0;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_any_test_pending numeric := 0;
	v_tests_history jsonb;
	v_payment_status numeric;
	v_max_cart_id numeric;
	v_status numeric;
	v_repot_url text;
	v_counseller_payment_status numeric;
	v_counseller_history jsonb;
	v_max_counseller_cart_id numeric;
	v_counseller_id numeric;
	v_counseller_name varchar(500);
	v_session_id numeric;
	v_request_id numeric;
begin
	 
	
	if p_user_guid is not null and p_user_guid <> '' then
		
		select user_id
		into strict v_user_id
		from labbsc.labbsc_web_user
		where user_guid = p_user_guid;
		
		select 1, profile_completion,status
		into v_is_profile_filled, v_profile_completion_percentage,v_status
		from labbsc.labbsc_client_web_cust_model
		where module_name = 'user_profile'
		and user_guid = p_user_guid;
		
		if exists(select 1 from labbsc.labbsc_user_tests
				  where user_id = v_user_id
				  and is_attempted = 1) then
			
			v_test_ever_attempted := 1;
			
		end if;
		if v_test_ever_attempted =1 then
		 select max(cart_id)
		 from labbsc.labbsc_cart
		where user_id =v_user_id
		and activity_id =3
		into v_max_counseller_cart_id;
		
		
		if v_max_counseller_cart_id is not null then
		
		select status,counseller_id,counseller_name,session_id,request_id
		from labbsc.labbsc_cart
		where user_id =v_user_id
		and cart_id =v_max_counseller_cart_id
		into v_counseller_payment_status,v_counseller_id,v_counseller_name,v_session_id,v_request_id;
		
		else 
		v_counseller_payment_status:=0;
		end if;
		
		else 
		v_counseller_payment_status:=0;
		end if;
		
		select max(cart_id)
		from labbsc.labbsc_cart
		where user_id =v_user_id
		and activity_id =1
		into v_max_cart_id;
		
		
		if v_max_cart_id is not null then
		
		select status
		from labbsc.labbsc_cart
		where user_id =v_user_id
		and cart_id =v_max_cart_id
		into v_payment_status;
		
		else 
		v_payment_status:=0;
		end if;
		
		
		
		if exists(select * from labbsc.labbsc_user_tests
				  where user_id = v_user_id
				  and (is_attempted = 0 or (is_attempted = 1  and report_url is null))
				  and valid_till > v_current_timestamp) then
			
			v_any_test_pending := 1;
			
		end if;
		begin
		select ut.report_url
	    from labbsc.labbsc_user_tests ut
		join labbsc.labbsc_cart c
		on c.cart_id = ut.cart_id
		and c.user_id = ut.user_id
		where ut.user_id = v_user_id
		and c.status = 2
		and ut.is_attempted = 1
		and (ut.attempted_on + '3 months'::interval) >= v_current_timestamp
		 	into v_repot_url;
		 exception when no_data_found then
		 null;
		end;
		
		select jsonb_agg(row_to_json(row))
		from (select 'Test' as name, created_date as purchased_on,
			  valid_till, is_attempted, attempted_on, coalesce(report_url,v_repot_url) as url, updated_date
			  from labbsc.labbsc_user_tests
			  where user_id = v_user_id
			  order by purchased_on
			 ) row
		into v_tests_history;
		
		select jsonb_agg(row_to_json(row))
		from (
			select * from (
			select 'Consultant' as name, us.session_date,us.session_slot,
		us.status as counselling_status,u.display_name as counseller_name,
case when coalesce(us.feedback_status,0) =1 then us.feedback else null end as feedback ,
			  us.is_requested,us.is_rescheduled ,us.session_id
		 from labbsc.labbsc_user_counselling_session us
		 join labbsc.labbsc_user u
		 on u.user_id=us.counseller_id
		 where  us.user_id=v_user_id
			  union 
			  select 'Consultant' as name, us.session_date,us.session_slot,
		us.status as counselling_status,u.display_name as counseller_name,
            null  as feedback ,
			  case when status=0 then 1 else 0 end is_requested,
			  null as is_rescheduled ,us.slot_request_id as session_id
		 from labbsc.labbsc_user_slot_request us
		 join labbsc.labbsc_user u
		 on u.user_id=us.counseller_user_id
		 where  us.user_id=v_user_id
			and us.status=0
				
			) as tb
		 order by session_date desc,session_id desc
			 ) row
		into v_counseller_history;
		
		
		select row_to_json(row)
		from (
		select v_is_profile_filled as is_profile_filled, v_profile_completion_percentage as profile_completion_percentage,
				v_test_ever_attempted as test_ever_attempted, v_any_test_pending as any_test_pending, v_tests_history as tests_history,
		v_payment_status as payment_status,
		v_status as status,
		v_counseller_payment_status as counseller_payment_status,
		v_counseller_history as counseller_history,
		v_counseller_id as counselor_id 
		 ,v_counseller_name as counselor_name,
		case when (v_session_id is null and v_request_id is null) then 1 else 0 end as counseller_flag
		) row
		into p_user_journey_status;
		
		if (p_user_journey_status is not null  ) then
			
			p_result := 1;
			 
		end if;
		
		
	else
		
		p_result := 0;
		
	end if;
	
	 /*
exception
	when others then
		p_result := -1;
	
	when no_data_found then
		p_result := -2;*/
	
end;
$$;


--
