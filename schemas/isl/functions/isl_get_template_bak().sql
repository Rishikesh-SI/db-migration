-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_template_bak()
-- Type: FUNCTION

-- Name: isl_get_template_bak(); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_template_bak(OUT p_template jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$   

 

DECLARE
  			
BEGIN

    p_template := ( select array_to_json(array_agg(a))
    --- into p_template
     from
     (select * from isl.isl_template 
      where is_published = 1
      )a)
     ; 
    
                                                
END;
    

 

   $$;


--
