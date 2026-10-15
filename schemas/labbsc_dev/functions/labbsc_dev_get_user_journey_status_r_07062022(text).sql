-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_user_journey_status_r_07062022(text)
-- Type: FUNCTION

-- Name: labbsc_dev_get_user_journey_status_r_07062022(text); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_user_journey_status_r_07062022(p_user_guid text, OUT p_user_journey_status jsonb, OUT p_result numeric) RETURNS record
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
	v_sporview_cart_id numeric;
	v_sporview_history jsonb;
	v_sporview_payment_status numeric;
	v_campaign_name varchar(500);
	v_sporjo_plus_status numeric;
	v_sporjoplus_cart_id numeric;
	v_module_name varchar(500);
	v_sporjo_mentor_status numeric;
	v_sporjomentor_cart_id numeric;
	v_partner_name text;
	v_code text;
	v_summertest_payment_status numeric;
	v_max_summertest_cart_id numeric;
	v_product_name varchar(500);
	v_max_video_cart_id numeric;
	v_video_payment_status numeric;
	v_max_mentorship_cart_id numeric;
	v_mentorship_payment_status numeric;
	v_max_exmentorship_cart_id numeric;
	v_exmentorship_payment_status numeric;
	v_max_humanics_cart_id numeric;
	v_humanics_payment_status numeric;
	
	v_max_scorrprep_cart_id numeric;
	v_scorrprep_payment_status numeric;
	
	
	v_max_scorrconslt_cart_id numeric;
	v_scorrconslt_payment_status numeric;
	
	v_max_getsetsporjo_cart_id numeric;
	v_getsetsporjo_payment_status numeric;
	
	v_max_plusstandard_cart_id numeric;
	v_plusstandard_payment_status numeric;
	
	v_max_pluselite_cart_id numeric;
	v_pluselite_payment_status numeric;
	
	v_max_pluspro_cart_id numeric;
	v_pluspro_payment_status numeric;
	
	v_max_module1_cart_id numeric;
	v_module1_payment_status numeric;
	
	v_max_module2_cart_id numeric;
	v_module2_payment_status numeric;
	
	v_max_module3_cart_id numeric;
	v_module3_payment_status numeric;
	
	v_max_module4_cart_id numeric;
	v_module4_payment_status numeric;
	
	v_max_module5_cart_id numeric;
	v_module5_payment_status numeric;
	
	
	v_max_CFSE1_cart_id numeric;
	v_CFSE1_payment_status numeric;

	v_max_CFSE2_cart_id numeric;
	v_CFSE2_payment_status numeric;

	v_max_RMSE1_cart_id numeric;
	v_RMSE1_payment_status numeric;

	v_max_RMSE2_cart_id numeric;
	v_RMSE2_payment_status numeric;

	v_max_EUE1_cart_id numeric;
	v_EUE1_payment_status numeric;

	v_max_EUE2_cart_id numeric;
	v_EUE2_payment_status numeric;

	v_max_ESE1_cart_id numeric;
	v_ESE1_payment_status numeric;

	v_max_ESE2_cart_id numeric;
	v_ESE2_payment_status numeric;
	
	v_expiry_date date;
	v_service text;
	
