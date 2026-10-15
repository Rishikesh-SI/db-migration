-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_ins_upd_ad_management(numeric, text, text, numeric)
-- Type: FUNCTION

-- Name: u17wc_ins_upd_ad_management(numeric, text, text, numeric); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_ins_upd_ad_management(p_id numeric, p_type text, p_ad_code text, p_active numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$     

declare
	
     v_id numeric;
     
BEGIN
	
     IF EXISTS (SELECT ad_id FROM  u17wc.u17wc_ad_management WHERE id=p_id ) THEN
     	update u17wc.u17wc_ad_management set 
          ad_type= p_type,
          ad_code=p_ad_code,
          active=p_active
          where id=p_id;
  	ELSE
     	v_id := nextval('u17wc.seq_u17wc_ad_id');
     	INSERT INTO u17wc.u17wc_ad_management
          VALUES(v_id,p_type,p_ad_code,p_active);
	END IF;
	
     p_result := 1;

 exception
 	when others then
 		p_result := -1;

END;

     $$;


--
