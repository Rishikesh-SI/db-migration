-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_get_tem_asset_map_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labupstox_get_tem_asset_map_detail(numeric, numeric); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_get_tem_asset_map_detail(p_asset_id numeric, p_versionnumber numeric, OUT p_assetmapjson1 jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare
    v_asset_type_id numeric :=8;
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_asset_type json;
     p_assetmapjson jsonb;
     v_asset json;
     v_asset_type_id1 numeric;
     v_asset_id numeric;
     
     v_json jsonb;
begin
	
     if p_versionnumber is null then

          select     max(published_version_number)     into strict v_versionnumber
          from   	  labupstox.labupstox_template_component_asset_map
          where  	  template_component_map_id = p_asset_id;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_assetmapjson
     from   	  labupstox.labupstox_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = p_asset_id
	  and    	  version_number = v_versionnumber;
     
     select    p_assetmapjson->'data'->>'asset_map'
    into v_asset_type;
    
    
    p_assetmapjson1 := v_asset_type :: jsonb;
            
          /*for v_asset in select * from json_array_elements(v_asset_type)
                    loop
                    	
                         select v_asset->>'asset_type',
                 			   v_asset->>'asset_id'
                         into   v_asset_type_id1,
                         v_asset_id;
                         
                          select row_to_json(a)
                          from (  select 
                          asset_id,
                          asset_type_id,
                          asset_title,
                          (select array_to_json(array_agg(a))
                          from 
                          (select priority,entity_role_map_id,'' as name,is_linkable,is_visible from labupstox.labupstox_asset_entity_map
                           where asset_id=v_asset_id
                           and    asset_type_id=v_asset_type_id1
                          )a ) as entitydata
                          from labupstox.labupstox_asset_list
                          where asset_id=v_asset_id
                          and asset_type_id=v_asset_type_id1)a
                          
                          into p_assetmapjson1;
                  end loop
     ;*/
    
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
     
    -- p_result := 1;
     
-- exception
	
 --    when others then
   --  	p_result := -1;
end;

 $$;


--
