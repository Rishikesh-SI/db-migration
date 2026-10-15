-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_showcase_list_28012019_2fe3(refcursor)
-- Type: FUNCTION

-- Name: tmm_get_showcase_list_28012019_2fe3(refcursor); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_showcase_list_28012019_2fe3(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$ 

begin
	
     open p_data for
     	select *
          from   tmm.tmm_template_component_map
          where  component_id = 9
          and is_active=1
          and is_deleted=0
          and is_published=1
          order by title;
          
     
end;

 $$;


--
