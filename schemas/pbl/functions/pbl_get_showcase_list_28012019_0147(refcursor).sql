-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_get_showcase_list_28012019_0147(refcursor)
-- Type: FUNCTION

-- Name: pbl_get_showcase_list_28012019_0147(refcursor); Type: FUNCTION; Schema: pbl; Owner: -
--

CREATE FUNCTION pbl.pbl_get_showcase_list_28012019_0147(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$  

begin
	
     open p_data for
     	select *
          from   pbl.pbl_template_component_map
          where  component_id = 9
          order by title;
          
     
end;

  $$;


--
