-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_showcase_list_28012019_3ccb(refcursor)
-- Type: FUNCTION

-- Name: spz_get_showcase_list_28012019_3ccb(refcursor); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_showcase_list_28012019_3ccb(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$ 

begin
	
     open p_data for
     	select *
          from   spz.spz_template_component_map
          where  component_id = 9
          and is_active=1
          and is_deleted=0
          and is_published=1
          order by title;
          
     
end;

 $$;


--
