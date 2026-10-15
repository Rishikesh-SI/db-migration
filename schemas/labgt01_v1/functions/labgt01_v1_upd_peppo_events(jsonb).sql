-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_upd_peppo_events(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_upd_peppo_events(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_upd_peppo_events(p_json jsonb, OUT v_json jsonb, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_pgnum numeric;
v_inum numeric;
v_method character varying;
v_startdate timestamp;
v_enddate timestamp;
v_fromrownumber numeric;
v_torownumber numeric;
v_current_timestamp timestamp without time zone:= current_timestamp at time zone 'utc';

begin
/*Input Json : {
  "pgnum": 1,
  "inum": 10,
  "method": "UPDATE",
"start_date": "2024-10-02",
"end_date": "2024-10-16"
}
*/
-- raise notice 'v_current_timestamp:%',v_current_timestamp;
select p_json->>'pgnum',
       p_json->>'inum',
	   p_json->>'method',
	   p_json->>'start_date',
	   p_json->>'end_date'
INTO
		v_pgnum,
		v_inum,
		v_method,
		v_startdate,
		v_enddate;		
		
		v_fromrownumber := (v_pgnum * v_inum - (v_inum - 1));
        v_torownumber   := (v_pgnum * v_inum);
	if (v_method='UPDATE') THEN
				
				
	--User Update profile response whose first update occurred on the specified date
	select jsonb_agg(jsonb_build_object('data',jsonb_build_object ('user_guid',user_guid,
                                                                   'waf_user_guid',user_guid,
                                                                   'token',token,
                                                                   'epoch_timestamp',epoch_timestamp,
                                                                   'user_id',user_id,
                                                                   'email_id',email_id,
                                                                   'status', 1,
                                                                   'message', 'Profile updated successfully.',
                                                                   'peppo_id', peppo_id,
                                                                   'mobile_verified', mobile_verified,
                                                                   'email_verified', email_verified,
                                                                   'option_type', 9,
                                                                   'updated_date', TO_CHAR(v_current_timestamp, 'YYYY-MM-DD HH24:MI:SS.US'),
                                                                   'created_date', TO_CHAR(v_current_timestamp, 'YYYY-MM-DD HH24:MI:SS.US'),
                                                                   'user',jsonb_build_object('referal_user_guid',referal_user_guid,
                                                                                             'is_referred',is_referred,
                                                                                             'internal_referral_code',internal_referral_code,
                                                                                             'mobile_no',mobile_no,
                                                                                             'name',user_full_name,
                                                                                             'first_name',first_name,
                                                                                             'last_name',last_name,
                                                                                             'social_user_name',social_user_name,
                                                                                             'dob',dob,
                                                                                             'gender',gender,
                                                                                             'city',city,
                                                                                             'state_id',state_id,
                                                                                             'country_id',country_id,
                                                                                             'favourite_club',favourite_club,
                                                                                             'edition',edition,
                                                                                             'subscribe_for_email',subscribe_for_email,
                                                                                             'favourite_player_id',favourite_player_id,
                                                                                             'jersey_name',jersey_name,
                                                                                             'social_user_image',profile_picture_url,
                                                                                             'jersey_number',jersey_number,
                                                                                             'membership_code',membership_code,
                                                                                             'country_code',country_code,
                                                                                             'favourite_player_name',(select em.entity_name
                                                                                                                        from labgt01_v1.labgt01_v1_entity_role_map erm 
                                                                                                                        join labgt01_v1.labgt01_v1_entity_master em using (entity_master_id)
                                                                                                                        where source_object_id = COALESCE(favourite_player_id::text,'0')),
                                                                                             'pincode',pincode,
                                                                                             'accept_disclaimer',accept_disclaimer,
                                                                                             'accept_tnc',accept_tnc),
                                                                    'is_first_login',0,
                                                                    'is_custom_image',is_custom_image,
                                                                    'pass_type',(case when first_name is not null and last_name is not null then 1 else 2 end),
                                                                    'old_profile_img_url',profile_picture_url)))
				from labgt01_v1.labgt01_v1_web_user
				where user_guid in (select user_guid from
					(select a.user_guid,created_date,row_number() over (order by created_date) as rno from (select wua.user_guid,row_number() over (partition by wua.user_guid order by audit_date) as rn,(audit_date+'5.5hours'::interval)::date as audit_date,wu.created_date from labgt01_v1.labgt01_v1_web_user_audit wua
					join labgt01_v1.labgt01_v1_web_user wu on wu.user_guid=wua.user_guid 
					where option_type=9)a where a.audit_date between v_startdate and v_enddate and a.rn=1)b
						where b.rno between v_fromrownumber and v_torownumber)
						into v_json;  
			
                   
		select count(1) into p_count from (select wua.user_guid,row_number() over (partition by wua.user_guid order by audit_date) as rn,(audit_date+'5.5hours'::interval)::date as audit_date,wu.created_date from labgt01_v1.labgt01_v1_web_user_audit wua
		join labgt01_v1.labgt01_v1_web_user wu on wu.user_guid=wua.user_guid 
		where option_type=9)a where a.audit_date between v_startdate and v_enddate and a.rn=1;
		

	elsif (v_method='REFERRAL') THEN
	--User Update profile response whose first update occurred with referal code on the specified date
	select jsonb_agg(jsonb_build_object('data',jsonb_build_object ('user_guid',user_guid,
                                                                   'waf_user_guid',user_guid,
                                                                   'token',token,
                                                                   'epoch_timestamp',epoch_timestamp,
                                                                   'user_id',user_id,
                                                                   'email_id',email_id,
                                                                   'status', 1,
                                                                   'message', 'Profile updated successfully.',
                                                                   'peppo_id', peppo_id,
                                                                   'mobile_verified', mobile_verified,
                                                                   'email_verified', email_verified,
                                                                   'option_type', 9,
                                                                   'updated_date', TO_CHAR(v_current_timestamp, 'YYYY-MM-DD HH24:MI:SS.US'),
                                                                   'created_date', TO_CHAR(v_current_timestamp, 'YYYY-MM-DD HH24:MI:SS.US'),
                                                                   'user',jsonb_build_object('referal_user_guid',referal_user_guid,
                                                                                             'is_referred',is_referred,
                                                                                             'internal_referral_code',internal_referral_code,
                                                                                             'mobile_no',mobile_no,
                                                                                             'name',user_full_name,
                                                                                             'first_name',first_name,
                                                                                             'last_name',last_name,
                                                                                             'social_user_name',social_user_name,
                                                                                             'dob',dob,
                                                                                             'gender',gender,
                                                                                             'city',city,
                                                                                             'state_id',state_id,
                                                                                             'country_id',country_id,
                                                                                             'favourite_club',favourite_club,
                                                                                             'edition',edition,
                                                                                             'subscribe_for_email',subscribe_for_email,
                                                                                             'favourite_player_id',favourite_player_id,
                                                                                             'jersey_name',jersey_name,
                                                                                             'social_user_image',profile_picture_url,
                                                                                             'jersey_number',jersey_number,
                                                                                             'membership_code',membership_code,
                                                                                             'country_code',country_code,
                                                                                             'favourite_player_name',(select em.entity_name
                                                                                                                        from labgt01_v1.labgt01_v1_entity_role_map erm 
                                                                                                                        join labgt01_v1.labgt01_v1_entity_master em using (entity_master_id)
                                                                                                                        where source_object_id = COALESCE(favourite_player_id::text,'0')),
                                                                                             'pincode',pincode,
                                                                                             'accept_disclaimer',accept_disclaimer,
                                                                                             'accept_tnc',accept_tnc),
                                                                    'is_first_login',0,
                                                                    'is_custom_image',is_custom_image,
                                                                    'pass_type',(case when first_name is not null and last_name is not null then 1 else 2 end),
                                                                    'old_profile_img_url',profile_picture_url)))
				from labgt01_v1.labgt01_v1_web_user
				where user_guid in (select user_guid from
					(select a.user_guid,created_date,row_number() over (order by created_date) as rno from (select wua.user_guid,row_number() over (partition by wua.user_guid order by audit_date) as rn,(audit_date+'5.5hours'::interval)::date as audit_date,wu.created_date from labgt01_v1.labgt01_v1_web_user_audit wua
					join labgt01_v1.labgt01_v1_web_user wu on wu.user_guid=wua.user_guid 
					where option_type=9 and referal_user_guid is not null)a where a.audit_date between v_startdate and v_enddate and a.rn=1)b
						where b.rno between v_fromrownumber and v_torownumber) into v_json;
						
			select count(1) into p_count from (select wua.user_guid,row_number() over (partition by wua.user_guid order by audit_date) as rn,(audit_date+'5.5hours'::interval)::date as audit_date,wu.created_date from labgt01_v1.labgt01_v1_web_user_audit wua
			join labgt01_v1.labgt01_v1_web_user wu on wu.user_guid=wua.user_guid 
			where option_type=9 and referal_user_guid is not null)a where a.audit_date between v_startdate and v_enddate and a.rn=1;
   
   
   
   
   
	else

		v_json:=null;
		p_count:=0;
		
	end if;

end;
$$;


--
