-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_get_latest_feeds_data_r(numeric, numeric, numeric, numeric[], numeric[])
-- Type: FUNCTION

-- Name: labisp_get_latest_feeds_data_r(numeric, numeric, numeric, numeric[], numeric[]); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_get_latest_feeds_data_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_asset_type_id numeric[], p_entityrole_mapid numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_sysdate timestamp;
    v_ent_count numeric ;
    v_fromrownumber  numeric ;
    v_torownumber  numeric ;
	v_array 	   numeric[] ;
begin
	
	v_sysdate := current_timestamp at time zone 'utc';
	
	if p_page1_size is null then
		v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		v_torownumber := (p_pagenumber * p_itemnumber);
	else
		if (p_pagenumber = 1) then
			v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		else 
          	v_fromrownumber := p_page1_size + ((((p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
		end if;
		v_torownumber := p_page1_size + ((p_pagenumber-1) * p_itemnumber);
	end if;
	
	 select array(SELECT erm.entity_role_map_id
                  FROM   labisp.labisp_entity_role_maP ERM
                  JOIN   labisp.labisp_entity_master EM
                  on     em.entity_master_id = erm.entity_master_id
                  join   labisp.labisp_entity_category ec
                  on     ec.entity_role_id = erm.entity_role_id
                  where  ERM.entity_role_id in (SELECT entity_role_id
                                                FROM   labisp.labisp_entity_category c1
                                                JOIN   UNNEST(Array['Language']) M(CATEGORY_NAME)
                                                ON     m.category_name = c1.category_name
                                                WHERE  C1.IS_active = 1
                                                and    c1.is_deleted = 0
                                                and    c1.is_published = 1
                                               )
                  and erm.IS_active = 1
                 )
	into v_array;
	
	select count(1)
    into   v_ent_count
    from   (select entityid from unnest(p_entityrole_mapid) U(entityid)) a;
	
	
    select '{"item" :' || array_to_json(array_agg(ab)) || '}' , max(ab.asset_count)
    into p_assetjson, p_assetcount
    from 
    (
	select  count(1) over() asset_count, row_number() over(order by  sal.published_date desc) srno,
        	sal.asset_id as story_id, sal.title_alias story_url, sal.asset_title title,sal.asset_title as title_regional, 
    		sal.short_desc, sal.image_path ||''||sal.image_file_name story_thumnail, 
        	sal.image_path ||''||sal.image_file_name story_thumnail_full,
    		sal.asset_type_id, sal.updated_date as updated_time , sal.published_date as published_time,
            (select array_to_json(array_agg(a))
             from   (select aem.priority, erm.entity_role_map_id, emi.entity_name, aem.is_linkable, 
                     		aem.is_visible, emi.canonical_url,
                     		(case when erm.entity_role_map_id = lm.entity_role_mapid then 1 else 0 end) is_language
                     from   labisp.labisp_entity_master emi
                     join   labisp.labisp_entity_role_map erm
                     on     erm.entity_master_id = emi.entity_master_id
                     join   labisp.labisp_asset_entity_map aem
                     on     aem.entity_role_map_id = erm.entity_role_map_id
                     and    aem.asset_id =  sal.asset_id
                     and    aem.asset_type_id = sal.asset_type_id  
                     left join (select entity_role_mapid from unnest(v_array) U(entity_role_mapid)) lm
                     on (erm.entity_role_map_id = lm.entity_role_mapid)
                    )a
            ) as entitydata
	from   labisp.labisp_asset_list sal  	
	where  sal.published_date <= v_sysdate	
    and sal.asset_type_id in (select asset_type_id
        						from unnest(case when p_asset_type_id is null 
                                            	 then (array(select sal.asset_type_id))
                                            	 else p_asset_type_id 
                                            end) U(asset_type_id)
                             )
	and sal.is_published = 1
    and sal.is_active = 1 
    and sal.is_deleted = 0 
    and sal.asset_type_id in (1,2,4)
	and    exists(select 1
					from   labisp.labisp_asset_entity_map aem
					where  aem.asset_id = sal.asset_id
					and    aem.asset_type_id = sal.asset_type_id
					and    aem.entity_role_map_id in (select entity_role_mapid from unnest(p_entityrole_mapid) U(entity_role_mapid))
					group by aem.asset_id, aem.asset_type_id
					having count(1) = v_ent_count)
    )ab
    where ab.srno between v_fromrownumber and v_torownumber ;
	
    -- raise notice 'json : % ' , p_assetjson;
   
end;
$$;


--
