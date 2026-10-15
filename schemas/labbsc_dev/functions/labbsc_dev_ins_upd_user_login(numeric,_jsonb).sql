-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_user_login(numeric, jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_user_login(numeric, jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_user_login(p_opttype numeric, p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
    v_client_id numeric;
    v_social_user_name character varying;
    v_user_full_name character varying;
    v_email_id character varying;
    v_user_password character varying;
    v_social_id character varying;
    v_upper_email_id character varying;
    v_web_user_id numeric;
    v_user_guid character varying;
    v_is_active numeric;
    v_is_deleted numeric;
    v_created_by numeric;
    v_updated_by numeric;
    v_created_date timestamp without time zone;
    v_updated_date timestamp without time zone;
    v_reset_key character varying;
    v_key_expiry_date timestamp without time zone;
    v_reset_key_status numeric;
    v_dob text;
    v_profile_picture_url character varying;
    v_city character varying;
    v_mobile_no text;
    v_gender character varying;
    v_sport_skill json;
    v_sport_skill_map json; 
    v_sport_id numeric;
    v_skill_level numeric;
    v_result numeric;
    v_is_verified numeric;
    v_is_custom  numeric;
    v_userjson jsonb;
    v_favourite_club character varying;
    v_edition character varying;
    v_status numeric; 
    v_is_first_login   numeric := 0 ;
    v_token  character varying;
    v_epoch_timestamp  character varying;
    v_confirm_password character varying;
    v_old_password character varying;
    v_failed_attempts numeric;
    v_unlock_date timestamp;
    v_is_registered  numeric;
    v_ipaddress   character varying;
    v_message character varying;
    v_is_app numeric;
    v_user_id numeric;
    v_img_url character varying;
    v_is_login numeric;
    v_verification_key  character varying;
    v_err_code character varying;
    v_err_msg character varying;
    v_emailid_ex  character varying;
    v_is_custom_image numeric;
	v_old_profile_image_url  character varying;
	v_is_custom_image_tab numeric;
	v_favourite_player_id character varying;
	v_address text;
	v_profile_completion_percentage numeric;
    v_reg_cnt numeric:=0;
   	v_gift_id numeric:=0;
   	v_gift_name varchar(500):='NO GIFT';
   	v_gratification_value numeric;
   	v_profile_complete numeric;
   	v_better_luck_value numeric;
	v_gift_url text;
	v_other_gift_count numeric;
	v_other_gift_percentage numeric;
	v_total_gift_count numeric;
	v_profile_completion numeric;
	v_first_name character varying;
	v_last_name character varying;
	v_profile_enabled numeric := 0;
	v_sports_vertical character varying;
	v_sporting_event_inspired_you character varying;
	v_campaign_name varchar(500);
	v_university_name text;
	v_module_name varchar(500);
	 v_university_code text;
	 v_cart_id numeric;
	 v_activity_id numeric;
	 v_fee numeric;
	 v_partner_name text;
	 v_custom_json jsonb;
	 v_test_id numeric;
	 v_date timestamp;
	 v_report_url text;
begin
	
 	v_current_timestamp := current_timestamp at time zone 'utc';
	
	select p_user_json->'data'->>'user_guid',
			p_user_json->'data'->>'token',
           	p_user_json->'data'->>'epoch_timestamp',
           	p_user_json->'data'->>'social_id',
           	p_user_json->'data'->>'client_id', 
		   	p_user_json->'data'->>'email_id',
		   	p_user_json->'data'->>'status',
           	p_user_json->'data'->>'reset_key',
           	p_user_json->'data'->>'key_expiry_date',
           	p_user_json->'data'->>'password',
           	p_user_json->'data'->>'confirm_password',
           	p_user_json->'data'->>'old_password',
		   	p_user_json->'data'->>'failed_attempts',
		   	p_user_json->'data'->>'unlock_date',
		   	p_user_json->'data'->>'is_registered',
		   	p_user_json->'data'->>'is_verified',
		   	p_user_json->'data'->>'ipaddress',
		   	p_user_json->'data'->'user'->>'mobile_no',
           	p_user_json->'data'->'user'->>'name',
           	p_user_json->'data'->'user'->>'social_user_name',
           	p_user_json->'data'->'user'->>'dob',
           	p_user_json->'data'->'user'->>'gender',
           	p_user_json->'data'->'user'->>'city',
           	p_user_json->'data'->'user'->>'favourite_club',
           	p_user_json->'data'->'user'->>'edition',
           	p_user_json->'data'->'user'->>'social_user_image',
           	p_user_json->'data'->>'is_app',
           	p_user_json->'data'->>'verification_key',
           	p_user_json->'data'->>'is_deleted',
           	p_user_json->'data'->>'is_active',
		   	p_user_json->'data'->>'is_custom_image',
		   	p_user_json->'data'->'user'->>'favourite_player_id',
		   	p_user_json->'data'->'user'->>'address',
		   p_user_json->'data'->'user'->>'profile_completion_percentage',
		   p_user_json->'data'->'user'->>'first_name',
		   p_user_json->'data'->'user'->>'last_name',
		   p_user_json->'data'->'user'->>'sports_vertical',
		   p_user_json->'data'->'user'->>'sporting_event_inspired_you',
		   p_user_json->'data'->>'campaign_id',
		   p_user_json->'data'->>'partner_name',
		   p_user_json->'data'->>'module_name',
		   p_user_json->'data'->>'custom_json'
	into v_user_guid,
			v_token,
			v_epoch_timestamp,
           	v_social_id,
           	v_client_id,
           	v_email_id,
           	v_is_active,
           	v_reset_key,
           	v_key_expiry_date,
           	v_user_password,
           	v_confirm_password,
           	v_old_password,
           	v_failed_attempts,
           	v_unlock_date,
           	v_is_registered,
           	v_is_verified,
           	v_ipaddress,
           	v_mobile_no,
           	v_user_full_name,
           	v_social_user_name,
           	v_dob,
           	v_gender, 
           	v_city,
           	v_favourite_club,
           	v_edition,
           	v_profile_picture_url,
           	v_is_app, 
           	v_verification_key,
           	v_is_deleted,
           	v_is_active,
          -- v_profile_picture_url,
		  v_is_custom_image,
		  v_favourite_player_id,
		  v_address,
		  v_profile_completion_percentage,
		  v_first_name,
		  v_last_name,
		  v_sports_vertical,
		  v_sporting_event_inspired_you,
           v_campaign_name,
		   v_partner_name,
		   v_module_name,
		   v_custom_json;
		   
		   
		 --- raise notice '%',v_campaign_name;
   	
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;   
    /* ****************************************
      Client_id     Client 
      1             Facebook
      2             Twitter
      4             Google+
      5	            Custom
    ****************************************  */
    
     
    -- -----------------------------------------------------------------------------------------------------------------------------
   	if p_opttype = 2 then   -- p_opttype = 2 Custom Registration   
    
    if not exists(select 1 from labbsc_dev.labbsc_dev_web_user
				  where upper_email_id = v_upper_email_id 
			---	  and client_id = v_client_id  
-- and is_active = 1
)
            then 
                v_web_user_id := nextval('labbsc_dev.seq_labbsc_dev_web_users_id');
                v_user_guid := uuid_generate_v4();
                v_is_active := 1;
                v_is_deleted := 0; 
             v_is_verified = 1 ; 
                v_created_date := v_current_timestamp;
                v_updated_date := v_current_timestamp;  	
           v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
                v_is_login := 0;	
					v_module_name:=upper(v_module_name);
                
                insert into labbsc_dev.labbsc_dev_web_user
                (user_id, client_id, email_id, upper_email_id, user_password, user_guid, is_active, is_deleted, created_date, updated_date, is_registered,
is_verified, token, epoch_timestamp, ipaddress, is_login, verification_key,created_by , updated_by, 
                 favourite_club, edition, profile_picture_url , is_custom_image,first_name,last_name,sports_vertical,sporting_event_inspired_you,
				dob,mobile_no,campaign_name,partner_name,university_code,module_name,custom_json )
                select v_web_user_id, v_client_id, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
                v_created_date, v_updated_date, 1, v_is_verified, v_token, v_epoch_timestamp, v_ipaddress, v_is_login, v_verification_key,1 ,1,
                v_favourite_club, v_edition, 'Uiwo6dOG90psCEd7TmLLU3IbGQwEse7L9prbqEKa3fw=', 1,v_first_name,v_last_name,v_sports_vertical,v_sporting_event_inspired_you,
				v_dob,v_mobile_no,v_campaign_name,v_partner_name,null,
				case when v_module_name IN ('SPORJOPLUS') then 'Sporjo Plus'
				 when v_module_name ='SPORJOMENTOR' then 'Sporjo Mentor' else null end ,
				v_custom_json;
				
				
			
			 if v_module_name is not null
				then
				  
				
				
				
				select activity_id,fee
				from labbsc_dev.labbsc_dev_journey_activity
				where merchant_name=v_module_name
				and activity_id=case when merchant_name='SPORSCORR' then 1 else activity_id end
				into v_activity_id,v_fee;
				
				if v_activity_id in (1,3,4,7,8) then
				select ut.test_id, (ut.attempted_on + '1 year'::interval)::date,ut.report_url
		into v_test_id, v_date,v_report_url
		from labbsc_dev.labbsc_dev_user_tests ut
		join labbsc_dev.labbsc_dev_cart c
		on c.cart_id = ut.cart_id
		and c.user_id = ut.user_id
		where ut.user_id = v_web_user_id
		and c.status = 2
		and ut.is_attempted = 1
		and (ut.attempted_on + '1 year'::interval) >= v_current_timestamp;
		
		if v_test_id is not null then
			p_result := -3;
			v_message := 'You already have a test to attempt';
 
      ---   else
		/* if (v_activity_id in (3,4)
			 and not exists(select 1 from labbsc_dev.labbsc_dev_user_tests
		 where user_id=v_web_user_id
		 and report_url is not null))then
		  	p_result := -2;
			v_message := 'Your test assessment is pending.';
		 
		 end if;*/
		end if;
		end if;
				
				
				if (v_activity_id is not null and p_result is null) then
			 	 
				v_cart_id := nextval('labbsc_dev.seq_labbsc_dev_cart_id');
				insert into labbsc_dev.labbsc_dev_cart(cart_id, user_id, activity_id, gross_amount, net_amount, status, created_date, updated_date,video_id,upload_flag)
				select v_cart_id, v_web_user_id, v_activity_id, v_fee, v_fee, 2, v_current_timestamp, v_current_timestamp,null,1;
				 
				if v_activity_id in (1,7,8)  then
				  
				insert into labbsc_dev.labbsc_dev_user_tests(test_id, user_id, cart_id, valid_till, is_attempted, created_date, updated_date)
				select nextval('labbsc_dev.seq_labbsc_dev_user_test_id'), v_web_user_id, v_cart_id, v_current_timestamp + '1 year'::interval, 0, v_current_timestamp, v_current_timestamp;
				 end if;
				
				
				end if;
				end if; 
                
                v_is_first_login := 1;
      
			v_status :=3 ;	
			v_message := 'Registration successful please wait....redirecting you to the payment page. Please don''t close this browser window.';-- end;    
	            	
            else
            
select is_verified, profile_picture_url , is_custom_image,first_name,last_name,sports_vertical,sporting_event_inspired_you,campaign_name,user_guid
into v_is_verified,  v_profile_picture_url, v_is_custom_image,v_first_name,v_last_name,v_sports_vertical,v_sporting_event_inspired_you ,v_campaign_name,v_user_guid
from labbsc_dev.labbsc_dev_web_user 
where upper_email_id = v_upper_email_id 
---and client_id = v_client_id  
-- and is_active = 1 
;

                v_status = 0 ; 
v_message := 'Email already in use. please go to sing-in in order to proceed further.';
   
v_is_first_login := 0;   
v_is_login = 0 ;

            end if ;

            insert into labbsc_dev.labbsc_dev_web_user_audit
(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
select nextval('labbsc_dev.seq_labbsc_dev_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
      v_last_name:=null;  

end if ;

 
       
	
---------------------------	
if p_result is null then
    p_result := 1  ;
end if;	
	
	p_ures_json = '{
						 "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '|| v_status ||',
						"message": "'|| v_message||'",
						"error": {
						"code": '|| v_status ||',
						"message":  "'|| v_message||'"						
						},
						"user": {
								 "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
								 "name": "'||coalesce(v_user_full_name,'') ||'",
								 "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
								 "first_name": "'|| coalesce(v_first_name,'') ||'",
								 "last_name": "'|| coalesce(v_last_name,'') ||'",
								 "dob": "'|| coalesce(v_dob::varchar,'') ||'",
								 "gender": "'|| coalesce(v_gender,'') ||'",
								 "city": "'|| coalesce(v_city,'')||'",
								 "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
								  "favourite_player_id": "'||coalesce(v_favourite_player_id::varchar,'') ||'",
								 "edition": "'|| coalesce(v_edition,'') ||'",
								 "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'" ,
								 "address": "'|| coalesce(v_address,'') ||'",
								 "profile_completion_percentage": "'|| coalesce(v_profile_completion::varchar,'') ||'",
								 "profile_page_enabled" : "'|| v_profile_enabled::text ||'",
								 "sports_vertical": "'|| coalesce(v_sports_vertical,'') ||'",
								 "sporting_event_inspired_you": "'|| coalesce(v_sporting_event_inspired_you,'') ||'"
								},
						"is_first_login": 0,
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						 "old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"	,
						 "gift_id" : "'|| coalesce(v_gift_id::varchar,'') ||'",
						 "gift_name" : "'|| coalesce(v_gift_url,'') ||'",
						 "client_id": '||coalesce(v_client_id,0) ||',
						 "campaign_id": "'|| coalesce(v_campaign_name,'') ||'",
						  "university_name": "'|| coalesce(v_university_name,'') ||'"
						 }
					}' ;

-----------------	
 /*
exception 
    when others then
   v_err_code := SQLSTATE;
          v_err_msg := SQLERRM;
 p_result := -1;
 p_ures_json := '{
 "data": {
"user_guid": "",           
"status": "",
"message": "",
"error": {
"code": "'||coalesce(v_err_code,'')||'",
"message": "'|| coalesce(v_err_msg,'') ||'"
},
"user": {
 "name":""
},
"is_first_login": "'|| coalesce(v_is_first_login,0) || '",
"is_app": '|| coalesce(v_is_app,0) ||'
 }
}';*/
      --  v_json :=  jsonb_set(to_jsonb(v_json), '{data,error,code}', ('"'||v_1||'"')::jsonb, true);
       -- return	; 
       
end;
$$;


--
