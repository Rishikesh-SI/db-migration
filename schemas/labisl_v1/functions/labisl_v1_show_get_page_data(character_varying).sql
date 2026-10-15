-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: labisl_v1_show_get_page_data(character varying); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from labisl_v1.labisl_v1_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from labisl_v1.labisl_v1_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
