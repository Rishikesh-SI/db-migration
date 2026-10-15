-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_show_get_page_data(character varying, refcursor)
-- Type: FUNCTION

-- Name: jafc_show_get_page_data(character varying, refcursor); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_show_get_page_data(p_url character varying, ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from jafc.jafc_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from jafc.jafc_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    

$$;


--
