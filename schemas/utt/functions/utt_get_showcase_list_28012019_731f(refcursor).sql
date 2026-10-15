-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_get_showcase_list_28012019_731f(refcursor)
-- Type: FUNCTION

-- Name: utt_get_showcase_list_28012019_731f(refcursor); Type: FUNCTION; Schema: utt; Owner: -
--

CREATE FUNCTION utt.utt_get_showcase_list_28012019_731f(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$ 

begin
	
     open p_data for
     	select *
          from   utt.utt_template_component_map
          where  component_id = 9
          and is_active=1
          and is_deleted=0
          and is_published=1
          order by title;
          
     
end;

 $$;


--
