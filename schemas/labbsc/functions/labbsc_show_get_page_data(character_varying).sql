-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: labbsc_show_get_page_data(character varying); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from labbsc.labbsc_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from labbsc.labbsc_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
