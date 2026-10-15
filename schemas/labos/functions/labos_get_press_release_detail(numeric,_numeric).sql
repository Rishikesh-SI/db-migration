-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_get_press_release_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labos_get_press_release_detail(numeric, numeric); Type: FUNCTION; Schema: labos; Owner: -
--

CREATE FUNCTION labos.labos_get_press_release_detail(p_press_release_id numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     
begin
	
     if p_versionnumber is null then
     	
          select      version_number
          into strict v_versionnumber
          from   	  labos.labos_press_release_master
          where  	  press_release_id = p_press_release_id;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_json
     from   	  labos.labos_asset_draft
     where  	  asset_type_id  = 20
     and    	  asset_id       = p_press_release_id
	 and    	  version_number = v_versionnumber;
     
     
     
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
end;

 

$$;


--
