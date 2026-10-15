-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_showcase_list_28012019_29dd(refcursor)
-- Type: FUNCTION

-- Name: swa_get_showcase_list_28012019_29dd(refcursor); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_showcase_list_28012019_29dd(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$

begin
	
     open p_data for
     	select *
          from   swa.swa_template_component_map
          where  component_id = 9
          and is_active=1
          and is_deleted=0
          and is_published=1
          order by title;
          
     
end;

$$;


--
