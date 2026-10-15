-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_user_listing()
-- Type: FUNCTION

-- Name: labuww_get_user_listing(); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_user_listing(OUT p_userjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	
     v_userjsonarr jsonb[];
     v_userjson jsonb;
     v_json text := '{"data":[';
     
     
begin
	
     execute 'select array(select row_to_json(tab)
     				  from
                           (
                               select user_id, user_name, full_name, display_name, partner_id, email_id, profile_picture_url,
                               	   (select array_to_json(array_agg(a))
                               	    from(select r.role_id, r.role_name
                               		    from   labuww.labuww_user_role ur
                               		    join   labuww.labuww_role r
                               		    on     r.role_id = ur.role_id
                               		    where  ur.user_id = u.user_id)a)user_role, is_active, created_date, updated_date as modified_date
                               from   labuww.labuww_user u
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
