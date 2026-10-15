-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_update_membership_details_15012024(jsonb)
-- Type: FUNCTION

-- Name: labrr_update_membership_details_15012024(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_update_membership_details_15012024(p_json jsonb, OUT p_tran_status numeric, OUT p_tran_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_user_guid character varying;
v_product_id numeric;
v_expiry1 character varying;
v_expiry timestamp;

v_membership_code character varying;
v_transaction_date timestamp;
v_amount decimal;
v_campaign_json jsonb;
v_campaign_id numeric;

v_social_user_name character varying;
    v_user_full_name character varying;
    v_email_id character varying;
    v_user_password character varying;
    v_social_id character varying;
    v_upper_email_id character varying;
    v_web_user_id numeric;
    v_is_active numeric;
    v_is_deleted numeric;
    v_created_by numeric;
    v_updated_by numeric;
    v_created_date timestamp without time zone;
    v_updated_date timestamp without time zone;
    v_reset_key character varying;
    v_key_expiry_date timestamp without time zone;
    v_reset_key_status numeric;
    v_dob character varying;
    v_profile_picture_url character varying;
    v_city character varying;
    v_mobile_no character varying;
    v_gender character varying;
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
	v_country_id numeric;
	v_state_id  numeric;
	v_city_id   numeric;
	v_country_name text;
	v_state_name text ;
	v_city_name  text;
    v_email_social  text;
    --v_mobile_social  text;
    v_profile_image_social  text;
    v_profile_completion_percentage numeric;
    v_is_new_reg numeric:=0;
    v_reg_cnt numeric:=0;
   v_gift_id numeric:=0;
   v_gift_url text;
   v_gift_name varchar(500):='NO GIFT';
   v_available_quantity numeric;
   v_gratification_value numeric;
   v_profile_complete numeric;
   v_better_luck_value numeric;
   v_subject text;
   v_first_name character varying;
	v_last_name character varying;
	v_waf_user_guid character varying;
	v_ext_info jsonb;
	v_is_shared_data numeric;
   v_is_used_data numeric;
   v_jersey_number numeric;
   v_favourite_player_id character varying;
   v_pincode character varying;
   v_jersey_name character varying;
   v_subscribe_for_email boolean;
   v_country_code numeric;
   v_platform_version character varying;
   v_device_name character varying;
   v_platform_type numeric;
   v_option_type numeric;
   v_mobile_verified numeric;
   v_email_verified numeric;
   v_subscribe_for_watsapp boolean;
   v_accept_tnc boolean;
   v_pdflink character varying;
   v_coupon_code character varying;
   v_card_path character varying;
   v_product_code character varying;
   v_discounted_amount decimal;
   v_discount_code character varying;
   v_discount_type character varying;
   v_coupon_expiry timestamp;
   v_coupon_validity character varying;
begin

select p_json->'data'->>'user_guid',
p_json->'data'->>'product_id',
p_json->'data'->>'expiry_date',
p_json->'data'->>'pdflink',
p_json->'data'->>'membership_card_path'
INTO
v_user_guid,
v_product_id,
v_expiry1,
v_pdflink,
v_card_path
;

--insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
					--log_error_message,log_guid,error_json,created_date,client_name,log_type)
				--values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-update_membership_details','logs',uuid_generate_v4(),p_json,current_timestamp,'labrr','logs');

v_expiry :=to_char(to_timestamp(v_expiry1,'dd-mm-yyyy HH24:MI:SS'), 'yyyy-mm-dd HH24:MI:SS');
--raise notice '%',v_expiry;
if exists (select 1 from labrr.labrr_web_user where membership_code is null 
                   and user_guid=v_user_guid) then
                   
	    select p_json->'data'->>'membership_code' into v_membership_code;
    ELSE
    
	    select membership_code into v_membership_code from labrr.labrr_web_user where user_guid=v_user_guid;
end if;

if exists (select 1 from labrr.labrr_web_user where (campaign_json->>'membership_coupon_code' = '' or 
              campaign_json->>'membership_coupon_code' is null) and user_guid=v_user_guid) then
               
        select coupon_code into v_coupon_code from labrr.labrr_membership_coupon where is_flag <> 1 or is_flag is null limit 1;
	    update labrr.labrr_membership_coupon set is_flag=1 where coupon_code=v_coupon_code;
    ELSE
    
	    select campaign_json->>'membership_coupon_code' into v_coupon_code from labrr.labrr_web_user where user_guid=v_user_guid;
end if;

select product_code into v_product_code from labrr.labrr_product where product_id=v_product_id;

if exists (select 1 from labrr.labrr_web_user where user_guid=v_user_guid) then    

select pcp.transaction_date,pcp.amount,psu.discounted_amount,psu.discount_code,psu.discount_type 
from labrr.labrr_product_cart_paydetails pcp 
join labrr.labrr_product_cart pc on pc.product_cart_id=pcp.product_cart_id
join labrr.labrr_product_shipment_user psu on psu.product_cart_id=pc.product_cart_id
where pc.product_id=v_product_id and pcp.user_guid=v_user_guid 
and lower(pcp.order_status)=lower('SUCCESS') and pcp.module_name='membership'  
into v_transaction_date,v_amount,v_discounted_amount,v_discount_code,v_discount_type;

if (exists (select 1 from labrr.labrr_product_discount_coupon where is_active=1 and expiry_date>=current_timestamp and lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type))) then

