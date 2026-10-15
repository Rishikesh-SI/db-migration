-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_ins_upd_institute(json)
-- Type: FUNCTION

-- Name: spz_ins_upd_institute(json); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_ins_upd_institute(p_institutejson json, OUT p_output numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 
 declare 
 v_json json ;
 
 begin 
 	v_json := p_institutejson;
    
  
 	
 
 end 
 

$$;


--
