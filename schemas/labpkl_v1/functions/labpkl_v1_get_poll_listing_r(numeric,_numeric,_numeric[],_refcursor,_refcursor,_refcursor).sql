-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_get_poll_listing_r(numeric, numeric, numeric[], refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labpkl_v1_get_poll_listing_r(numeric, numeric, numeric[], refcursor, refcursor, refcursor); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_get_poll_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_entityrole_mapid numeric[], p_poll_cur refcursor, p_poll_option refcursor, p_poll_response refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

declare
	
	v_pollidarr numeric[];
	 v_asset_type_id numeric :=6;
	 v_fromrownumber numeric;
   v_torownumber numeric;
    v_sysdate timestamp;
    v_ent_count numeric;
    
begin
	
    	v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
   	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    	
     select array(select poll_id
                  from   (select p.poll_id, rank() over (order by p.updated_date desc) as rno
                          from   labpkl_v1.labpkl_v1_poll p
                          where  p.is_active = 1
                          and    p.is_deleted = 0
                          and    p.is_published = 1
                          /*and    p.start_date <= v_sysdate*/
                          and    p.end_date >= v_sysdate
                          and    exists(select 1
                                        from   labpkl_v1.labpkl_v1_asset_entity_map aem
                                        where  aem.asset_id = p.poll_id
                                        and    aem.asset_type_id = v_asset_type_id
                                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                                          from unnest(p_entityrole_mapid) u(entity_role_mapid))
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count)
                          limit  2
                         ) a
                  where  a.rno between v_fromrownumber and v_torownumber
                 )
                  into   v_pollidarr;
     
     open p_poll_cur for
     	
           select 
          p.*,al.image_file_name,
       (select sum(response_count) 
       from labpkl_v1.labpkl_v1_poll_response
       where poll_id=p.poll_id) as total_response 
          from   labpkl_v1.labpkl_v1_poll p
         inner join labpkl_v1.labpkl_v1_asset_list  al on al.asset_id=p.poll_id and al.asset_type_id=v_asset_type_id
          where  p.poll_id in(select poll_id
                            from   unnest(v_pollidarr) u(poll_id))
                            order by created_date desc;
          
     open p_poll_option for
     	
          select p.*,(select
                  sum(response_count) 
                  from labpkl_v1.labpkl_v1_poll_response
                where poll_id=p.poll_id
                  and 
               response_option_id= p.poll_option_id) as response_count 
             from   labpkl_v1.labpkl_v1_poll_option p
          where  p.poll_id in(select poll_id
                            from   unnest(v_pollidarr) u(poll_id))
                            order by created_date desc;
	
     open p_poll_response for
     	
          select *
          from   labpkl_v1.labpkl_v1_poll_response
          where  poll_id in(select poll_id
                            from   unnest(v_pollidarr) u(poll_id));
end;

 $$;


--