v_coupon_validity:= 'VALID';

elsif (exists (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type)) ) then

v_coupon_validity:= 'INVALID';

end if;

select expiry_date into v_coupon_expiry from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type);

--select transaction_date,amount from labrr.labrr_product_cart_paydetails where user_guid=v_user_guid 
--and product_cart_id in (select product_cart_id from labrr.labrr_product_cart where product_id=v_product_id)
--into v_transaction_date,v_amount;

--raise notice 'v_expiry:%',v_expiry;

v_campaign_json:='{
"membership_expiry_date":"'||coalesce(v_expiry::varchar,'') ||'",
"membership_start_date": "'||coalesce(v_transaction_date::varchar,'')||'",
"membership_amount": "'|| coalesce(v_amount,0) ||'",
"membership_pdf_path":"'||coalesce(v_pdflink::varchar,'') ||'",
"membership_coupon_code": "'||coalesce(v_coupon_code::varchar,'')||'",
"membership_image_path": "'||coalesce(v_card_path::varchar,'')||'",
"membership_type": "'||coalesce(v_product_code::varchar,'')||'",
"discount_coupon_type":"'||coalesce(v_discount_type::varchar,'') ||'",
"discount_coupon_code":"'||coalesce(v_discount_code::varchar,'') ||'",
"discount_amount": "'|| coalesce(v_discounted_amount,0) ||'",
"discount_coupon_validity": "'|| coalesce(v_coupon_validity::varchar,'') ||'",
"discount_coupon_expiry":"'||coalesce(v_coupon_expiry::varchar,'') ||'"
}';

update labrr.labrr_web_user set campaign_id=v_product_id,membership_code=v_membership_code,campaign_json=v_campaign_json
where user_guid=v_user_guid;

select user_id, email_id, upper_email_id, user_password, user_guid, is_active, is_deleted, created_date, updated_date,
				is_verified, token, epoch_timestamp, ipaddress, is_login, verification_key, 
                 favourite_club, edition, profile_picture_url,user_full_name,mobile_no,city_id,state_id,country_id,
				 gender,dob,first_name,last_name,ext_info,is_shared_data,is_used_data,membership_code,jersey_number,favourite_player_id,
				 pincode,city,jersey_name,subscribe_for_email,country_code,mobile_verified,email_verified,subscribe_for_watsapp,
				 accept_tnc,campaign_id,campaign_json from labrr.labrr_web_user where user_guid=v_user_guid
				 into
				 v_web_user_id, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
                v_created_date, v_updated_date, v_is_verified, v_token, v_epoch_timestamp, v_ipaddress, v_is_login, v_verification_key,
                v_favourite_club, v_edition, v_profile_picture_url,v_user_full_name,v_mobile_no,v_city_id,v_state_id,v_country_id,
				v_gender,v_dob,v_first_name,v_last_name,v_ext_info,v_is_shared_data,v_is_used_data,v_membership_code,v_jersey_number,
				v_favourite_player_id,v_pincode,v_city,v_jersey_name,v_subscribe_for_email,v_country_code,v_mobile_verified,
				v_email_verified,v_subscribe_for_watsapp,v_accept_tnc,v_campaign_id,v_campaign_json ;

p_tran_json = '{
					  "data": {
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"email_verified": "'|| coalesce(v_email_verified,0) ||'",
						"mobile_verified": "'|| coalesce(v_mobile_verified,0) ||'",
						"subscribe_for_email": "'||coalesce(v_subscribe_for_email,'false')||'",
                        "user_id": "'|| coalesce(v_web_user_id::varchar,'')||'",
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "first_name": "'||coalesce(v_first_name,'') ||'",
						  "last_name": "'||coalesce(v_last_name,'') ||'",
						  "membership_code": "'|| coalesce(v_membership_code,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
                          "country_id": "'|| coalesce(v_country_id::varchar,'')||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
						  "jersey_number": "'||coalesce(v_jersey_number,0) ||'",
						  "favourite_player_id": "'||coalesce(v_favourite_player_id,'') ||'",
						  "pincode": "'||coalesce(v_pincode,'') ||'",
						  "jersey_name": "'||coalesce(v_jersey_name,'') ||'",	
						  "country_code": "'||coalesce(v_country_code,0) ||'",
						  "campaign_id": "'||coalesce(v_product_id::varchar,'') ||'"
                          
						},
						  "created_date": "'||v_created_date||'",
						  "updated_date": "'||v_updated_date||'"						
					  }
					}' ; 
                    --p_ures_json:=jsonb_set(p_ures_json,'{data,user,campaign_json}',coalesce(to_jsonb(v_campaign_json),'{}'));
					p_tran_json:=jsonb_set(p_tran_json,'{data,user,campaign_json}',coalesce(v_campaign_json,'{}'));
                    --p_tran_json:=jsonb_set(p_tran_json,'{data,user,campaign_json,membership_expiry_date}',coalesce(v_expiry1,''));

p_tran_status:=1;

--insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
					--log_error_message,log_guid,error_json,created_date,client_name,log_type)
				--values (nextval('siwaf.seq_siwaf_api_error_log_id'),'output-update_membership_details','logs',uuid_generate_v4(),p_tran_json,current_timestamp,'labrr','logs');

ELSE
p_tran_json:='{}';
p_tran_status:=0;
end if;

end;

$$;


--
