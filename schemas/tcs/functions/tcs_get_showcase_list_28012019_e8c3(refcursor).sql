-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_get_showcase_list_28012019_e8c3(refcursor)
-- Type: FUNCTION

-- Name: tcs_get_showcase_list_28012019_e8c3(refcursor); Type: FUNCTION; Schema: tcs; Owner: -
--

CREATE FUNCTION tcs.tcs_get_showcase_list_28012019_e8c3(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$    

begin
	
     open p_data for
     	select *
          from   tcs.tcs_template_component_map
          where  component_id = 9
          order by title;
          
     
end;

    $$;


--
