-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_purchase_test(numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: labbsc_dev_purchase_test(numeric, character varying, numeric); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_purchase_test(p_opt_type numeric, p_user_guid character varying, p_video_id numeric, OUT p_result numeric, OUT p_cart_json jsonb) RETURNS record
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
	v_video_flag numeric;
	v_video_title varchar(4000);
	v_video_desc text;
	v_report_count numeric;
	v_sporview_flag numeric;
	v_sporview_payment numeric;
begin
	
	select user_id
	into strict v_user_id
	from labbsc_dev.labbsc_dev_web_user
	where user_guid = p_user_guid;

	if p_opt_type=1 then
	v_activity_id:=1;
	end if;
	if p_opt_type=2 then
	v_activity_id:=3;
	end if;
	
	if p_opt_type=3 then
	v_activity_id:=4;
	end if;
	
	if p_opt_type=4 then
	v_activity_id:=5;
	end if;
	
	if p_opt_type=5 then
	v_activity_id:=7;
	end if;
	if p_opt_type=6 then
	v_activity_id:=8;
	end if;
	if p_opt_type=7 then
	v_activity_id:=9;
	end if;
	
	if p_opt_type=8 then
	v_activity_id:=10;
	end if;
	
	if p_opt_type=9 then
	v_activity_id:=11;
	end if;
	if p_opt_type=10 then
	v_activity_id:=12;
	end if;
	
	if p_opt_type=11 then
	v_activity_id:=13;
	end if;
	
	if p_opt_type=12 then
	v_activity_id:=14;
	end if;
	
	if p_opt_type=13 then
	v_activity_id:=15;
	end if;
	
	if p_opt_type=14 then
	v_activity_id:=16;
	end if;
	
	if p_opt_type=15 then
	v_activity_id:=17;
	end if;
	
	if p_opt_type=16 then
	v_activity_id:=18;
	end if;
	
	if p_opt_type=17 then
	v_activity_id:=19;
	end if;
	
   if p_opt_type=18 then
	v_activity_id:=20;
	end if;
	
	if p_opt_type=19 then
	v_activity_id:=21;
	end if;
	
	if p_opt_type=20 then
	v_activity_id:=22;
	end if;
	
	if p_opt_type=21 then
	v_activity_id:=23;
	end if;
	 
	 if p_opt_type=22 then
	v_activity_id:=24;
	end if;
	
	if p_opt_type=23 then
	v_activity_id:=25;
	end if;
	
	if p_opt_type=24 then
	v_activity_id:=26;
	end if;
	
	if p_opt_type=25 then
	v_activity_id:=27;
	end if;
	
	if p_opt_type=26 then
	v_activity_id:=28;
	end if;
	
	if p_opt_type=27 then
	v_activity_id:=29;
	end if;
	
	if p_opt_type=28 then
	v_activity_id:=30;
	end if;
	
	if p_opt_type=29 then
	v_activity_id:=31;
	end if;
	
	if p_opt_type=30 then
	v_activity_id:=32;
	end if;
	
	if not exists(select * from labbsc_dev.labbsc_dev_cart 
				  where user_id = v_user_id and status = 2 and activity_id =v_activity_id) then
		
		---p_result := 1;
		v_first_test_payment := case when v_activity_id in (1,7,8,9,10,11,13,14,19,20,21,22,
														   24,25,26,27,28,29,30,31,32) then 1 end;

		p_result := case when v_activity_id in (3,4) then 1 end; 
		v_counseller_flag:=case when v_activity_id=3 then 1 end;
		v_video_flag:=case when v_activity_id=4 then 1 end;
		v_sporview_flag:=case when v_activity_id=5 then 1 end;
	 	 raise notice '%',v_first_test_payment;
		
		
	else
		
		select client_mod_json->'data'->'me_and_working_in_sports'->>'sport_interest',
		status
		 
		into v_sports_domain ,v_status-- , v_work_experience_year, v_work_experience_month
		from labbsc_dev.labbsc_dev_client_web_cust_model
		where user_guid = p_user_guid
		and module_name = 'user_profile';
		
 
		
		if v_sports_domain = '' or v_sports_domain is null or v_status =0 /*or v_total_work_experience_months = 0*/ then
			p_result := -2;
				v_message := 'Please complete your profile';
		 
		end if;
		
	end if;
	raise notice '%,%',p_result,v_activity_id;
	
	if p_result is null and v_activity_id in (1,3,7,8,9,10,11,13,14,16,17,18) then
		
		select ut.test_id, ut.valid_till::date
		into v_test_id, v_date
		from labbsc_dev.labbsc_dev_user_tests ut
		join labbsc_dev.labbsc_dev_cart c
		on c.cart_id = ut.cart_id
		and c.user_id = ut.user_id
		where ut.user_id = v_user_id
		and c.status = 2
		and ut.is_attempted = 0
		and ut.valid_till >= v_current_timestamp;

		if v_test_id is not null then
			p_result := -3;
			v_message := 'You already have a test to attempt';
			v_url := 'https://beta1-sporjo.sportz.io/sporscorr';
			--'https://www.sporjo.com/sporscorr';
		end if;
		
	end if;
	raise notice '%,%',p_result,v_activity_id;
	if p_result is null and v_activity_id in (1,3,7,8,9,10,11,13,14,16,17,18,19,20,21,22) then
		
		select ut.test_id, (ut.attempted_on + '1 year'::interval)::date,ut.report_url
		into v_test_id, v_date,v_report_url
		from labbsc_dev.labbsc_dev_user_tests ut
		join labbsc_dev.labbsc_dev_cart c
		on c.cart_id = ut.cart_id
		and c.user_id = ut.user_id
		where ut.user_id = v_user_id
		and c.status = 2
		and ut.is_attempted = 1
		and (ut.attempted_on + '1 year'::interval) >= v_current_timestamp;
		
		if (v_test_id is not null and v_report_url is not null and v_activity_id in(1,7,8,10,11,13,14,19,20,21,22)) then
			p_result := -4;
			v_message := 'You have to wait for next year before attempting another test';
		end if;
		
		if (v_test_id is not null and v_report_url is null) then
			p_result :=-3;
		    v_message := 'You already have a test to attempt';
			v_url := 'https://beta1-sporjo.sportz.io/sporscorr';
			--'https://www.sporjo.com/sporscorr';
		end if;
		
		else
		select count(1)
		from labbsc_dev.labbsc_dev_user_tests
		where user_id=v_user_id
		and  is_attempted = 1
		and report_url is not null
		into v_report_count;
		
	end if;

  select count(1)
  from labbsc_dev.labbsc_dev_cart
  where user_id=v_user_id
  and activity_id=5
  and status=2
  into v_sporview_payment;

 --- raise notice '%,%,%,%',p_result,v_first_test_payment,v_counseller_flag,v_video_flag;
	if p_result is null  or (v_first_test_payment = 1 and p_result is null)
	or v_counseller_flag=1 or v_video_flag=1 or v_sporview_flag=1 then
		
		begin
			
			select max(cart_id)
			into strict v_cart_id
			from labbsc_dev.labbsc_dev_cart
			where user_id = v_user_id
			and activity_id = v_activity_id
			and coalesce(video_id,0)=coalesce(p_video_id,0)
			and status in (0,1);
	 	--- raise notice '%,%',v_cart_id,v_user_id;
			update labbsc_dev.labbsc_dev_cart
			set updated_date = v_current_timestamp,
				is_discounted = null,
				discount_code = null,
				discount_amount = null,
				net_amount = gross_amount
			where cart_id = v_cart_id;
			 raise notice '%',v_cart_id;
			 
			  select fee
				into v_fee
				from labbsc_dev.labbsc_dev_journey_activity
				where activity_id = v_activity_id;
				
				 raise notice '%', v_fee;
			 
	if v_cart_id is null then	
	 
	    
		  
			 
			 
				if v_activity_id in (4) then
				select asset_title,
				web_detail_jsn->'data'->'seo'->>'meta_desc'
				from 
                 labbsc_dev.labbsc_dev_asset_list
                where asset_type_id=4 
				and asset_id=p_video_id
				into v_video_title,v_video_desc;
			
			end if;
				 
				v_cart_id := nextval('labbsc_dev.seq_labbsc_dev_cart_id');
			 	insert into labbsc_dev.labbsc_dev_cart(cart_id, user_id, activity_id, gross_amount, net_amount, status, created_date, updated_date,video_id)
				select v_cart_id, v_user_id, v_activity_id, v_fee, v_fee, 0, v_current_timestamp, v_current_timestamp,p_video_id;
				
		 
	end if;		
		end;
		
		
			
			 
		if v_activity_id in (1,3,5,7,8,9,10,11,12,13,14,15,16,17,19,20,21,22,24,25,26,27,28,29,30,31,32) then
		if      v_sporview_payment=1 and v_activity_id=1 then
		v_activity_id:=6;
		end if;
		 ---raise notice '%,%',v_cart_id,v_activity_id;
			---- select 1/0;
		select ('{"cart_id":'||v_cart_id::text||',"data":'||row_to_json(row)::text||',"result":"1","message":null,"date":null,"url":null}')::jsonb
		from (select title, description, image_url,  fee
			  from labbsc_dev.labbsc_dev_journey_activity
			  where activity_id = v_activity_id
			 ) row
		into p_cart_json;
		
		end if;
		
		if v_activity_id =4 then
		select ('{"cart_id":'||v_cart_id::text||',"data":'||row_to_json(row)::text||',"result":"1","message":null,"date":null,"url":null}')::jsonb
		from (select v_video_title as title,
			  v_video_desc as description, 
			  case when v_report_count>0 then 1 else 0 end as test_report_count, 
			  v_fee as fee
			  ) row
		into p_cart_json;
		
		end if;
		
		
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
	/*
exception
	when no_data_found then
		p_result := 0;
		p_cart_json := '{"cart_id":null,"data":null,"result":"0","message":null,"date":null,"url":null}'::jsonb;
*//*	when others then
		p_result := -1;
		p_cart_json := '{"cart_id":null,"data":null,"result":"-1","message":null,"date":null,"url":null}'::jsonb;
	*/
end;
$$;


--
