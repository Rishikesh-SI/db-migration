-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_check_asset_ent_by_cat(character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: upstox_check_asset_ent_by_cat(character varying, numeric, numeric); Type: FUNCTION; Schema: upstox; Owner: -
--

CREATE FUNCTION upstox.upstox_check_asset_ent_by_cat(p_category character varying, p_asset_id numeric, p_asset_type_id numeric, OUT p_entity_exists numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
 

    declare
        v_entity_role_id numeric;
        v_cnt numeric;
    begin
           p_entity_exists:=0;
           
           select entity_role_id into v_entity_role_id
           from upstox.upstox_entity_category where upper(category_name)=upper(p_category);
           
           select count(1)
           into v_cnt
           from  upstox.upstox_asset_entity_map ae
           join  upstox.upstox_entity_role_map er
           on ae.entity_role_map_id=er.entity_role_map_id
           where ae.asset_id=p_asset_id
           and ae.asset_type_id=p_asset_type_id
           and er.entity_role_id=v_entity_role_id;
           
           if v_cnt>=1 then
              p_entity_exists:=1;
           else 
              p_entity_exists:=0;
           end if;
end;
    

 
$$;


--
