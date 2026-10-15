-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_get_template_bak()
-- Type: FUNCTION

-- Name: ppb_get_template_bak(); Type: FUNCTION; Schema: ppb; Owner: -
--

CREATE FUNCTION ppb.ppb_get_template_bak(OUT p_template jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

 

DECLARE
  			
BEGIN

    p_template := ( select array_to_json(array_agg(a))
    --- into p_template
     from
     (select * from ppb.ppb_template 
      where is_published = 1
      )a)
     ; 
    
                                                
END;
    

 

 $$;


--
