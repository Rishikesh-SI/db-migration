-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_upd_ad_management(numeric, text, text, numeric)
-- Type: FUNCTION

-- Name: isl_ins_upd_ad_management(numeric, text, text, numeric); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_upd_ad_management(p_id numeric, p_type text, p_ad_code text, p_active numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$     

declare
	
     v_id numeric;
     
BEGIN
	
     IF EXISTS (SELECT ad_id FROM  isl.isl_ad_management WHERE id=p_id ) THEN
     	update isl.isl_ad_management set 
          ad_type= p_type,
          ad_code=p_ad_code,
          active=p_active
          where id=p_id;
  	ELSE
     	v_id := nextval('isl.seq_isl_ad_id');
     	INSERT INTO isl.isl_ad_management
          VALUES(v_id,p_type,p_ad_code,p_active);
	END IF;
	
     p_result := 1;

 exception
 	when others then
 		p_result := -1;

END;

     $$;


--
