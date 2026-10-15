-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_get_album_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labman_get_album_detail(numeric, numeric); Type: FUNCTION; Schema: labman; Owner: -
--

CREATE FUNCTION labman.labman_get_album_detail(p_albumid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_albumjson jsonb, OUT p_imagejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     v_versionnumber numeric;
     v_isdeletedquery text := ' ';
     v_asset_type_id numeric := 2;
     v_publishedversionnumber numeric := 0;
     v_imagejsonarr jsonb[];
     v_imagejson jsonb;
     v_json text := '{"items":[';
     v_image_count numeric;
     
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  labman.labman_album
          where  	  album_id = p_albumid;
          
          v_isdeletedquery := ' and aam.is_deleted = 0 ';
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_albumjson
     from   	  labman.labman_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = p_albumid
	and    	  version_number = v_versionnumber;
     
     select published_version_number
     into   v_publishedversionnumber
     from   labman.labman_album
     where  album_id = p_albumid;
     
     if v_versionnumber = v_publishedversionnumber then
     
     /*execute 'select array(
     select row_to_json(row) jsonrow
     from
     (
     select asset_order as order_number, image_id, image_file_name, image_path ,is_cover, em as entitydata, i.image_caption, i.image_desc
     from   labman.labman_album_asset_map aam
     join   labman.labman_image i
     on     i.image_id = aam.asset_id
     and    aam.asset_type_id = 3
	left join   labman.labman_asset_entity_map aem
         on aem.asset_id = i.image_id
         and aem.asset_type_id = 3
	left join  (select 1 as priority, erm.entity_role_map_id, emi.entity_name,emi.entity_master_id
                 from   labman.labman_entity_master emi
			join   labman.labman_entity_role_map erm
               on     erm.entity_master_id = emi.entity_master_id) as em(priority, entity_role_map_id, entity_name,entity_master_id)
               on         aem.entity_role_map_id = em.entity_role_map_id
     where  album_id = '|| p_albumid
         ||v_isdeletedquery||
         'order by order_number desc) as row)'
         into v_imagejsonarr;*/
         
        execute 'select array(
     select row_to_json(row) jsonrow
     from
     (
     select asset_order as order_number, image_id, image_file_name,i.title_alias as title, image_path ,is_cover, array_to_json(array_agg(em)) entitydata,
         i.image_caption, i.image_desc,
		aam.is_active, aam.is_deleted is_delete,
		i.copyright_text, aam.phototypeid
     from   labman.labman_album_asset_map aam
     join   labman.labman_image i
     on     i.image_id = aam.asset_id
     and    aam.asset_type_id = 3
	left join   labman.labman_asset_entity_map aem
         on aem.asset_id = i.image_id
         and aem.asset_type_id = 3
	left join  (select 1 as priority, erm.entity_role_map_id, emi.entity_name,emi.entity_master_id
                 from   labman.labman_entity_master emi
			join   labman.labman_entity_role_map erm
               on     erm.entity_master_id = emi.entity_master_id
     		join  labman.labman_asset_entity_map aem1
                on    aem1.entity_role_map_id = erm.entity_role_map_id
                 join labman.labman_album_asset_map aam1
                 on  aam1.asset_id = aem1.asset_id
                 and  aam1.asset_type_id = aem1.asset_type_id
                 and aam1.album_id = '||p_albumid||') as em-- (priority, entity_role_map_id, entity_name,entity_master_id)
               on         aem.entity_role_map_id = em.entity_role_map_id
     where  album_id = '|| p_albumid
         ||v_isdeletedquery||
         'group by asset_order, image_id, image_file_name, image_path ,is_cover, i.image_caption, i.image_desc, aam.is_active, aam.is_deleted, i.copyright_text, aam.phototypeid
         order by order_number desc) as row)'
         into v_imagejsonarr;
     
	else
         
         execute 'with imagedata(t_asset_data, t_json)
        as(select asset_data, (asset_data->''data''->''images'')::json
        from   labman.labman_asset_draft as ad
        where  asset_type_id = 2
       and    asset_id = '|| p_albumid ||
     ' and    version_number = '||v_versionnumber||')
    select array(select row_to_json(row) jsonrow
             from (select asset_order::numeric as order_number, 
         			jd.image_id::numeric, image_file_name, image_path, is_cover::numeric, 
         			jd.image_alt image_caption,
         			jd.image_desc,
					jd.phototypeid,
					jd.is_active::numeric, 
					jd.is_deleted::numeric is_delete,
         			jd.title, 
                   		 (select array_to_json(array_agg(a))
                           from   (select erm.priority::varchar, erm.entity_role_map_id::varchar, em.entity_master_id::varchar, em.entity_name
                                   from   labman.labman_asset_entity_map aem
                                   join   labman.labman_entity_role_map erm
                                   on     erm.entity_role_map_id = aem.entity_role_map_id
                                   join   labman.labman_entity_master em
                                   on     em.entity_master_id = erm.entity_master_id
                                   where  aem.asset_id = jd.image_id::numeric
                                   and    aem.asset_type_id = 3
                                  )a
                          )entitydata, -- i.copyright_text, 
         				jd.image_copyright  copyright_text  
                   from   (select obj->''data''->>''order_number'' asset_order,
         					obj->''data''->>''image_id'' image_id,
         					obj->''data''->>''is_cover'' is_cover
         					, t_asset_data, obj->''data''->>''is_active'' is_active,
         					obj->''data''->>''is_delete'' is_deleted,
         					obj->''data''->>''title'' title,
         					obj->''data''->>''image_copyright'' image_copyright,
                            obj->''data''->>''image_desc'' image_desc,
                           obj->''data''->>''image_alt'' image_alt,
                          obj->''data''->>''order_number'' order_number,
						  obj->''data''->>''phototypeid'' phototypeid
                           from   imagedata id, json_array_elements(id.t_json#>''{}'') obj) jd
                           join   labman.labman_image i
                           on     i.image_id = jd.image_id::numeric) row)'
into   v_imagejsonarr;
         
     end if;
     foreach v_imagejson in array v_imagejsonarr
     loop
     	v_json := v_json||v_imagejson||',';
     end loop;
     
         select count(1)
    	into   v_image_count
    	from   unnest(v_imagejsonarr) image_id;
     
     if v_image_count > 0 then
     	v_json := substring(v_json,1,(length(v_json)-1));
     else
     	v_json := substring(v_json,1,(length(v_json)));
     end if;
     
     v_json      := v_json||']}';
     
     p_imagejson := v_json::jsonb;
     
         p_result := 1;
         
-- exception
	-- when others then
    	-- 	p_result := -1;
	-- 	p_imagejson := '{"items":[]}';
end;

 

$$;


--
