-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: dhm_show_get_page_data(character varying); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from dhm.dhm_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from dhm.dhm_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
