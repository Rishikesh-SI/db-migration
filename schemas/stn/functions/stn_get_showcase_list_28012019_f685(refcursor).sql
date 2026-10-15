-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_showcase_list_28012019_f685(refcursor)
-- Type: FUNCTION

-- Name: stn_get_showcase_list_28012019_f685(refcursor); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_showcase_list_28012019_f685(p_data refcursor) RETURNS void
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
          from   stn.stn_template_component_map M
          -- inner join stn.stn_template_component_asset_map Tm
          -- on (M.template_component_map_id = Tm.template_component_map_id)          
          where  component_id = 9 -- and Tm.asset_type_id = 12
          order by title;
          
     
end;

$$;


--
