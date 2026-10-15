-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_show_get_page_data(character varying, refcursor)
-- Type: FUNCTION

-- Name: ttmum_show_get_page_data(character varying, refcursor); Type: FUNCTION; Schema: ttmum; Owner: -
--

CREATE FUNCTION ttmum.ttmum_show_get_page_data(p_url character varying, ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

    DECLARE
      -- ref refcursor;  
      v_page_id numeric;
      -- Declare a cursor variable
    BEGIN
           select page_id into strict v_page_id from ttmum.ttmum_page
             where alias=p_url;
    
      OPEN ref FOR  select page_id, alias,title from ttmum.ttmum_page where page_id=v_page_id;   
     
     -- RETURN next ref;                                                       
    END;
    

$$;


--
