-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_showcase_list_04022019_d106(refcursor)
-- Type: FUNCTION

-- Name: swa_get_showcase_list_04022019_d106(refcursor); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_showcase_list_04022019_d106(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$

begin

     open p_data for
	 select distinct 
	 M.template_component_map_id ,
    m.template_id ,
    M.component_id ,
   ( M.title ||' '|| coalesce(c.entity_name,' ') ) as title,
    M.display_title ,
    M.title_mobile ,
    M.title_app ,
    M.show_in_web,
    M.show_in_mobile,
    M.show_in_app ,
    M.fetch_from ,
    M.created_date ,
    M.updated_date ,
    M.created_by ,
    M.updated_by,
    M.is_active ,
    M.is_deleted,
    m.is_published,
    M.tcmap_guid ,
    M.parent_container_id ,
    M.parent_tcmap_id ,
    M.meta_info ,
    M.menu_id ,
    t2.page_id,
    c.entity_role_map_id,
    c.entity_name
   
    from swa.swa_template_component_map M
    join swa.swa_template t on m.template_id=t.template_id
    join swa.swa_template t2 on t.template_id=t2.parent_id
    left  join (select a.asset_id,a.entity_role_map_id,d.entity_name
    from swa.swa_asset_entity_map a 
    join (select a.entity_role_map_id,c.entity_name 
         from swa.swa_entity_role_map a
         join swa.swa_entity_category b on a.entity_role_id=b.entity_role_id
         join swa.swa_entity_master c on a.entity_master_id=c.entity_master_id
         where category_name ='Language')d 
         on a.entity_role_map_id=d.entity_role_map_id
         where asset_type_id=11) c on c.asset_id=t2.page_id
        
    where  component_id = 9
    and t2.page_id<>0 
	and m.is_deleted=0;

end;

$$;


--
