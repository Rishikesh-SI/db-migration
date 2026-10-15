-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_upd_moengage_fields(jsonb)
-- Type: FUNCTION

-- Name: labgt_upd_moengage_fields(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_upd_moengage_fields(p_input jsonb, OUT p_output jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_dob text;
	v_city text;
	v_gender text;
	v_first_name text;
	v_last_name text;
	v_jersey_number numeric;
	v_social_user_image text;
	v_social_user_name text;
	v_pincode text;
    v_user_guid character varying;
	v_favourite_player_id character varying;
	v_jersey_name character varying;
	v_subscribe_for_email boolean;
	v_membership_code character varying;
	v_created_date timestamp without time zone;
    v_updated_date timestamp without time zone;
	v_accept_tnc boolean;
    v_accept_disclaimer boolean;
	v_token  character varying;
	v_epoch_timestamp  character varying;
	v_user_id numeric;
	v_email_id character varying;
	v_status numeric;
	v_message character varying;
	v_peppo_id character varying;
	v_platform_version character varying;
    v_device_name character varying;
    v_platform_type numeric;
    v_mobile_verified numeric;
    v_email_verified numeric;
    v_referal_user_guid character varying;
    v_is_referred numeric;
	v_internal_referral_code character varying;
	v_mobile_no character varying;
	v_user_full_name character varying;
	v_country_id numeric;
	v_state_id  numeric;
	v_city_id   numeric;
	v_country_name text;
	v_state_name text ;
	v_favourite_club character varying;
	v_edition character varying;
	v_profile_picture_url character varying;
	v_old_profile_image_url  character varying;
	v_country_code numeric;
	v_favourite_player_name character varying;
	v_is_app numeric;
	v_is_custom_image numeric;
	v_pass_type numeric;
	v_ext_info jsonb;
	--v_mobile_no numeric;
-- 	v_created_date1 timestamp without time zone;
    v_current_timestamp timestamp without time zone := current_timestamp at time zone 'utc';
BEGIN
 
	select 
    p_input->>'favourite_player_id',
    p_input->>'subscribe_for_email',
    p_input->>'created_date',
	p_input->>'updated_date',
	p_input->>'accept_tnc',
	p_input->>'accept_disclaimer',
	p_input->>'jersey_number',
	p_input->>'country_id',
	p_input->>'waf_user_guid',
    p_input->'user_info'->>'dob',
	p_input->'user_info'->>'city',
	p_input->'user_info'->>'gender',
	p_input->'user_info'->>'first_name',
	p_input->'user_info'->>'last_name',
	p_input->'user_info'->>'social_user_image',
	p_input->'user_info'->>'social_user_name',
	p_input->'user_info'->>'pincode',
	p_input->'user_info'->>'jersey_name',
	p_input->'user_info'->>'membership_code',
	p_input->'user_info'->>'mobile_no'
	INTO
    v_favourite_player_id,
    v_subscribe_for_email,
	v_created_date,
	v_updated_date,
	v_accept_tnc,
	v_accept_disclaimer,
	v_jersey_number,
	v_country_id,
	v_user_guid,
    v_dob,
	v_city,
	v_gender,
	v_first_name,
	v_last_name,
	v_social_user_image,
	v_social_user_name,
	v_pincode,
	v_jersey_name,
	v_membership_code,
	v_mobile_no
	;
	
	if not exists (select 1 from labgt.labgt_web_user where user_guid=v_user_guid) then

        v_status:=0;
		v_message := 'Unable to locate user information.'; 
		
    elsif exists (select 1 from labgt.labgt_web_user where user_guid=v_user_guid
    and mobile_no<>v_mobile_no and v_mobile_no is not null and v_mobile_no<>'') then
    
        v_status:=0;
		v_message := 'Mobile Number already exists with different account';

--     elsif not exists (select 1 from labgt.labgt_web_user where mobile_no=v_mobile_no and v_mobile_no is not null and v_mobile_no<>'') then
    
--         v_status:=0;
-- 		v_message := 'Cannot Update Mobile Number';
    
    else
	
		update labgt.labgt_web_user
		set dob = coalesce(nullif(v_dob,''),dob),
		city=coalesce(nullif(v_city,''),city),
		gender=coalesce(nullif(v_gender,''),gender),
		first_name=coalesce(nullif(v_first_name,''),first_name),
		last_name=coalesce(nullif(v_last_name,''),last_name),
		jersey_number=coalesce(v_jersey_number,jersey_number),
		country_id=coalesce(v_country_id,country_id),
		profile_picture_url=coalesce(nullif(v_social_user_image,''),profile_picture_url),
		social_user_name=coalesce(nullif(v_social_user_name,''),social_user_name),
		pincode=coalesce(nullif(v_pincode,''),pincode),
		favourite_player_id=coalesce(nullif(v_favourite_player_id,''),favourite_player_id),
		jersey_name=coalesce(nullif(v_jersey_name,''),jersey_name),
		subscribe_for_email=coalesce(nullif(v_subscribe_for_email,null),subscribe_for_email),
		membership_code=coalesce(nullif(v_membership_code,''),membership_code),
		created_date=coalesce(nullif(v_created_date,null),created_date),
		updated_date=v_current_timestamp,
		accept_tnc=coalesce(nullif(v_accept_tnc,null),accept_tnc),
		accept_disclaimer=coalesce(nullif(v_accept_disclaimer,null),accept_disclaimer)
		where user_guid = v_user_guid;
		
		select user_id,email_id,email_verified,first_name,last_name,user_full_name,dob,gender,pincode,city,country_id,
				jersey_number,jersey_name,favourite_player_id,token,epoch_timestamp,mobile_verified,referal_user_guid,is_referred,internal_referral_code,mobile_no,edition,favourite_club,
				subscribe_for_email,profile_picture_url,is_custom_image,membership_code,accept_disclaimer,accept_tnc,country_code,
				(case when first_name is not null and last_name is not null then 1 else 2 end),peppo_id,created_date
				from labgt.labgt_web_user
				where user_guid=v_user_guid 
				into v_user_id,v_email_id,v_email_verified,v_first_name,v_last_name,v_user_full_name,v_dob,
				v_gender,v_pincode,v_city,v_country_id,v_jersey_number,v_jersey_name,
				v_favourite_player_id,v_token,v_epoch_timestamp,v_mobile_verified,
				v_referal_user_guid,v_is_referred,v_internal_referral_code,v_mobile_no,v_edition,v_favourite_club,
				v_subscribe_for_email,v_profile_picture_url,v_is_custom_image,v_membership_code,v_accept_disclaimer,v_accept_tnc,v_country_code,v_pass_type,v_peppo_id,v_created_date;
				
		select name into v_country_name from waf_master.waf_countries where country_id=v_country_id;
		
		select em.entity_name into v_favourite_player_name
 						from labgt.labgt_entity_role_map erm 
 						join labgt.labgt_entity_master em using (entity_master_id)
 						where source_object_id = COALESCE(v_favourite_player_id::text,'0');
                        
        insert into labgt.labgt_user_moengage_audit values (nextval('labgt.seq_labgt_web_user_audit_id'),v_user_id,v_user_guid,9,v_current_timestamp,0,null,0,'web',null,'labgt',p_input);

        v_status:=1; 
		v_message := 'Profile updated successfully.';


	
		
        end if;

p_output:= '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						 "user_id": "'|| coalesce(v_user_id,0) ||'" ,
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"peppo_id": "'|| coalesce(v_peppo_id,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,'')||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"mobile_verified": "'|| coalesce(v_mobile_verified,0)||'",
						"email_verified": "'|| coalesce(v_email_verified,0)||'",
						"option_type": "9",
						"updated_date": "'||  coalesce(v_current_timestamp,current_timestamp) ||'",
						"created_date": "'|| coalesce(v_created_date,current_timestamp) ||'",
						"user": {
						  "referal_user_guid": "'||coalesce(v_referal_user_guid,'') ||'",
						  "is_referred": "'|| coalesce(v_is_referred,0)||'",	
						  "internal_referral_code": "'|| coalesce(v_internal_referral_code,'') ||'" ,
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "first_name": "'||coalesce(v_first_name,'') ||'",
						  "last_name": "'||coalesce(v_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_country_name,'')||'",
                          "country_id": "'|| coalesce(v_country_id::varchar,'')||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
						  "subscribe_for_email": "'||coalesce(v_subscribe_for_email::varchar,'false') ||'",
						  "favourite_player_id": "'||coalesce(v_favourite_player_id,'') ||'",
						  "jersey_name": "'|| coalesce(v_jersey_name,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
						  "jersey_number": "'||coalesce(v_jersey_number,0) ||'",
						  "membership_code": "'||coalesce(v_membership_code,'') ||'",
						  "country_code": "'||coalesce(v_country_code,91) ||'",
						  "favourite_player_name":"'|| coalesce(v_favourite_player_name,'')||'",
						  "pincode":"'|| coalesce(v_pincode,'')||'",
						  "accept_disclaimer":"'|| coalesce(v_accept_disclaimer,'false')||'",
						   "accept_tnc":"'|| coalesce(v_accept_tnc,'false')||'"
						},
						"is_first_login": 0,
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'",
						"pass_type":"'|| coalesce(v_pass_type,'0') ||'"
						}
					}';
					
					p_output:=jsonb_set(p_output, '{data,ext_info}',coalesce(v_ext_info,'null'), true);

END;
$$;


--
