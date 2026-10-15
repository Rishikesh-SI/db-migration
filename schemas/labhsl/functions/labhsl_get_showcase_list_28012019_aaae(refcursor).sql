-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_get_showcase_list_28012019_aaae(refcursor)
-- Type: FUNCTION

-- Name: labhsl_get_showcase_list_28012019_aaae(refcursor); Type: FUNCTION; Schema: labhsl; Owner: -
--

CREATE FUNCTION labhsl.labhsl_get_showcase_list_28012019_aaae(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$ 

begin
	
     open p_data for
     	select *
          from   labhsl.labhsl_template_component_map
          where  component_id = 9
          and is_active=1
          and is_deleted=0
          and is_published=1
          order by title;
          
     
end;

 $$;


--
