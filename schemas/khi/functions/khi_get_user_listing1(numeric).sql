-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_get_user_listing1(numeric)
-- Type: FUNCTION

-- Name: khi_get_user_listing1(numeric); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_get_user_listing1(p_role_id numeric, OUT p_userjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_userjsonarr jsonb[];
     v_userjson jsonb;
     v_json text := '{"users":[';
     v_user_filter VARCHAR(4000):='';
     v_user_count numeric;
     
begin
     IF p_role_id IS NOT NULL THEN
     v_user_filter = 'and ur.role_id=' || p_role_id || '';
     END IF;
     
     execute 'select array(select row_to_json(tab)
     				  from
                           (
                               select u.user_id, u.user_name, u.full_name, u.display_name, u.partner_id,
                               u.email_id, u.profile_picture_url,ur.role_id
                               from   khi.khi_user U 
                               join   khi.khi_user_role ur
                               on     u.user_id=ur.user_id
                               where  u.is_active = 1
                               and    u.is_deleted = 0
                               and 	  ur.is_active = 1
                               and    ur.is_deleted = 0
                               and    u.partner_id = ''1'''
                               || v_user_filter ||
                               '
                           ) as tab
                          )'
     into v_userjsonarr;
     
     select count(1)
     into   v_user_count
     from   unnest(v_userjsonarr) user_id;

     foreach v_userjson in array v_userjsonarr
     loop
     	v_json := v_json||v_userjson||',';
     end loop;
                               
                               
     if v_user_count > 0 then
     	v_json := substring(v_json,1,(length(v_json)-1));
     else
     	v_json := substring(v_json,1,(length(v_json)));
     end if;
     
     v_json        := v_json||']}';
     p_userjson := v_json::jsonb;
     
end;

 $$;


--
