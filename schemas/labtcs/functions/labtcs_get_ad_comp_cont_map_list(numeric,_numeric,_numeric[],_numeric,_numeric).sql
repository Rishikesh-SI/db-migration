-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_get_ad_comp_cont_map_list(numeric, numeric, numeric[], numeric, numeric)
-- Type: FUNCTION

-- Name: labtcs_get_ad_comp_cont_map_list(numeric, numeric, numeric[], numeric, numeric); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_get_ad_comp_cont_map_list(p_asset_type_id numeric, p_template_component_map_id numeric, p_entityrole_mapid numeric[], p_pageno numeric, p_itemno numeric, OUT p_data jsonb, OUT p_total numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$ 

 

  

declare
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_json text := '{"componentmap":';
	v_ent_count numeric ;
    v_entityrolemapidquery varchar(4000) := ' ';
    v_qry_str text;
begin

if p_pageno is not null
then
	v_fromrownumber := (p_pageno * p_itemno - (p_itemno - 1));
     v_torownumber   := (p_pageno * p_itemno);
else 
	v_fromrownumber := 0 ;
    v_torownumber := 10000;
end if;
     
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     	if v_ent_count > 0 then
    		
          v_entityrolemapidquery := 'and exists (select 1
          										 from   labtcs.labtcs_asset_entity_map eam
                                                 where  eam.asset_id = tccm.asset_id
                                                 and    eam.asset_type_id = tccm.asset_type_id 
                                                 and    eam.entity_role_map_id in (select entity_role_mapid
                                                 									from unnest($2) u(entity_role_mapid))
                                                 )';
     	
    	end if;
        
        
     
    /*v_qry_str:= 'select array_to_json(array_agg(a)) -- into p_data
     from   (select row_number() over(order by m.updated_date desc) slno, m.*
             from labtcs.labtcs_template_component_content_map m             
     		 where m.asset_type_id = $1            
             and (m.template_component_map_id = $3 or coalesce($3,0) = 0) 
         	   and m.is_published = 1
             ' || v_entityrolemapidquery || '             
            )a
      where slno between $4 and $5 ' ;*/
      
	v_qry_str := 'select array_to_json(array_agg(b))
    			  from   (select row_number() over(order by updated_date desc) slno, template_component_content_map_id, template_component_map_id,
                  		  		 tccmap_name, tccmap_display_name, tccmap_desc, order_number, asset_id, asset_type_id, asset_meta, show_in_web,
                          		 show_in_mobile, show_in_app, is_default, published_version_number, is_trashed, created_date, updated_date,
                                 created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid, entities
                          from   (select tccm.template_component_content_map_id, tccm.template_component_map_id, tccm.tccmap_name,
                          		  		 tccm.tccmap_display_name, tccm.tccmap_desc, tccm.order_number, tccm.asset_id, tccm.asset_type_id,
                                         tccm.asset_meta, tccm.show_in_web, tccm.show_in_mobile, tccm.show_in_app, tccm.is_default,
                                         tccm.published_version_number, tccm.is_trashed, tccm.created_date, tccm.updated_date, tccm.created_by,
                                         tccm.updated_by, tccm.is_active, tccm.is_deleted, tccm.is_published, tccm.published_date, tccm.asset_guid,
                                         string_agg(em.entity_name,'','') entities
								  from   labtcs.labtcs_template_component_content_map tccm
                                  join   labtcs.labtcs_asset_entity_map aem
                                  on     aem.asset_id = tccm.asset_id
                                  and    aem.asset_type_id = tccm.asset_type_id
                                  join   labtcs.labtcs_entity_role_map erm
                                  on     erm.entity_role_map_id = aem.entity_role_map_id
                                  join   labtcs.labtcs_entity_master em
                                  on     em.entity_master_id = erm.entity_master_id
                                  where  tccm.asset_type_id = $1
                                  and    (tccm.template_component_map_id = $3
                                  		  or coalesce($3,0) = 0)
								  and    tccm.is_published = 1'
                                  ||v_entityrolemapidquery||
                                  'group by tccm.template_component_content_map_id, tccm.template_component_map_id, tccm.tccmap_name,
                                  		   tccm.tccmap_display_name, tccm.tccmap_desc, tccm.order_number, tccm.asset_id, tccm.asset_type_id,
                                           tccm.asset_meta, tccm.show_in_web, tccm.show_in_mobile, tccm.show_in_app, tccm.is_default,
                                           tccm.published_version_number, tccm.is_trashed, tccm.created_date, tccm.updated_date, tccm.created_by,
                                           tccm.updated_by, tccm.is_active, tccm.is_deleted, tccm.is_published, tccm.published_date, tccm.asset_guid
								 )a
						 )b
				  where slno between $4 and $5';
      
      execute  v_qry_str into p_data
     using  p_asset_type_id,p_entityrole_mapid, p_template_component_map_id, v_fromrownumber, v_torownumber  ;
   
   
   	p_data := v_json || p_data ||'}' ; 
    
   v_qry_str:= ' select count(1) 
             from labtcs.labtcs_template_component_content_map tccm           
     		 where tccm.asset_type_id = $1            
             and (tccm.template_component_map_id = $3 or coalesce($3,0) = 0) 
         	   and tccm.is_published = 1
             ' || v_entityrolemapidquery || ' ';
      execute  v_qry_str into p_total
     using  p_asset_type_id,p_entityrole_mapid, p_template_component_map_id, v_fromrownumber, v_torownumber  ;
     
end;

 

 

 $_$;


--
