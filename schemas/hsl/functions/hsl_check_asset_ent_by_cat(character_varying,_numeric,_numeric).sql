-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_check_asset_ent_by_cat(character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: hsl_check_asset_ent_by_cat(character varying, numeric, numeric); Type: FUNCTION; Schema: hsl; Owner: -
--

CREATE FUNCTION hsl.hsl_check_asset_ent_by_cat(p_category character varying, p_asset_id numeric, p_asset_type_id numeric, OUT p_entity_exists numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

    DECLARE
        v_entity_role_id numeric;
        v_cnt numeric;
    BEGIN
           p_entity_exists:=0;
           
           select entity_role_id into v_entity_role_id
           from hsl.hsl_ENTITY_CATEGORY where upper(CATEGORY_NAME)=upper(p_category);
           
           SELECT COUNT(1)
           into v_cnt
           FROM  hsl.hsl_asset_entity_map ae
           join  hsl.hsl_entity_role_map er
           on ae.entity_role_map_id=er.entity_role_map_id
           where ae.asset_id=p_asset_id
           and ae.asset_type_id=p_asset_type_id
           and er.entity_role_id=v_entity_role_id;
           
           if v_cnt>=1 then
              p_entity_exists:=1;
           else 
              p_entity_exists:=0;
           end if;
END;
    

 $$;


--
