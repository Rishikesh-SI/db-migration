-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_template_bak()
-- Type: FUNCTION

-- Name: zeven_get_template_bak(); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_template_bak(OUT p_template jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$  

 

DECLARE
  			
BEGIN

    p_template := ( select array_to_json(array_agg(a))
    --- into p_template
     from
     (select * from zeven.zeven_template 
      where is_published = 1
      )a)
     ; 
    
                                                
END;
    

 

  $$;


--
