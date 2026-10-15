-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_get_press_release_detail_bak(numeric)
-- Type: FUNCTION

-- Name: pkl_get_press_release_detail_bak(numeric); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.pkl_get_press_release_detail_bak(p_press_release_id numeric, OUT p_result numeric, OUT p_pressreleasejson jsonb, OUT p_assetmapjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

  

declare
	
     v_versionnumber	 numeric;
     v_pressreleaseid	 numeric;
    --- v_title text := upper(p_title);
     v_asset_type_id numeric := 20;
    
     
begin
	
     select press_release_id, published_version_number
     into   v_pressreleaseid, v_versionnumber
     from  pkl.pkl_press_release
     where  press_release_id = p_press_release_id;
     
   
     select	asset_data
     into strict p_pressreleasejson
     from   pkl.pkl_asset_draft
     where  asset_type_id  = v_asset_type_id
     and    asset_id       = v_pressreleaseid
	 and     version_number = v_versionnumber;
     

     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
     
end;
 

$$;


--
