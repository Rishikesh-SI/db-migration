-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: labgmr_show_get_page_data(character varying); Type: FUNCTION; Schema: labgmr_01082024; Owner: -
--

CREATE FUNCTION labgmr_01082024.labgmr_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from labgmr.labgmr_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from labgmr.labgmr_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
