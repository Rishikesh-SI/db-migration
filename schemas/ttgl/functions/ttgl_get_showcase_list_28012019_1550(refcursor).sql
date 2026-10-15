-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ttgl_get_showcase_list_28012019_1550(refcursor)
-- Type: FUNCTION

-- Name: ttgl_get_showcase_list_28012019_1550(refcursor); Type: FUNCTION; Schema: ttgl; Owner: -
--

CREATE FUNCTION ttgl.ttgl_get_showcase_list_28012019_1550(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$   

begin
	
     open p_data for
     	select *
          from   ttgl.ttgl_template_component_map
          where  component_id = 9
          order by title;
          
     
end;

   $$;


--
