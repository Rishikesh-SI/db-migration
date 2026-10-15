-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: labkiyg_get_tem_cop_asset_map_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labkiyg_get_tem_cop_asset_map_detail(numeric, numeric); Type: FUNCTION; Schema: labkiyg; Owner: -
--

CREATE FUNCTION labkiyg.labkiyg_get_tem_cop_asset_map_detail(p_asset_id numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_assetmapjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
    v_asset_type_id numeric :=8;
     v_versionnumber numeric;
     v_image_path varchar(4000);
     
begin
	
     if p_versionnumber is null then

          select     max(published_version_number)     into strict v_versionnumber
          from   	  labkiyg.labkiyg_template_component_asset_map
          where  	  template_component_map_id = p_asset_id;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_assetmapjson
     from   	  labkiyg.labkiyg_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = p_asset_id
	  and    	  version_number = v_versionnumber;
     
    
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
     
     p_result := 1;
     
-- exception
	
 --    when others then
   --  	p_result := -1;
end;

 $$;


--
