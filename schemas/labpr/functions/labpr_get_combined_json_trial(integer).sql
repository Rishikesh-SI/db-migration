-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_combined_json_trial(integer)
-- Type: FUNCTION

-- Name: labpr_get_combined_json_trial(integer); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_get_combined_json_trial(p_asset_id integer) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_web_listing_json jsonb;
    v_asset_guid uuid;
    v_lang_entity_role_map_id int;
    v_combined_json jsonb;
BEGIN
    -- Ensure to avoid naming conflicts
    SELECT 
        web_listing_json, 
        asset_guid, 
        language_entity_role_map_id 
    INTO 
        v_web_listing_json, 
        v_asset_guid, 
        v_lang_entity_role_map_id
    FROM 
        labpr.labpr_asset_list
    WHERE 
        asset_type_id = 1 
        AND asset_id = p_asset_id;  -- Use parameter name

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No asset found with asset_id %', p_asset_id;
    END IF;

    v_combined_json := jsonb_build_object(
        'web_listing', v_web_listing_json,
        'asset_guid', v_asset_guid,
        'language_entity_role_map_id', v_lang_entity_role_map_id
    );

    RETURN v_combined_json;
END $$;


--
