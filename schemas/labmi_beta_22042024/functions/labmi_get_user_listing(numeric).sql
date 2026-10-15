-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_user_listing(numeric)
-- Type: FUNCTION

-- Name: labmi_get_user_listing(numeric); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_user_listing(p_role_id numeric, OUT p_userjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

declare
	
     v_userjsonarr jsonb[];
     v_userjson jsonb;
     v_json varchar(30000) := '{"users":[';
     v_user_filter varchar(4000):='';
     
begin
	
	p_role_id:= 81;

     if p_role_id is not null then
     v_user_filter = 'and ur.role_id=' || p_role_id || '';
     end if;
     raise notice 'v_user_filter %',v_user_filter;
     execute 'select array(select row_to_json(tab)
     				  from
                           (
                               select u.user_id, u.user_name, u.full_name, u.display_name, u.partner_id,
                               u.email_id, u.profile_picture_url,ur.role_id
                               from   labmi.labmi_user u 
                               join   labmi.labmi_user_role ur
                               on     u.user_id=ur.user_id
                               where  u.is_active = 1
                               and    u.is_deleted = 0
                               and 	  ur.is_active = 1
                               and    ur.is_deleted = 0
							   and (u.partner_id = ''1'' or ur.role_id =81)

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
