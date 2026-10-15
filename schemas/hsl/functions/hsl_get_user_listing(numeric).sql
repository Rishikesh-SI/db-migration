-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_get_user_listing(numeric)
-- Type: FUNCTION

-- Name: hsl_get_user_listing(numeric); Type: FUNCTION; Schema: hsl; Owner: -
--

CREATE FUNCTION hsl.hsl_get_user_listing(p_role_id numeric, OUT p_userjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_userjsonarr jsonb[];
     v_userjson jsonb;
     v_json varchar(30000) := '{"users":[';
     v_user_filter VARCHAR(4000):='';
     
begin
     IF p_role_id IS NOT NULL THEN
     v_user_filter = 'and ur.role_id=' || p_role_id || '';
     END IF;
     
     execute 'select array(select row_to_json(tab)
     				  from
                           (
                               select u.user_id, u.user_name, u.full_name, u.display_name, u.partner_id,
                               u.email_id, u.profile_picture_url,ur.role_id
                               from   hsl.hsl_user U 
                               join   hsl.hsl_user_role ur
                               on     u.user_id=ur.user_id
                               where  u.is_active = 1
                               and    u.is_deleted = 0
                               and 	  ur.is_active = 1
                               and    ur.is_deleted = 0
                               ' || v_user_filter || '
                           ) as tab
                          )'
     into v_userjsonarr;
     
     foreach v_userjson in array v_userjsonarr
     loop
     	v_json := v_json||v_userjson||',';
     end loop;
     
     v_json := substring(v_json,1,(length(v_json)-1))||']}';
     
     p_userjson := v_json::jsonb;
     
end;

 $$;


--
