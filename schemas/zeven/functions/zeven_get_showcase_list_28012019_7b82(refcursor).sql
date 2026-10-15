-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_showcase_list_28012019_7b82(refcursor)
-- Type: FUNCTION

-- Name: zeven_get_showcase_list_28012019_7b82(refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_showcase_list_28012019_7b82(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$    

begin
	
     open p_data for
     	select *
          from   zeven.zeven_template_component_map
          where  component_id = 9
          order by title;
          
     
end;

    $$;


--
