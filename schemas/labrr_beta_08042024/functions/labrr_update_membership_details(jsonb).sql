-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_update_membership_details(jsonb)
-- Type: FUNCTION

-- Name: labrr_update_membership_details(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_update_membership_details(p_json jsonb, OUT p_tran_status numeric, OUT p_tran_json jsonb) RETURNS record
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
   v_delivery_firstname character varying;
    v_delivery_lastname character varying;
	v_billing_firstname character varying;
    v_billing_lastname character varying;
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
   p_campaign_json jsonb;
   v_campaigns_json jsonb;
   v_campaign_ids int[];
   v_is_expiry numeric;
   v_product_cart_id numeric;
   v_junior_membership boolean;
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

--membership code will be assign to every new membership For eg: 

select product_code into v_product_code from labrr.labrr_product where product_id=v_product_id;

v_expiry :=to_char(to_timestamp(v_expiry1,'dd-mm-yyyy HH24:MI:SS'), 'yyyy-mm-dd HH24:MI:SS');

-- check if user membership data is present or not in web_user_membership table if present membership_code 
--should not there to generate new coupon code
if (exists (select 1 from labrr.labrr_web_user_membership,
			LATERAL jsonb_array_elements(campaign_json->'membership_details') as elements where elements->>'membership_type' = v_product_code
			and elements->>'membership_pdf_path' = v_pdflink
			and(elements->>'membership_code' = '' or elements->>'membership_code' is null) and user_guid=v_user_guid) OR (not exists
			(select 1 from labrr.labrr_web_user_membership,
			LATERAL jsonb_array_elements(campaign_json->'membership_details') as elements where elements->>'membership_type' = v_product_code
			and elements->>'membership_pdf_path' = v_pdflink
			and user_guid=v_user_guid)) or (not EXISTS
			(select 1 from labrr.labrr_web_user_membership where user_guid=v_user_guid))) AND
			(exists (select 1 from labrr.labrr_web_user where user_guid=v_user_guid))then
                   
	    select p_json->'data'->>'membership_code' into v_membership_code;
    ELSE
    
		SELECT elements->>'membership_code' into v_membership_code FROM labrr.labrr_web_user_membership,
      LATERAL jsonb_array_elements(campaign_json->'membership_details') AS elements
	  WHERE   elements->>'membership_type' = v_product_code and elements->>'membership_pdf_path' = v_pdflink and  user_guid=v_user_guid;
end if;

-- Check if membership expired or not for that product
if (exists (select 1 from labrr.labrr_web_user_membership,
			LATERAL jsonb_array_elements(campaign_json->'membership_details') as elements where elements->>'membership_type' = v_product_code 
			and elements->>'membership_pdf_path' = v_pdflink
			and((elements->>'membership_expiry_date')::timestamp>=CURRENT_TIMESTAMP) and user_guid=v_user_guid)
			OR (not exists (select 1 from labrr.labrr_web_user_membership,
			LATERAL jsonb_array_elements(campaign_json->'membership_details') as elements where elements->>'membership_type' = v_product_code 
			and elements->>'membership_pdf_path' = v_pdflink
			and user_guid=v_user_guid))	or (not EXISTS
			(select 1 from labrr.labrr_web_user_membership where user_guid=v_user_guid))) AND
			(exists (select 1 from labrr.labrr_web_user where user_guid=v_user_guid))then
                   
	    v_is_expiry:=0;
    ELSE
    
	    v_is_expiry:=1;
end if;

-- check if user membership data is present or not in web_user_membership table if present membership_coupon_code 
--should not there to generate new coupon code
if (exists (select 1 from labrr.labrr_web_user_membership,
			LATERAL jsonb_array_elements(campaign_json->'membership_details') as elements where elements->>'membership_type' = v_product_code
			and elements->>'membership_pdf_path' = v_pdflink			
			and(elements->>'membership_coupon_code' = '' or elements->>'membership_coupon_code' is null) and user_guid=v_user_guid) OR (not exists
			(select 1 from labrr.labrr_web_user_membership,
			LATERAL jsonb_array_elements(campaign_json->'membership_details') as elements where elements->>'membership_type' = v_product_code 
			and elements->>'membership_pdf_path' = v_pdflink
			and user_guid=v_user_guid)) or (not EXISTS
			(select 1 from labrr.labrr_web_user_membership where user_guid=v_user_guid))) AND
			(exists (select 1 from labrr.labrr_web_user where user_guid=v_user_guid))then

        select coupon_code into v_coupon_code from labrr.labrr_membership_coupon where is_flag <> 1 or is_flag is null limit 1;
	    update labrr.labrr_membership_coupon set is_flag=1 where coupon_code=v_coupon_code;
    ELSE
	
      SELECT elements->>'membership_coupon_code' into v_coupon_code FROM labrr.labrr_web_user_membership,
      LATERAL jsonb_array_elements(campaign_json->'membership_details') AS elements
	  WHERE   elements->>'membership_type' = v_product_code and elements->>'membership_pdf_path' = v_pdflink and  user_guid=v_user_guid;
end if;

if exists (select 1 from labrr.labrr_web_user where user_guid=v_user_guid) then    

select pcp.transaction_date,pcp.amount,psu.discounted_amount,psu.discount_code,psu.discount_type,pc.product_cart_id,
psu.billing_firstname,psu.billing_lastname,psu.delivery_firstname,psu.delivery_lastname 
from labrr.labrr_product_cart_paydetails pcp 
join labrr.labrr_product_cart pc on pc.product_cart_id=pcp.product_cart_id
join labrr.labrr_product_shipment_user psu on psu.product_cart_id=pc.product_cart_id
where pc.product_id=v_product_id and pcp.user_guid=v_user_guid 
and lower(pcp.order_status)=lower('SUCCESS') and pcp.module_name='membership'
into v_transaction_date,v_amount,v_discounted_amount,v_discount_code,v_discount_type,v_product_cart_id,
v_billing_firstname,v_billing_lastname,v_delivery_firstname,v_delivery_lastname;

if (exists (select 1 from labrr.labrr_product_discount_coupon where is_active=1 and expiry_date>=current_timestamp and lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type))) then

