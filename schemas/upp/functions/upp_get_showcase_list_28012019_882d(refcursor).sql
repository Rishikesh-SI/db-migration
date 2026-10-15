-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_get_showcase_list_28012019_882d(refcursor)
-- Type: FUNCTION

-- Name: upp_get_showcase_list_28012019_882d(refcursor); Type: FUNCTION; Schema: upp; Owner: -
--

CREATE FUNCTION upp.upp_get_showcase_list_28012019_882d(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$ 

begin
	
     open p_data for
     	select *
          from   upp.upp_template_component_map
          where  component_id = 9
          and is_active=1
          and is_deleted=0
          and is_published=1
          order by title;
          
     
end;

 $$;


--
