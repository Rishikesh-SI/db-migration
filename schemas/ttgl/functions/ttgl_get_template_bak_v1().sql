-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ttgl_get_template_bak_v1()
-- Type: FUNCTION

-- Name: ttgl_get_template_bak_v1(); Type: FUNCTION; Schema: ttgl; Owner: -
--

CREATE FUNCTION ttgl.ttgl_get_template_bak_v1(OUT p_template jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

 

DECLARE
  			
BEGIN

     select array_to_json(array_agg(a))
     into p_template
     from
     (select * from ttgl.ttgl_template 
      where is_published = 1
      )a
     ; 
    
                                                
END;
    

 

 $$;


--