v_coupon_validity:= 'VALID';

elsif (exists (select 1 from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type)) ) then

v_coupon_validity:= 'INVALID';

end if;

select expiry_date into v_coupon_expiry from labrr.labrr_product_discount_coupon where lower(discount_code)=lower(v_discount_code) and lower(discount_type)=lower(v_discount_type);

if (v_product_id=23) then
v_junior_membership:=true;

else
v_junior_membership:=false;
end if;

v_campaign_json:='{
"junior_membership":"'||coalesce(v_junior_membership::varchar,'') ||'",
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
"discount_coupon_expiry":"'||coalesce(v_coupon_expiry::varchar,'') ||'",
"campaign_id": "'|| coalesce(v_product_id,0) ||'",
"membership_code": "'||coalesce(v_membership_code::varchar,'')||'",
"is_expiry": "'|| coalesce(v_is_expiry,0) ||'",
"billing_firstname": "'||coalesce(v_billing_firstname::varchar,'')||'",
"billing_lastname": "'||coalesce(v_billing_lastname::varchar,'')||'",
"delivery_firstname": "'||coalesce(v_delivery_firstname::varchar,'')||'",
"delivery_lastname": "'||coalesce(v_delivery_lastname::varchar,'')||'"
}';

p_campaign_json := jsonb_build_object('membership_details', jsonb_build_array(v_campaign_json));

-- user membership data is present and product is also present in the table
if exists (select 1 from labrr.labrr_web_user_membership,
			LATERAL jsonb_array_elements(campaign_json->'membership_details') as elements 
			where elements->>'membership_type' = v_product_code and elements->>'membership_pdf_path' = v_pdflink and user_guid=v_user_guid) then 

select campaign_json into p_campaign_json from labrr.labrr_web_user_membership where user_guid=v_user_guid;
-----Updated_json contain replaced json for required product code
WITH updated_json AS (
    SELECT jsonb_agg(
        CASE
            WHEN elem->>'membership_type' = v_product_code
            THEN v_campaign_json::jsonb
            ELSE elem
        END
    )
    FROM jsonb_array_elements(p_campaign_json->'membership_details') AS elem
)
SELECT jsonb_set(p_campaign_json, '{membership_details}', (SELECT * FROM updated_json)) into p_campaign_json;

