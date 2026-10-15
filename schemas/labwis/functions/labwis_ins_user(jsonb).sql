-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_ins_user(jsonb)
-- Type: FUNCTION

-- Name: labwis_ins_user(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_ins_user(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_client_id numeric;
    v_email_id character varying;
    v_upper_email_id character varying;
    v_web_user_id numeric;
    v_user_guid character varying;
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
    v_is_registered  numeric;
    v_user_id numeric;
    v_is_login numeric;
   v_first_name character varying;
   v_last_name character varying;
   v_ext_info jsonb;
   v_subscribe_for_email boolean;
   
   v_mobile_verified numeric;
   v_email_verified numeric;   
   v_accept_tnc boolean;
   v_source_user_id numeric;
   v_accept_disclaimer boolean;
   v_user_registered timestamp without time zone;
   begin

 v_current_timestamp := current_timestamp at time zone 'utc';
 

    select 
    	   p_user_json->'data'->>'email_id',
       	   p_user_json->'data'->'user'->>'mobile_no',
		   p_user_json->'data'->'user'->>'first_name',
		   p_user_json->'data'->'user'->>'last_name',
		   p_user_json->'data'->'user'->>'subscribe_for_email',
		   p_user_json->'data'->'user'->'ext_info'->>'wp_user_id',
		   p_user_json->'data'->'user'->'ext_info'->>'user_registered'
           
    into
           v_email_id,
           v_mobile_no,
			v_first_name,
			v_last_name,
			v_subscribe_for_email,
			v_source_user_id,
			v_user_registered
           ;
v_user_id := nextval('labwis.seq_labwis_user_id');
v_accept_tnc := 'true';
v_accept_disclaimer := 'true'	;	   
v_user_guid := uuid_generate_v4();
v_client_id := 5;

if not exists (select 1 from labwis.labwis_web_user where email_id = v_email_id) then
		   
    insert into labwis.labwis_web_user(user_id,client_id,email_id,upper_email_id,user_guid,is_registered,is_active,is_deleted,created_by,updated_by,created_date,updated_date,is_verified,country_code,is_login,first_name,last_name,subscribe_for_email,accept_tnc,accept_disclaimer,ref_id)	
    select v_user_id,v_client_id,v_email_id,v_email_id,v_user_guid,1,1,0,1,1,v_user_registered,v_user_registered,1,null,v_is_login,v_first_name,v_last_name,v_subscribe_for_email,v_accept_tnc,v_accept_disclaimer,v_source_user_id;

end if;
p_ures_json = '{
					  "data": {
					  "email_id": "'||coalesce(v_email_id,'')||'",
					  "waf_user_guid": "'||coalesce(v_user_guid,'')||'",
					  "user" : {
							
							"mobile_no": "'||coalesce(v_mobile_no,'')||'",
							"first_name": "'||coalesce(v_first_name,'')||'",
							"last_name": "'|| coalesce(v_last_name,'') ||'",
							"subscribe_for_email":"'|| coalesce(v_subscribe_for_email,'false') ||'",
							"ext_info":{
								"wp_user_id":"'|| coalesce(v_source_user_id,0) ||'",
								"user_registered":"'|| coalesce(v_user_registered,current_timestamp) ||'"
							}
					   }
					 }
				}';
				

end;
$$;


--
