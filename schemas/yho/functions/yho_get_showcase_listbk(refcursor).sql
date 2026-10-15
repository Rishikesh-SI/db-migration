-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_showcase_listbk(refcursor)
-- Type: FUNCTION

-- Name: yho_get_showcase_listbk(refcursor); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_showcase_listbk(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$
 

begin
	
     open p_data for
     	select *
          from   yho.yho_template_component_map
          where  component_id = 9
          and is_active = 1
          and is_deleted = 0
          and is_published = 1
          order by title;
          
     
end;

 
$$;


--
