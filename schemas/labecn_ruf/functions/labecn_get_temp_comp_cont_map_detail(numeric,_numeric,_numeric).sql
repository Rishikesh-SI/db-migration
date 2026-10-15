-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_ruf
-- Object: labecn_get_temp_comp_cont_map_detail(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labecn_get_temp_comp_cont_map_detail(numeric, numeric, numeric); Type: FUNCTION; Schema: labecn_ruf; Owner: -
--

CREATE FUNCTION labecn_ruf.labecn_get_temp_comp_cont_map_detail(p_temp_comp_cont_map_id numeric, p_asset_type_id numeric, p_versionnumber numeric, OUT p_assetdraftjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

 

declare
    v_assetdraftjson jsonb; 
    v_asset_type_id numeric := p_asset_type_id;
    
    v_versionnumber numeric;
begin
      
      
      if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  labecn.labecn_template_component_content_map
          where  	  template_component_content_map_id = p_temp_comp_cont_map_id
          and asset_type_id = v_asset_type_id ;
          
         --  v_isdeletedquery := ' and aam.is_deleted = 0 ';
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
      
      
	  select asset_data into p_assetdraftjson
      from labecn.labecn_asset_draft 
      where asset_id = p_temp_comp_cont_map_id
	  and asset_type_id = v_asset_type_id
      and version_number=v_versionnumber;
    
           
 
end;

 

 $$;


--
