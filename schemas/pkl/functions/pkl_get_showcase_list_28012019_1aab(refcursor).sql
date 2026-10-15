-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_get_showcase_list_28012019_1aab(refcursor)
-- Type: FUNCTION

-- Name: pkl_get_showcase_list_28012019_1aab(refcursor); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.pkl_get_showcase_list_28012019_1aab(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$  

begin
	
     open p_data for
     	select *
          from   pkl.pkl_template_component_map
          where  component_id = 9
          order by title;
          
     
end;

  $$;


--
