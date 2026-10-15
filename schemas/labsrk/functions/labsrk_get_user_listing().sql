-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_get_user_listing()
-- Type: FUNCTION

-- Name: labsrk_get_user_listing(); Type: FUNCTION; Schema: labsrk; Owner: -
--

CREATE FUNCTION labsrk.labsrk_get_user_listing(OUT p_userjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_userjsonarr jsonb[];
     v_userjson jsonb;
     v_json varchar(30000) := '{"data":[';
     
     
begin
	
     execute 'select array(select row_to_json(tab)
     				  from
                           (
                               select user_id, user_name, full_name, display_name, partner_id, email_id, profile_picture_url,
                               	   (select array_to_json(array_agg(a))
                               	    from(select r.role_id, r.role_name
                               		    from   labsrk.labsrk_user_role ur
                               		    join   labsrk.labsrk_role r
                               		    on     r.role_id = ur.role_id
                               		    where  ur.user_id = u.user_id)a)user_role, is_active, created_date, updated_date as modified_date
                               from   labsrk.labsrk_user u
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
