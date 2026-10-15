-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_user_detail(character varying, numeric, character varying)
-- Type: FUNCTION

-- Name: _get_user_detail(character varying, numeric, character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_user_detail(p_schema_prefix character varying, p_user_id numeric, p_user_name character varying, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
	v_user_id numeric := coalesce(p_user_id,0);
	v_user_name character varying(50) := coalesce(lower(p_user_name),'0');
     
begin
     execute 'select (''{"users":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
			from (select user_id, user_name, full_name, display_name, partner_id,
			             email_id, profile_picture_url, created_date, updated_date,
						 created_by, updated_by, is_active, is_deleted, is_published,
						 user_guid, user_pwd, reset_key, key_expiry, failed_attempts, 30 as pwd_exp,
						 unlock_date, bio, image_id, image_name,coalesce(is_password_changed,0) as is_password_changed
				 from '||p_schema_prefix||'.'||p_schema_prefix||'_user
				 where user_id = case '||v_user_id||' when 0 then user_id else '||v_user_id||' end
				 and lower(user_name) = case '''||v_user_name||''' when ''0'' then lower(user_name) else '''||v_user_name||''' end) row'
     into p_user_json;
	 
     
exception
	when others then
     	p_user_json := ('{"users":[]}')::jsonb;
	
end;

$$;


--
