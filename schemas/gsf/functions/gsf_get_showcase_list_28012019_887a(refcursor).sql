-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_get_showcase_list_28012019_887a(refcursor)
-- Type: FUNCTION

-- Name: gsf_get_showcase_list_28012019_887a(refcursor); Type: FUNCTION; Schema: gsf; Owner: -
--

CREATE FUNCTION gsf.gsf_get_showcase_list_28012019_887a(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$ 

begin
	
     open p_data for
     	select *
          from   gsf.gsf_template_component_map
          where  component_id = 9
          and is_active=1
          and is_deleted=0
          and is_published=1
          order by title;
          
     
end;

 $$;


--
