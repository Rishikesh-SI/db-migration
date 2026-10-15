-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: labukk_show_get_page_data(character varying); Type: FUNCTION; Schema: labukk; Owner: -
--

CREATE FUNCTION labukk.labukk_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from labukk.labukk_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from labukk.labukk_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
