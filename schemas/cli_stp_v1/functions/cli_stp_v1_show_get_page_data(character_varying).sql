-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_show_get_page_data(character varying)
-- Type: FUNCTION

-- Name: cli_stp_v1_show_get_page_data(character varying); Type: FUNCTION; Schema: cli_stp_v1; Owner: -
--

CREATE FUNCTION cli_stp_v1.cli_stp_v1_show_get_page_data(p_url character varying, OUT ref refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
      -- ref refcursor;  
      v_page_id numeric;
      -- declare a cursor variable
    begin
           select page_id into strict v_page_id from cli_stp_v1.cli_stp_v1_page
             where alias=p_url;
    
      open ref for  select page_id, alias,title from cli_stp_v1.cli_stp_v1_page where page_id=v_page_id;   
     
     -- return next ref;                                                       
    end;
    
 $$;


--
