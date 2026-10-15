-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_get_date_sitemap(character varying, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labdsp_get_date_sitemap(character varying, refcursor, refcursor); Type: FUNCTION; Schema: labdsp; Owner: -
--

CREATE FUNCTION labdsp.labdsp_get_date_sitemap(p_date character varying, p_date_list_json refcursor, p_asset_data_json refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_yyyy character varying(4);
    v_mm character varying(2);
    v_dd character varying(2);
    v_first_date character varying(10);
    
begin
    
    if p_date is not null then
    	
        v_first_date := p_date;
        
        open p_date_list_json for
        select substring(v_first_date,1,4)yyyy, substring(v_first_date,6,2)mm, substring(v_first_date,9,2)dd;
        
	else
    	
        select distinct to_char(published_date, 'yyyy-mm-dd') published_date 
        into v_first_date
        from labdsp.labdsp_asset_list 
        where asset_type_id in(1,2,4)
        order by published_date
        limit 1;
        
        open p_date_list_json for
        select substring(published_date,1,4)yyyy, substring(published_date,6,2)mm, substring(published_date,9,2)dd
        from(
            select distinct to_char(published_date, 'yyyy-mm-dd') published_date 
            from labdsp.labdsp_asset_list 
            where asset_type_id in(1,2,4)
        ) tab
        order by yyyy, mm, dd;
        
	end if;
    
    open p_asset_data_json for
    select replace(coalesce(em1.canonical_url,'!')||'/'||replace(lower(em.entity_name),' ','-')||'/'||title_alias,'!','') url, al.updated_date
    from labdsp.labdsp_asset_list al
    join labdsp.labdsp_entity_role_map erm
    on erm.entity_role_map_id = al.secondary_entity_role_map_id
    join labdsp.labdsp_entity_master em
    on em.entity_master_id = erm.entity_master_id
    join labdsp.labdsp_asset_entity_map aem
    on aem.asset_id = al.asset_id
    and aem.asset_type_id = al.asset_type_id
    join labdsp.labdsp_entity_role_map erm1
    on erm1.entity_role_map_id = aem.entity_role_map_id
    join labdsp.labdsp_entity_category ec
    on ec.entity_role_id = erm1.entity_role_id
    and ec.category_name = 'Language'
    join labdsp.labdsp_entity_master em1
    on em1.entity_master_id = erm1.entity_master_id
    where to_char(al.published_date,'yyyy-mm-dd') = v_first_date;
    
end;

$$;


--
