-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_upd_draft_entities()
-- Type: FUNCTION

-- Name: pkl_upd_draft_entities(); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.pkl_upd_draft_entities() RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
    
    assets_missing_entity_row record;
    
    assets_missing_entity_cur cursor for
    select aem.asset_id, aem.is_visible, em.entity_name as name, em.entity_display_name ent_disp_name, aem.priority, aem.is_linkable,
    	   aem.entity_role_map_id
    from   pkl.pkl_asset_entity_map aem
    join   pkl.pkl_entity_role_map erm
    on     erm.entity_role_map_id = aem.entity_role_map_id
    join   pkl.pkl_entity_master em
    on     em.entity_master_id = erm.entity_master_id
    where  aem.entity_role_map_id not in
    (
        select (json_array_elements((ad.asset_data->'data'->'entitydata')::json)->>'entity_role_map_id')::numeric
        from   pkl.pkl_asset_draft_25072017 ad
        where  ad.asset_id = aem.asset_id
        and    ad.asset_type_id = aem.asset_type_id
    )
    and    aem.asset_id = 35921
    and    aem.asset_type_id = 1;
    
    v_json_row jsonb;
    v_json_row_text text;
    
begin
	
    open assets_missing_entity_cur;
    
    loop
    	
    	fetch assets_missing_entity_cur into assets_missing_entity_row;
        
        if not found then
        	exit;
		end if;
        
        select row_to_json(a)
        from   (select assets_missing_entity_row) a
        into   v_json_row;
        
        select trim(trailing '}' from trim(leading '{"assets_missing_entity_row":' from v_json_row::text))||'}'
        into   v_json_row_text;
        
        raise notice '%',v_json_row;
        raise notice '%',v_json_row_text;
        
        update pkl.pkl_asset_draft_25072017 ad
        set    asset_data = jsonb_set(asset_data,
                                      '{data,entitydata}',
                                      (
                                          replace
                                          (
                                              (asset_data->'data'->'entitydata')::text,
                                              (asset_data->'data'->'entitydata')::text,
                                              (array_to_json(array(select *
                                                                   from   jsonb_array_elements_text(ad.asset_data->'data'->'entitydata')
                                                                  )||v_json_row_text
                                                            )::json
                                              )::text
                                          )
                                      )::jsonb,
                                      false
                                     )
        where  ad.asset_id = 35921
        and    ad.asset_type_id = 1
        and    ad.version_number = (select max(ad1.version_number)
                                    from   pkl.pkl_asset_draft_25072017 ad1
                                    where  ad1.asset_id = ad.asset_id
                                    and    ad1.asset_type_id = ad.asset_type_id);
        
    end loop;
    
    close assets_missing_entity_cur;
    
end;
$$;


--
