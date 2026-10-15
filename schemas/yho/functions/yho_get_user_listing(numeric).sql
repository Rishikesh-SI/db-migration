-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_user_listing(numeric)
-- Type: FUNCTION

-- Name: yho_get_user_listing(numeric); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_user_listing(p_role_id numeric, OUT p_userjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
	
     p_schema_prefix varchar(10) := 'yho';
     
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
				 and u.partner_id = ''1''
				 and ur.role_id = coalesce($1, ur.role_id)
				 and u.full_name <> '''' and u.user_name <> '''' and u.display_name <> ''''
				 limit 100
				 ) row'
     into p_userjson
     using p_role_id;
     
end;

$_$;


--