update labrr.labrr_web_user_membership set campaign_json=p_campaign_json where user_guid=v_user_guid;
		
			
--user membership data is present but product is not present in the table	
elsif not exists (select 1 from labrr.labrr_web_user_membership,
			LATERAL jsonb_array_elements(campaign_json->'membership_details') as elements where elements->>'membership_type' = v_product_code 
			and elements->>'membership_pdf_path' = v_pdflink
			and user_guid=v_user_guid) and exists(select 1 from labrr.labrr_web_user_membership where user_guid=v_user_guid) THEN
-----Append the data into columns		
update labrr.labrr_web_user_membership set 
campaign_json = jsonb_set(campaign_json, '{membership_details}', (campaign_json->'membership_details') || v_campaign_json) 
,campaign_ids=campaign_ids || array[v_product_id]::int[] where user_guid=v_user_guid;			
			
--user membership data is not present
ELSE
-----New entry into the table
insert into labrr.labrr_web_user_membership values (nextval('labrr.seq_labrr_web_user_membership_id'),v_user_guid,p_campaign_json,array[v_product_id]::int[]);

end if;

select user_id, email_id, upper_email_id, user_password, wu.user_guid, wu.is_active, wu.is_deleted, wu.created_date, wu.updated_date,
				is_verified, token, epoch_timestamp, ipaddress, is_login, verification_key, 
                 favourite_club, edition, profile_picture_url,user_full_name,mobile_no,city_id,state_id,country_id,
				 ext_info,is_shared_data,is_used_data,membership_code,jersey_number,favourite_player_id,gender,dob,--first_name,last_name,
				 pincode,city,jersey_name,subscribe_for_email,country_code,mobile_verified,email_verified,subscribe_for_watsapp,
				 accept_tnc,wum.campaign_json,first_name,last_name,psu.delivery_firstname,psu.delivery_lastname 
                 from labrr.labrr_web_user wu 
				 join labrr.labrr_web_user_membership wum on wum.user_guid=wu.user_guid 
				 join labrr.labrr_product_shipment_user psu on psu.product_cart_id=v_product_cart_id
				 where wu.user_guid=v_user_guid
				 into
				 v_web_user_id, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
                v_created_date, v_updated_date, v_is_verified, v_token, v_epoch_timestamp, v_ipaddress, v_is_login, v_verification_key,
                v_favourite_club, v_edition, v_profile_picture_url,v_user_full_name,v_mobile_no,v_city_id,v_state_id,v_country_id, --v_first_name,v_last_name,
				v_ext_info,v_is_shared_data,v_is_used_data,v_membership_code,v_jersey_number,
				v_favourite_player_id,v_gender,v_dob,v_pincode,v_city,v_jersey_name,v_subscribe_for_email,v_country_code,v_mobile_verified,
				v_email_verified,v_subscribe_for_watsapp,v_accept_tnc,v_campaigns_json,v_first_name,v_last_name,v_delivery_firstname,v_delivery_lastname;

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
						  "pug_first_name": "'||coalesce(v_delivery_firstname,v_first_name) ||'",
						  "pug_last_name": "'||coalesce(v_delivery_lastname,v_last_name) ||'",
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
						  "country_code": "'||coalesce(v_country_code,0) ||'"
                          
						},
						  "created_date": "'||v_created_date||'",
						  "updated_date": "'||v_updated_date||'"						
					  }
					}'; 
                          
                    p_tran_json:=jsonb_set(p_tran_json,'{data,user,campaign_json}',coalesce(to_jsonb(v_campaign_json),'{}'));
					p_tran_json:=jsonb_set(p_tran_json,'{data,user,membership_related_json}',coalesce(to_jsonb(v_campaigns_json),'{}'));

p_tran_status:=1;

ELSE
p_tran_json:='{}';
p_tran_status:=0;
end if;

end;

$$;


--
