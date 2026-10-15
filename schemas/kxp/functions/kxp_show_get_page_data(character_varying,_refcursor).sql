-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_show_get_page_data(character varying, refcursor)
-- Type: FUNCTION

-- Name: kxp_show_get_page_data(character varying, refcursor); Type: FUNCTION; Schema: kxp; Owner: -
--

CREATE FUNCTION kxp.kxp_show_get_page_data(p_url character varying, ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

    DECLARE
      -- ref refcursor;  
      v_page_id numeric;
      -- Declare a cursor variable
    BEGIN
           select page_id into strict v_page_id from kxp.kxp_page
             where alias=p_url;
    
      OPEN ref FOR  select page_id, alias,title from kxp.kxp_page where page_id=v_page_id;   
     
     -- RETURN next ref;                                                       
    END;
    

$$;


--
