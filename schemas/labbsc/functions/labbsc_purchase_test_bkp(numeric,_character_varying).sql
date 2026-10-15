-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_purchase_test_bkp(numeric, character varying)
-- Type: FUNCTION

-- Name: labbsc_purchase_test_bkp(numeric, character varying); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_purchase_test_bkp(p_opt_type numeric, p_user_guid character varying, OUT p_result numeric, OUT p_cart_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_id numeric;
	v_first_test_payment numeric;
	v_sports_domain text;
-- 	v_work_experience_year text;
-- 	v_work_experience_month text;
-- 	v_total_work_experience_months numeric;
	v_test_id numeric;
	v_date date;
	v_message text;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_cart_id numeric;
	v_fee numeric;
	v_cart_json jsonb;
	v_url text;
	v_status numeric;
	v_is_attempted numeric;
	v_report_url text;
	v_activity_id numeric;
	v_first_session numeric;
	v_counseller_flag numeric;
begin
	
	select user_id
	into strict v_user_id
	from labbsc.labbsc_web_user
	where user_guid = p_user_guid;

	if p_opt_type=1 then
	v_activity_id:=1;
	else
	v_activity_id:=3;
	end if;
	
	if not exists(select * from labbsc.labbsc_cart where user_id = v_user_id and status = 2 and activity_id =v_activity_id) then
		
		---p_result := 1;
		v_first_test_payment := case when v_activity_id=1 then 1 end;

		p_result := case when v_activity_id=3 then 1 end; 
		v_counseller_flag:=case when v_activity_id=3 then 1 end; 
	 	---raise notice '%',p_result;
		
		
	else
		
		select client_mod_json->'data'->'me_and_working_in_sports'->>'sport_interest',
		status
		 
		into v_sports_domain ,v_status-- , v_work_experience_year, v_work_experience_month
		from labbsc.labbsc_client_web_cust_model
		where user_guid = p_user_guid
		and module_name = 'user_profile';
		
 
		
		if v_sports_domain = '' or v_sports_domain is null or v_status =0 /*or v_total_work_experience_months = 0*/ then
			p_result := -2;
				v_message := 'Please complete your profile';
		---	v_message := 'Please complete your profile before applying for test';
		end if;
		
	end if;
	
	if p_result is null then
		
		select ut.test_id, ut.valid_till::date
		into v_test_id, v_date
		from labbsc.labbsc_user_tests ut
		join labbsc.labbsc_cart c
		on c.cart_id = ut.cart_id
		and c.user_id = ut.user_id
		where ut.user_id = v_user_id
		and c.status = 2
		and ut.is_attempted = 0
		and ut.valid_till >= v_current_timestamp;

		if v_test_id is not null then
			p_result := -3;
			v_message := 'You already have a test to attempt';
			v_url := 'https://beta-sporjo.sportz.io/meetcs';
			--'https://www.sporjo.com/sporscorr';
		end if;
		
	end if;
	
	if p_result is null then
		
		select ut.test_id, (ut.attempted_on + '1 year'::interval)::date,ut.report_url
		into v_test_id, v_date,v_report_url
		from labbsc.labbsc_user_tests ut
		join labbsc.labbsc_cart c
		on c.cart_id = ut.cart_id
		and c.user_id = ut.user_id
		where ut.user_id = v_user_id
		and c.status = 2
		and ut.is_attempted = 1
		and (ut.attempted_on + '3 months'::interval) >= v_current_timestamp;
		
		if (v_test_id is not null and v_report_url is not null and v_activity_id=1) then
			p_result := -4;
			v_message := 'You have to wait for atleast 3 months before attempting another test';
		end if;
		
		if (v_test_id is not null and v_report_url is null) then
			p_result :=-3;
		    v_message := 'You already have a test to attempt';
			v_url := 'https://beta-sporjo.sportz.io/meetcs';
			--'https://www.sporjo.com/sporscorr';
		end if;
		
		
	end if;

 ---raise notice '%,%,%',p_result,v_first_test_payment,v_counseller_flag;
	if p_result is null  or v_first_test_payment = 1 or v_counseller_flag=1 then
		
		begin
			
			select max(cart_id)
			into strict v_cart_id
			from labbsc.labbsc_cart
			where user_id = v_user_id
			and activity_id = v_activity_id
			and status in (0,1);
		----	 raise notice '%,%',v_cart_id,v_user_id;
			update labbsc.labbsc_cart
			set updated_date = v_current_timestamp,
				is_discounted = null,
				discount_code = null,
				discount_amount = null,
				net_amount = gross_amount
			where cart_id = v_cart_id;
			 
			 
	if v_cart_id is null then		 
				select fee
				into v_fee
				from labbsc.labbsc_journey_activity
				where activity_id = v_activity_id;
				 
				v_cart_id := nextval('labbsc.seq_labbsc_cart_id');
			 	insert into labbsc.labbsc_cart(cart_id, user_id, activity_id, gross_amount, net_amount, status, created_date, updated_date)
				select v_cart_id, v_user_id, v_activity_id, v_fee, v_fee, 0, v_current_timestamp, v_current_timestamp;
				
		 
	end if;		
		end;
		
		select ('{"cart_id":'||v_cart_id::text||',"data":'||row_to_json(row)::text||',"result":"1","message":null,"date":null,"url":null}')::jsonb
		from (select title, description, image_url, fee
			  from labbsc.labbsc_journey_activity
			  where activity_id = v_activity_id
			 ) row
		into p_cart_json;
		
		if p_cart_json is not null then
			p_result := 1;
		end if;
		
	else
		
		p_cart_json := ('{
							"cart_id":null,
							"data":null,
							"result":"'||p_result::text||'",
							"message":"'||coalesce(v_message,'')||'",
							"date":"'||coalesce(v_date::text,'')||'",
							"url":"'||coalesce(v_url,'')||'"
						}')::jsonb;
		
	end if;
	
exception
	when no_data_found then
		p_result := 0;
		p_cart_json := '{"cart_id":null,"data":null,"result":"0","message":null,"date":null,"url":null}'::jsonb;
	when others then
		p_result := -1;
		p_cart_json := '{"cart_id":null,"data":null,"result":"-1","message":null,"date":null,"url":null}'::jsonb;
	
end;
$$;


--
