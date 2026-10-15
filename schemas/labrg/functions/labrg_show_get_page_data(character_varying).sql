-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: labrg_show_get_page_data(character varying); Type: FUNCTION; Schema: labrg; Owner: -
--

CREATE FUNCTION labrg.labrg_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from labrg.labrg_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from labrg.labrg_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
