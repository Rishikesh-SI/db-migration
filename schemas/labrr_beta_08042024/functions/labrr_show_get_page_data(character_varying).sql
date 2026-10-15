-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: labrr_show_get_page_data(character varying); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from labRR.labRR_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from labRR.labRR_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
