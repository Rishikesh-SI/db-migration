-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_user_listing(numeric)
-- Type: FUNCTION

-- Name: labyho_get_user_listing(numeric); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_user_listing(p_role_id numeric, OUT p_userjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

declare
	
    
     v_user_filter varchar(4000):='';
     
begin
     if p_role_id is not null then
     v_user_filter = 'and ur.role_id=' || p_role_id || '';
     end if;
    
     execute 'select (''{"users":''||jsonb_agg(tab)::text||''}'')::jsonb
     				  from
                           (
                               select u.user_id, u.user_name, 
							   u.full_name, u.full_name display_name, u.partner_id,
                               u.email_id, u.profile_picture_url,ur.role_id
                               from   labyho.labyho_user u 
                               join   labyho.labyho_user_role ur
                               on     u.user_id=ur.user_id
                               where  u.is_active = 1
                               and    u.is_deleted = 0
                               and 	  ur.is_active = 1
                               and    ur.is_deleted = 0
                               ' || v_user_filter || '
                               
                           ) as tab
                          '
     into p_userjson;
     
     
    
     
end;

 
$$;


--
