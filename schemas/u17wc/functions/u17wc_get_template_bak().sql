-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_get_template_bak()
-- Type: FUNCTION

-- Name: u17wc_get_template_bak(); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_get_template_bak(OUT p_template jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$   

 

DECLARE
  			
BEGIN

    p_template := ( select array_to_json(array_agg(a))
    --- into p_template
     from
     (select * from u17wc.u17wc_template 
      where is_published = 1
      )a)
     ; 
    
                                                
END;
    

 

   $$;


--
