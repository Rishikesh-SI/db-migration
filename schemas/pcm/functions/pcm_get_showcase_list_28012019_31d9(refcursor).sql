-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_get_showcase_list_28012019_31d9(refcursor)
-- Type: FUNCTION

-- Name: pcm_get_showcase_list_28012019_31d9(refcursor); Type: FUNCTION; Schema: pcm; Owner: -
--

CREATE FUNCTION pcm.pcm_get_showcase_list_28012019_31d9(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$ 

begin
	
     open p_data for
     	select *
          from   pcm.pcm_template_component_map
          where  component_id = 9
          order by title;
          
     
end;

 $$;


--
