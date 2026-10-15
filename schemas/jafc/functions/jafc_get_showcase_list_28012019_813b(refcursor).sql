-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_get_showcase_list_28012019_813b(refcursor)
-- Type: FUNCTION

-- Name: jafc_get_showcase_list_28012019_813b(refcursor); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_get_showcase_list_28012019_813b(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$

begin
	
     open p_data for
     	select *
          from   jafc.jafc_template_component_map
          where  component_id = 9
          order by title;
          
     
end;

$$;


--
