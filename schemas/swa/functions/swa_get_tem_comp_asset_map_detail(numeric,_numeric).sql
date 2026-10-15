-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_tem_comp_asset_map_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: swa_get_tem_comp_asset_map_detail(numeric, numeric); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_tem_comp_asset_map_detail(p_asset_id numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_assetmapjson jsonb, OUT p_title character varying, OUT p_entity_role_map_id numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
     v_asset_type_id numeric :=8;
     v_versionnumber numeric;
     v_image_path varchar(4000);
    
     
begin
	
     if p_versionnumber is null then

          select     max(published_version_number)     into  v_versionnumber
          from   	  swa.swa_template_component_asset_map
          where  	  template_component_map_id = p_asset_id;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into  p_assetmapjson
     from   	  swa.swa_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = p_asset_id
	  and    	  version_number = v_versionnumber;
    
    
     select title into p_title
          from   swa.swa_template_component_map
          where  template_component_map_id = p_asset_id;
     
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
     
     -- changes done by rakesh B date 13-04-17--
     
     select entity_role_map_id into p_entity_role_map_id
     from swa.swa_asset_entity_map 
     where  asset_type_id=13
     and asset_id=p_asset_id;
     
     -- changes done by rakesh B date 13-04-17--
     p_result := 1;
     
 exception
	
     when others then
    	p_result := -1;
end;

$$;


--
