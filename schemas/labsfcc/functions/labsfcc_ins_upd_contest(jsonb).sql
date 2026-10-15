-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsfcc
-- Object: labsfcc_ins_upd_contest(jsonb)
-- Type: FUNCTION

-- Name: labsfcc_ins_upd_contest(jsonb); Type: FUNCTION; Schema: labsfcc; Owner: -
--

CREATE FUNCTION labsfcc.labsfcc_ins_upd_contest(p_json jsonb, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	declare 
	 	
		v_sysdate timestamp;
		v_contest_id numeric;
		v_southampton_homeground character varying(300);
		v_southampton_mainsponsor character varying(300);
		v_southampton_nickname character varying(300);
		v_firstname character varying(300);
		v_lastname character varying(300);
		v_sportsbetusername character varying(300);
		v_email character varying(300);
		v_postal_address character varying(500);
		v_agree_tc boolean;

	begin

		v_sysdate := current_timestamp at time zone 'utc';

		select   p_json->'Data'->>'southampton_homeground',
         p_json->'Data'->>'southampton_mainsponsor', 
         p_json->'Data'->>'southampton_nickname',
         p_json->'Data'->>'firstname',
		 p_json->'Data'->>'lastname', 
		 p_json->'Data'->>'sportsbetusername',
		 p_json->'Data'->>'email', 
		 p_json->'Data'->>'postal_address', 
		 p_json->'Data'->>'agree_tc'
         into
         v_southampton_homeground,
         v_southampton_mainsponsor,
         V_southampton_nickname,
         v_firstname,
		 v_lastname,
		 v_sportsbetusername,
		 v_email,
		 v_postal_address,
		 v_agree_tc;
		 
		 if not exists(select 1 from labsfcc.labsfcc_contest where sportsbetusername = v_sportsbetusername)
            then 
			
			  v_contest_id := nextval('labsfcc.labsfcc_contest_contest_id_seq'); 
              insert into 	labsfcc.labsfcc_contest
			  (contest_id,southampton_homeground,southampton_mainsponsor,southampton_nickname,
			  firstname,lastname,sportsbetusername,email,postal_address,agree_tc,created_date,updated_date)
			  values(v_contest_id,v_southampton_homeground,v_southampton_mainsponsor,v_southampton_nickname,
			  v_firstname,v_lastname,v_sportsbetusername,v_email,v_postal_address,v_agree_tc,v_sysdate,v_sysdate);
			  
			  p_result:='{"status":1}';
			  
		else 
		
		  p_result:='{"status":2}';
			
		end if;

	end;

	$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
