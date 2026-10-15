-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: labmcfc_show_get_page_data(character varying); Type: FUNCTION; Schema: labmcfc; Owner: -
--

CREATE FUNCTION labmcfc.labmcfc_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from labmcfc.labmcfc_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from labmcfc.labmcfc_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
