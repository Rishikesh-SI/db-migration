-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_user_listing()
-- Type: FUNCTION

-- Name: waf_get_user_listing(); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_user_listing(OUT p_userjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
     v_userjsonarr jsonb[];
     v_userjson jsonb;
     v_json varchar(4000) := '{"users":[';
     
     
begin
	
     execute 'select array(select row_to_json(tab)
     				  from
                           (
                               select user_id, user_name, full_name, display_name, partner_id, email_id, profile_picture_url
                               from   waf_master.waf_user
                               where  is_active = 1
                               and    is_deleted = 0
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
