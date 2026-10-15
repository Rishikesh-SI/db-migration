-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_get_showcase_list_04022019_d39f(refcursor)
-- Type: FUNCTION

-- Name: abp_get_showcase_list_04022019_d39f(refcursor); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_get_showcase_list_04022019_d39f(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$

begin
	
     open p_data for
     select M.template_component_map_id ,
    m.template_id ,
    M.component_id ,
    M.title ,
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
    M.menu_id 
          from   abp.abp_template_component_map M
          -- inner join abp.abp_template_component_asset_map Tm
          -- on (M.template_component_map_id = Tm.template_component_map_id)          
          where  component_id = 9 -- and Tm.asset_type_id = 12
          order by title;
          
     
end;

$$;


--
