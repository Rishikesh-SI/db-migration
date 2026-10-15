-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: swa_show_get_page_data(character varying); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

    DECLARE
      -- ref refcursor;  
      v_page_id numeric;
      -- Declare a cursor variable
    BEGIN
           select page_id into strict v_page_id from swa.swa_page
             where alias=p_url;
    
      OPEN ref FOR  select page_id, alias,title from swa.swa_page where page_id=v_page_id;   
     
     -- RETURN next ref;                                                       
    END;
    
$$;


--
