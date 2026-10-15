-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_template_bak_v1()
-- Type: FUNCTION

-- Name: zeven_get_template_bak_v1(); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_template_bak_v1(OUT p_template jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$  

 

DECLARE
  			
BEGIN

     select array_to_json(array_agg(a))
     into p_template
     from
     (select * from zeven.zeven_template 
      where is_published = 1
      )a
     ; 
    
                                                
END;
    

 

  $$;


--
