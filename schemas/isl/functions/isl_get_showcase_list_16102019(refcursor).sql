-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_showcase_list_16102019(refcursor)
-- Type: FUNCTION

-- Name: isl_get_showcase_list_16102019(refcursor); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_showcase_list_16102019(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$     

begin
	
     open p_data for
     	select *
          from   isl.isl_template_component_map
          where  component_id = 9
          order by title;
          
     
end;

     $$;


--
