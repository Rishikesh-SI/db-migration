-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_show_get_page_data(character varying, refcursor)
-- Type: FUNCTION

-- Name: pcm_show_get_page_data(character varying, refcursor); Type: FUNCTION; Schema: pcm; Owner: -
--

CREATE FUNCTION pcm.pcm_show_get_page_data(p_url character varying, ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    DECLARE
      -- ref refcursor;  
      v_page_id numeric;
      -- Declare a cursor variable
    BEGIN
           select page_id into strict v_page_id from pcm.pcm_page
             where alias=p_url;
    
      OPEN ref FOR  select page_id, alias,title from pcm.pcm_page where page_id=v_page_id;   
     
     -- RETURN next ref;                                                       
    END;
    

 $$;


--
