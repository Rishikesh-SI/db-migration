-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_get_deleted_users_data_r(jsonb)
-- Type: FUNCTION

-- Name: labfih_get_deleted_users_data_r(jsonb); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_get_deleted_users_data_r(p_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
	v_interval character varying;
	v_verification_key character varying;
	v_user_id numeric;
	p_opttype numeric:=11;
	v_platform_type numeric;
	v_device_name character varying;
	v_platform_version numeric;
	v_status numeric;
	v_message character varying;
	v_captcha character varying;
	v_first_name character varying;
	v_last_name character varying;
	v_user_full_name character varying;
	v_is_app numeric;
	v_ipaddress character varying;
	v_reset_key character varying;
	v_subject character varying;
	v_user_guid character varying;
begin
/*
{
   "author_guid":"da51ef77-d1f8-4526-8942-8e3512b3cc6c"
}
*/

    select p_json ->'data'->>'interval',
           p_json ->'data'->>'is_app',
           p_json ->'data'->>'ipaddress',
           p_json ->'data'->>'platform_version',
           p_json ->'data'->>'platform_type', 
		   p_json ->'data'->>'reset_key',
		   p_json ->'data'->>'device_name',
		   p_json ->'data'->>'captcha',
		   p_json ->'data'->>'user_guid'
   into
  		  v_interval,
		  v_is_app,
		  v_ipaddress,
		  v_platform_version,
		  v_platform_type,
		  v_verification_key,
		  v_device_name,
		  v_captcha,
		  v_user_guid;

if v_user_guid is not null then
 
select '{"items" :'||json_agg(row_alias)||'}'
	from (
 	select email_id,user_id,dob,gender,ipaddress,client_id,last_name,social_id,user_guid,first_name,COALESCE(user_full_name,first_name) as user_full_name,
		membership_code,social_user_name,profile_picture_url
	from labfih.labfih_web_user
	where updated_date::date <= current_date - (v_interval || 'days')::interval
	and is_deleted=1 
	and user_guid = v_user_guid
	limit 10)row_alias
	into p_ures_json;

else

select '{"items" :'||json_agg(row_alias)||'}'
	from (
 	select email_id,user_id,dob,gender,ipaddress,client_id,last_name,social_id,user_guid,first_name,COALESCE(user_full_name,first_name) as user_full_name,
		membership_code,social_user_name,profile_picture_url
	from labfih.labfih_web_user
	where updated_date::date <= current_date - (v_interval || 'days')::interval
	and is_deleted=1 
	limit 10)row_alias
	into p_ures_json;


end if;

	raise notice '%',v_interval;
	
		   p_result := 1  ;

/*
        	insert into labfih.labfih_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app,platform_type,device_name,platform_version)
            select nextval('labfih.seq_labfih_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0),v_platform_type,v_device_name,v_platform_version ;

*/

end;
$$;


--
