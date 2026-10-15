-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_get_showcase_list_28012019_1097(refcursor)
-- Type: FUNCTION

-- Name: ppb_get_showcase_list_28012019_1097(refcursor); Type: FUNCTION; Schema: ppb; Owner: -
--

CREATE FUNCTION ppb.ppb_get_showcase_list_28012019_1097(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$   

begin
	
     open p_data for
     	select *
          from   ppb.ppb_template_component_map
          where  component_id = 9
          order by title;
          
     
end;

   $$;


--
