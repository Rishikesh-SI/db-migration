-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_get_showcase_list_28012019_a631(refcursor)
-- Type: FUNCTION

-- Name: hsl_get_showcase_list_28012019_a631(refcursor); Type: FUNCTION; Schema: hsl; Owner: -
--

CREATE FUNCTION hsl.hsl_get_showcase_list_28012019_a631(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$ 

begin
	
     open p_data for
     	select *
          from   hsl.hsl_template_component_map
          where  component_id = 9
          order by title;
          
     
end;

 $$;


--
