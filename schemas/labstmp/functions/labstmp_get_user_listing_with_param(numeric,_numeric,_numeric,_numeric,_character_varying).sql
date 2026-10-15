-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_get_user_listing_with_param(numeric, numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: labstmp_get_user_listing_with_param(numeric, numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: labstmp; Owner: -
--

CREATE FUNCTION labstmp.labstmp_get_user_listing_with_param(p_status numeric, p_roleid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchuser character varying, OUT p_usercount numeric, OUT p_userjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$ 

declare
	
     v_fromrownumber numeric;
     v_torownumber numeric;
     v_searchuser varchar(50);
     v_searchquery varchar(100) := ' ';
     v_userjsonarr jsonb[];
     v_userjson jsonb;
     v_json varchar(30000) := '{"data":[';
     v_usercount numeric := 0;
     v_user_count numeric;
     
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
     if p_searchuser is not null then
     	v_searchuser := upper(p_searchuser);
     	v_searchquery := ' and upper(user_name) like ''%''||'||'$3'||'||''%'' ';
     end if;
     
     execute 'select count(1)
     	    from 	 (select u.user_id, user_name, full_name, display_name, partner_id, email_id, profile_picture_url,
              			    (select array_to_json(array_agg(a))
                             	from   (select r.role_id, r.role_name
                              	   from   labstmp.labstmp_user_role ur
                                      join   labstmp.labstmp_role r
                                      on     r.role_id  = ur.role_id
                                      where  ur.user_id = u.user_id
                                      and    ur.role_id  = case coalesce($2,2) when 2 then ur.role_id else $2 end
                                      )a
						) user_role, u.is_active, u.created_date, u.updated_date,
                               row_number() over (order by u.user_id) slno
				  from   labstmp.labstmp_user u
                      where  u.is_active = case coalesce($1,2) when 2 then u.is_active else $1 end'
                      ||v_searchquery||'
                      ) data'
	into    v_usercount
     using   p_status, p_roleid, v_searchuser;
     
     p_usercount := v_usercount;
     
     execute 'select array(select row_to_json(tab)
     				  from
                           (
                               select *
                               from (
                               select u.user_id, user_name, full_name, display_name, partner_id, email_id, profile_picture_url,
                               	   (select array_to_json(array_agg(a))
                               	    from(select r.role_id, r.role_name
                               		    from   labstmp.labstmp_user_role ur
                               		    join   labstmp.labstmp_role r
                               		    on     r.role_id  = ur.role_id
                               		    where  ur.user_id = u.user_id
                               			and    ur.role_id  = case coalesce($2,2) when 2 then ur.role_id else $2 end
                           			   )a
                           		   ) user_role, u.is_active, u.created_date, u.updated_date as modified_date,
                               	    row_number() over (order by u.user_id) slno
                               from   labstmp.labstmp_user u
                               where  u.is_active = case coalesce($1,2) when 2 then u.is_active else $1 end'
                               ||v_searchquery||'
                               ) data
                               where slno between '||'$4'||' and '||'$5'||'
                           ) as tab
                          )'
     into v_userjsonarr
	using p_status, p_roleid, v_searchuser, v_fromrownumber, v_torownumber;
	
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
     
	v_json     := v_json||']}';
     p_userjson := v_json::jsonb;
     
end;

 $_$;


--
