-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_entity_url_draft_r(numeric, numeric)
-- Type: FUNCTION

-- Name: labwis_get_entity_url_draft_r(numeric, numeric); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_entity_url_draft_r(p_asset_id numeric, p_asset_type_id numeric, OUT p_pri_ent_url character varying, OUT p_sec_ent_url character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_entity_data JSONB;
    v_pri_entity_role_map_id NUMERIC;
    v_sec_entity_role_map_id NUMERIC;
BEGIN
    SELECT asset_data -> 'data' -> 'entitydata'
    INTO v_entity_data
    FROM labwis.labwis_asset_draft
    WHERE asset_id = p_asset_id
      AND asset_type_id = p_asset_type_id
      AND version_number = (
          SELECT MAX(version_number)
          FROM labwis.labwis_asset_draft
          WHERE asset_id = p_asset_id
            AND asset_type_id = p_asset_type_id
      );

    SELECT (elem ->> 'entity_role_map_id')::NUMERIC
    INTO v_pri_entity_role_map_id
    FROM jsonb_array_elements(v_entity_data) AS elem
    WHERE elem ->> 'priority' = '1';

    SELECT (elem ->> 'entity_role_map_id')::NUMERIC
    INTO v_sec_entity_role_map_id
    FROM jsonb_array_elements(v_entity_data) AS elem
    WHERE elem ->> 'priority' = '2';

    SELECT entity_url
    INTO p_pri_ent_url
    FROM labwis.labwis_entity_role_map erm
    JOIN labwis.labwis_entity_master em ON erm.entity_master_id = em.entity_master_id
    WHERE erm.entity_role_map_id = v_pri_entity_role_map_id;

    SELECT entity_url
    INTO p_sec_ent_url
    FROM labwis.labwis_entity_role_map erm
    JOIN labwis.labwis_entity_master em ON erm.entity_master_id = em.entity_master_id
    WHERE erm.entity_role_map_id = v_sec_entity_role_map_id;

END;
$$;


--
