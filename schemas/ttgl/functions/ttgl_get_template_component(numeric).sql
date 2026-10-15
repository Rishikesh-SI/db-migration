-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ttgl_get_template_component(numeric)
-- Type: FUNCTION

-- Name: ttgl_get_template_component(numeric); Type: FUNCTION; Schema: ttgl; Owner: -
--

CREATE FUNCTION ttgl.ttgl_get_template_component(p_templeteid numeric, OUT p_templatecomponent jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

 

DECLARE
 v_json			 varchar(4000) := '{"component":';
  			
BEGIN

     select array_to_json(array_agg(a))
     into p_templatecomponent
     from
     (select * from ttgl.ttgl_template_component_map  
      where is_published = 1
      and (template_id = p_templeteid or coalesce(p_templeteid,0) = 0 )
      )a
     ; 
    
     p_templatecomponent := v_json ||  p_templatecomponent || '}' ;                                         
END;
    

 

 $$;


--
