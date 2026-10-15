-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _del_api_error(character varying)
-- Type: FUNCTION

-- Name: _del_api_error(character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._del_api_error(p_schema character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
	 	
		v_sysdate date;
		

	begin
	
		 p_schema := 'labsaw' ;

		v_sysdate := (current_timestamp at time zone 'utc' + '5.5 hours'::interval)::date - '3 day'::interval;
		
		execute 'delete from siwaf.siwaf_client_logs
		where (created_date + ''5.5 hours''::interval)::date  < '''||v_sysdate||'''' ;

		p_result := 1;
	
		
		
				  

	end;
$$;


--
