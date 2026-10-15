-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_get_showcase_list_28012019_1699(refcursor)
-- Type: FUNCTION

-- Name: scom_get_showcase_list_28012019_1699(refcursor); Type: FUNCTION; Schema: scom; Owner: -
--

CREATE FUNCTION scom.scom_get_showcase_list_28012019_1699(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$ 

begin
	
     open p_data for
     	select *
          from   scom.scom_template_component_map
          where  component_id = 9
          and is_active=1
          and is_deleted=0
          and is_published=1
          order by title;
          
     
end;

 $$;


--
