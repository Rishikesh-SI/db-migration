-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entity_group_listing_r(character varying)
-- Type: FUNCTION

-- Name: _get_entity_group_listing_r(character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entity_group_listing_r(p_schema_prefix character varying, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

 
declare

begin 

execute'(SELECT JSON_AGG(src) FROM (SELECT entity_group_id,group_name FROM '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group where is_active=1 and is_deleted=0 ) src)'
into p_json;

end;

$$;


--
