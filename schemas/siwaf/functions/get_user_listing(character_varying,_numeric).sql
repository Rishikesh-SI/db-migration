-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_user_listing(character varying, numeric)
-- Type: FUNCTION

-- Name: _get_user_listing(character varying, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_user_listing(p_schema_prefix character varying, p_role_id numeric, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	
     execute 'select (''{"users":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
			from (select u.user_id, u.user_name, u.full_name, u.display_name, u.partner_id, u.email_id, u.profile_picture_url, ur.role_id
				 from '||p_schema_prefix||'.'||p_schema_prefix||'_user u
				 join '||p_schema_prefix||'.'||p_schema_prefix||'_user_role ur
				 on u.user_id = ur.user_id
				 where u.is_active = 1
				 and u.is_deleted = 0
				 and ur.is_active = 1
				 and ur.is_deleted = 0
				 and ur.role_id = '||p_role_id||' or coalesce('||p_role_id||', 0) = 0) row'
     into p_user_json;
     
exception
	when others then
		p_user_json := ('{"users":[]}')::jsonb;
	
end;

$$;


--