begin
	 
	
	if p_user_guid is not null and p_user_guid <> '' then
		
		select user_id,campaign_name,partner_name,university_code,service
		into strict v_user_id,v_campaign_name,v_partner_name,v_code,v_service
		from labbsc_dev.labbsc_dev_web_user
		where user_guid = p_user_guid;
		
		select 1, profile_completion,status
		into v_is_profile_filled, v_profile_completion_percentage,v_status
		from labbsc_dev.labbsc_dev_client_web_cust_model
		where module_name in ('user_profile','sporjo_coach_user_profile')
		and user_guid = p_user_guid;
		---raise notice '%',v_profile_completion_percentage;
		--select 1/0;
		if exists(select 1 from labbsc_dev.labbsc_dev_user_tests
				  where user_id = v_user_id
				  and is_attempted = 1) then
			
			v_test_ever_attempted := 1;
			
		end if;
		if (v_test_ever_attempted =1 or v_partner_name is not null) then
		 select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =3
		into v_max_counseller_cart_id;
		
		--raise notice '%',v_max_counseller_cart_id;
	--	select 1/0;
		
	 
		if v_max_counseller_cart_id is not null then
		
		select status,counseller_id,counseller_name,session_id,request_id
		from labbsc_dev.labbsc_dev_cart
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
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =1
		into v_max_cart_id;
		
		
		if v_max_cart_id is not null then
		
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_cart_id
		into v_payment_status;
		
		else 
		v_payment_status:=0;
		end if;
		
		
		
		select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =4
		into v_max_video_cart_id;
		
		if v_max_video_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_video_cart_id
		into v_video_payment_status;
		 end if;
		
		
		select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =5
		into v_sporview_cart_id;
		
		if v_sporview_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_sporview_cart_id
		into v_sporview_payment_status;
		 end if;
		 
		 select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =7
		into v_sporjoplus_cart_id;
		
		 if v_sporjoplus_cart_id is not null then
		 select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_sporjoplus_cart_id
		 into v_sporjo_plus_status;
		 end if;
		 
		  select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =8
		into v_sporjomentor_cart_id;
		
		 if v_sporjomentor_cart_id is not null then
		 select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_sporjomentor_cart_id
		 into v_sporjo_mentor_status;
		 end if;
		 
		 select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =9
		into v_max_summertest_cart_id;
		
		if v_max_summertest_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_summertest_cart_id
		into v_summertest_payment_status;
		 end if;
		 
		 select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =10
		into v_max_mentorship_cart_id;
		
		if v_max_mentorship_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_mentorship_cart_id
		into v_mentorship_payment_status;
		 end if;
		 
		  select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =11
		into v_max_exmentorship_cart_id;
		
		if v_max_exmentorship_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_exmentorship_cart_id
		into v_exmentorship_payment_status;
		 end if;
		 
		 
		 
		  select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =12
		into v_max_humanics_cart_id;
		
		if v_max_humanics_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_humanics_cart_id
		into v_humanics_payment_status;
		 end if;
		 
		 
		   select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =13
		into v_max_scorrprep_cart_id;
		
		if v_max_scorrprep_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_scorrprep_cart_id
		into v_scorrprep_payment_status;
		 end if;
		 
		   select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =14
		into v_max_scorrconslt_cart_id;
		
		if v_max_scorrconslt_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_scorrconslt_cart_id
		into v_scorrconslt_payment_status;
		 end if;
		 
		  select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id in(15,24)
		into v_max_getsetsporjo_cart_id;
		
		if v_max_getsetsporjo_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_getsetsporjo_cart_id
		into v_getsetsporjo_payment_status;
		 end if;
		 
		 
		 select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =16
		into v_max_plusstandard_cart_id ;
		
		
		
		
		if v_max_plusstandard_cart_id  is not null then
		
	--	raise notice '%', v_user_id;
	--	raise notice '%', v_user_id;
		
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_plusstandard_cart_id
		into v_plusstandard_payment_status ;
		
raise notice '16 %',v_plusstandard_payment_status;
		
		
		 end if;
		 
		 
		 
		 select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =17
		into v_max_pluselite_cart_id  ;
		
		if v_max_pluselite_cart_id  is not null then
		
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_pluselite_cart_id
		into v_pluselite_payment_status  ;

raise notice '17 %',v_pluselite_payment_status;

		 end if;
		 
		 select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =18
		into v_max_pluspro_cart_id  ;
		
		
		
		if v_max_pluspro_cart_id  is not null then
		
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_pluspro_cart_id
		into v_pluspro_payment_status  ;
raise notice '18 %',v_pluspro_payment_status;

		 end if;
		 
		 select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =19
		into v_max_module1_cart_id;
		
		if v_max_module1_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_module1_cart_id
		into v_module1_payment_status;
		 end if;


select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =20
		into v_max_module2_cart_id;
		
		if v_max_module2_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_module2_cart_id
		into v_module2_payment_status;
		 end if;
		 
		 
select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =21
		into v_max_module3_cart_id;
		
		if v_max_module3_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_module3_cart_id
		into v_module3_payment_status;
		 end if;
		 
select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =22
		into v_max_module4_cart_id;
		
		if v_max_module4_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_module4_cart_id
		into v_module4_payment_status;
		 end if;

