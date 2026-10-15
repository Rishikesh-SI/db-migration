-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_ins_upd_ad_management(numeric, text, text, numeric)
-- Type: FUNCTION

-- Name: hsl_ins_upd_ad_management(numeric, text, text, numeric); Type: FUNCTION; Schema: hsl; Owner: -
--

CREATE FUNCTION hsl.hsl_ins_upd_ad_management(p_id numeric, p_type text, p_ad_code text, p_active numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_id numeric;
     
BEGIN
	
     IF EXISTS (SELECT ad_id FROM  hsl.hsl_ad_management WHERE id=p_id ) THEN
     	update hsl.hsl_ad_management set 
          ad_type= p_type,
          ad_code=p_ad_code,
          active=p_active
          where id=p_id;
  	ELSE
     	v_id := nextval('hsl.seq_hsl_ad_id');
     	INSERT INTO hsl.hsl_ad_management
          VALUES(v_id,p_type,p_ad_code,p_active);
	END IF;
	
     p_result := 1;

 exception
 	when others then
 		p_result := -1;

END;

 $$;


--
