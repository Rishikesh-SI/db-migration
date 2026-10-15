-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: labpvl_show_get_page_data(character varying); Type: FUNCTION; Schema: labpvl; Owner: -
--

CREATE FUNCTION labpvl.labpvl_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from labpvl.labpvl_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from labpvl.labpvl_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