select max(cart_id)
		 from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id =23
		into v_max_module5_cart_id;
		
		if v_max_module5_cart_id is not null then
		select status
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and cart_id =v_max_module5_cart_id
		into v_module5_payment_status;
		 end if;
		 
		 select max(cart_id)
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id = 25
		into v_max_CFSE1_cart_id ;
		
		
		
		if v_max_CFSE1_cart_id is not null then
		  select status
		  from labbsc_dev.labbsc_dev_cart
		  where user_id =v_user_id
		  and cart_id = v_max_CFSE1_cart_id
		  into v_CFSE1_payment_status ;
		 end if;
		 
		 

		select max(cart_id)
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id = 26
		into v_max_CFSE2_cart_id ;
		
		
		
		if v_max_CFSE2_cart_id is not null then
		  select status
		  from labbsc_dev.labbsc_dev_cart
		  where user_id =v_user_id
		  and cart_id = v_max_CFSE2_cart_id
		  into v_CFSE2_payment_status ;
		 end if;
		 
		 raise notice '%',v_CFSE2_payment_status;
		 
		 
		 select max(cart_id)
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id = 27
		into v_max_RMSE1_cart_id  ;
		
		if v_max_RMSE1_cart_id is not null then
		  select status
		  from labbsc_dev.labbsc_dev_cart
		  where user_id =v_user_id
		  and cart_id = v_max_RMSE1_cart_id 
		  into v_RMSE1_payment_status  ;
		 end if;
		 
		 
		 select max(cart_id)
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id = 28
		into v_max_RMSE2_cart_id  ;
		
		if v_max_RMSE2_cart_id is not null then
		  select status
		  from labbsc_dev.labbsc_dev_cart
		  where user_id =v_user_id
		  and cart_id = v_max_RMSE2_cart_id 
		  into v_RMSE2_payment_status  ;
		 end if;
		 
		 
		  select max(cart_id)
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id = 29
		into v_max_EUE1_cart_id   ;
		
		if v_max_EUE1_cart_id is not null then
		  select status
		  from labbsc_dev.labbsc_dev_cart
		  where user_id =v_user_id
		  and cart_id = v_max_EUE1_cart_id  
		  into v_EUE1_payment_status   ;
		 end if;
		 
		 select max(cart_id)
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id = 30
		into v_max_EUE2_cart_id   ;
		
		if v_max_EUE2_cart_id is not null then
		  select status
		  from labbsc_dev.labbsc_dev_cart
		  where user_id =v_user_id
		  and cart_id = v_max_EUE2_cart_id  
		  into v_EUE2_payment_status   ;
		 end if;
		 
		 select max(cart_id)
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id = 31
		into v_max_ESE1_cart_id    ;
		
		if v_max_ESE1_cart_id is not null then
		  select status
		  from labbsc_dev.labbsc_dev_cart
		  where user_id =v_user_id
		  and cart_id = v_max_ESE1_cart_id   
		  into v_ESE1_payment_status   ;
		 end if;
		 
		 select max(cart_id)
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
		and activity_id = 32
		into v_max_ESE2_cart_id    ;
		
		if v_max_ESE2_cart_id is not null then
		  select status
		  from labbsc_dev.labbsc_dev_cart
		  where user_id =v_user_id
		  and cart_id = v_max_ESE2_cart_id   
		  into v_ESE2_payment_status   ;
		 end if;


		 select  ((max(created_date) + '5.5 hours'::interval)::date + '3 months'::interval)::date into v_expiry_date 
		 from labbsc_dev.labbsc_dev_invoice_detail
	     where user_id = v_user_id and transaction_status = 'Success' and merchant_name in ('PlusPro','PlusElite','PlusStandard');
		 
		if v_expiry_date is null then
			select  ((max(created_date) + '5.5 hours'::interval)::date + '3 months'::interval)::date into v_expiry_date 
			from labbsc_dev.labbsc_dev_cart where user_id = v_user_id and activity_id in(16,17,18)
			and v_plusstandard_payment_status = 2 and v_pluselite_payment_status = 2 and 
			v_pluspro_payment_status = 2;
		end if;	
		
		
		if exists(select * from labbsc_dev.labbsc_dev_user_tests
				  where user_id = v_user_id
				  and (is_attempted = 0 or (is_attempted = 1  and report_url is null))
				  and valid_till > v_current_timestamp) then
			
			v_any_test_pending := 1;
			
			raise notice '%',v_any_test_pending;
			
		end if;
		begin
		select ut.report_url
	    from labbsc_dev.labbsc_dev_user_tests ut
		join labbsc_dev.labbsc_dev_cart c
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
			  from labbsc_dev.labbsc_dev_user_tests
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
		 from labbsc_dev.labbsc_dev_user_counselling_session us
		 join labbsc_dev.labbsc_dev_user u
		 on u.user_id=us.counseller_id
		 where  us.user_id=v_user_id
			  union 
			  select 'Consultant' as name, us.session_date,us.session_slot,
		us.status as counselling_status,u.display_name as counseller_name,
            null  as feedback ,
			  case when status=0 then 1 else 0 end is_requested,
			  null as is_rescheduled ,us.slot_request_id as session_id
		 from labbsc_dev.labbsc_dev_user_slot_request us
		 join labbsc_dev.labbsc_dev_user u
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
		 case when v_counseller_payment_status in (0,1) then 1 else v_counseller_payment_status end as    counseller_payment_status,
		v_counseller_history as counseller_history,
		v_counseller_id as counselor_id 
		 ,v_counseller_name as counselor_name,
		case when (v_session_id is null and v_request_id is null) then 1 else 0 end as counseller_flag,
			case when coalesce(v_sporview_payment_status,0) in (0,1) then 1 else v_sporview_payment_status end as sporview_payment_status,
			v_campaign_name as campaign_name,
			case when v_sporjo_plus_status in (0,1) then 1 else v_sporjo_plus_status end as sporjo_plus_payment_status,
			case when v_sporjo_plus_status = 2 then 'Sporjo Plus' 
			when v_sporjo_mentor_status = 2 then 'Sporjo Mentor'
			when v_plusstandard_payment_status =  2 then 'Sporjo Plus'
			when v_pluselite_payment_status =  2 then 'Sporjo Plus'
			when v_pluspro_payment_status =  2 then 'Sporjo Plus'
			when v_service like 'complete-sports-solutions' then 'Complete Sports Solutions'
			when v_service like 'css/%' then 'Complete Sports Solutions'
			else 'Sporjo' end as module_name,
			case when v_sporjo_mentor_status in (0,1) then 1 else v_sporjo_mentor_status end as v_sporjo_mentor_status ,
			v_partner_name as partner_name,
			v_code as code,
			case when v_summertest_payment_status in (0,1) then 1 else v_summertest_payment_status end as summertest_payment_status
			,
			case when v_video_payment_status in (0,1) then 1 else v_video_payment_status end as video_payment_status,
			case when v_mentorship_payment_status in (0,1) then 1 else v_mentorship_payment_status end as mentorship_payment_status,
			case when v_exmentorship_payment_status in (0,1) then 1 else v_exmentorship_payment_status end as exmentorship_payment_status,
			case when v_humanics_payment_status in (0,1) then 1 else v_humanics_payment_status end as humanics_payment_status,
			case when v_scorrprep_payment_status in (0,1) then 1 else v_scorrprep_payment_status end as scorrprep_payment_status,
			case when v_scorrconslt_payment_status in (0,1) then 1 else v_scorrconslt_payment_status end as scorrconslt_payment_status,
			case when v_getsetsporjo_payment_status in (0,1) then 1 else v_getsetsporjo_payment_status end as getsetsporjo_payment_status,
			case when v_plusstandard_payment_status  in (0,1) then 1 else v_plusstandard_payment_status end as plusstandard_payment_status,
			case when v_pluselite_payment_status   in (0,1) then 1 else v_pluselite_payment_status end as pluselite_payment_status ,
			case when v_pluspro_payment_status   in (0,1) then 1 else v_pluspro_payment_status  end as pluspro_payment_status ,
			case when v_module1_payment_status   in (0,1) then 1 else v_module1_payment_status  end as module1_payment_status ,
			case when v_module2_payment_status   in (0,1) then 1 else v_module2_payment_status  end as module2_payment_status ,
			case when v_module3_payment_status   in (0,1) then 1 else v_module3_payment_status  end as module3_payment_status ,
			case when v_module4_payment_status   in (0,1) then 1 else v_module4_payment_status  end as module4_payment_status ,
			case when v_module5_payment_status   in (0,1) then 1 else v_module5_payment_status  end as module5_payment_status ,
			
			case when v_CFSE1_payment_status in (0,1) then 1 else v_CFSE1_payment_status end as CFSE1_payment_status,
case when v_CFSE2_payment_status in (0,1) then 1 else v_CFSE2_payment_status end as CFSE2_payment_status,
case when v_RMSE1_payment_status in (0,1) then 1 else v_RMSE1_payment_status end as RMSE1_payment_status,
case when v_RMSE2_payment_status in (0,1) then 1 else v_RMSE2_payment_status end as RMSE2_payment_status,
case when v_EUE1_payment_status in (0,1) then 1 else v_EUE1_payment_status end as EUE1_payment_status ,
case when v_EUE2_payment_status in (0,1) then 1 else v_EUE2_payment_status end as EUE2_payment_status ,
case when v_ESE1_payment_status in (0,1) then 1 else v_ESE1_payment_status end as ESE1_payment_status ,
case when v_ESE2_payment_status in (0,1) then 1 else v_ESE2_payment_status end as ESE2_payment_status ,
			v_expiry_date as expiry_date
			
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
