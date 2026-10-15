-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_combined_asset_info_anshu()
-- Type: FUNCTION

-- Name: labpr_get_combined_asset_info_anshu(); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_get_combined_asset_info_anshu() RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_web_listing_json jsonb;
    v_asset_guid uuid;
    v_lang_entity_role_map_id int;
BEGIN
    
    SELECT web_listing_json, asset_guid, language_entity_role_map_id  INTO v_web_listing_json, v_asset_guid, v_lang_entity_role_map_id
    FROM  labpr.labpr_asset_list
    WHERE asset_type_id = 1 AND asset_id = 501;  
  
    v_web_listing_json := jsonb_set( v_web_listing_json,'{combined_info}',  jsonb_build_object('asset_guid', v_asset_guid,
            'language_entity_role_map_id', v_lang_entity_role_map_id ),true);

    RETURN v_web_listing_json;
	    RAISE NOTICE 'Combined JSON: %', v_web_listing_json;
END $$;


--
