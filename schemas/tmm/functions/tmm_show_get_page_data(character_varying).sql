-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: tmm_show_get_page_data(character varying); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from tmm.tmm_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from tmm.tmm_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
