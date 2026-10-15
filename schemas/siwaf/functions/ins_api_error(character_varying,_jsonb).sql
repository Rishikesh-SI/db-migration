-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_api_error(character varying, jsonb)
-- Type: FUNCTION

-- Name: _ins_api_error(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_api_error(p_schema character varying, p_json jsonb, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
declare 
	 	
		v_sysdate timestamp;
		v_client_logs_id numeric;
		v_api_name text;
		v_api_url text;
		v_count numeric;
		v_start_date timestamp;
		v_alert_flag numeric;
		v_log_guid character varying;
		client_name character varying;
		log_type text;
		

	begin

		v_sysdate := current_timestamp at time zone 'utc';
		v_start_date := v_sysdate - '5 minute'::interval ;

		select p_json->>'log_method_name',
			   p_json->>'log_error_message',
			   p_json->>'log_guid',
			   p_json->>'client_name',
			   p_json->>'log_type'
		into   v_api_name,
			   v_api_url,
			   v_log_guid,
			   client_name,
			   log_type;
			   
		execute 'select count(1) from siwaf.siwaf_client_logs
				 where log_guid = $1'
		into v_count		 
		using v_log_guid;
		
		raise notice '%',v_count;

        if v_count = 0 then

		execute 'select nextval(''siwaf.seq_siwaf_api_error_log_id'')' 
		into v_client_logs_id;
		
		execute 'insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
					log_error_message,log_guid,error_json,created_date,client_name,log_type)
				values ($1,$2,$3,$4,$5,$6,$7,$8)'
		using v_client_logs_id,v_api_name,v_api_url,v_log_guid,p_json,v_sysdate,client_name,log_type;
		
		
		else 
		  execute 'update siwaf.siwaf_client_logs
		  			set log_method_name = $1,
						error_json = $2,
						created_date = $3
					where log_guid = $4 '
		  using v_api_name,	p_json,	v_sysdate,v_log_guid;
		  
		 end if;
		 
		execute 'select count(1) from siwaf.siwaf_client_logs 
				where log_method_name = $1 and  created_date between $2 and $3 '
		into  v_count
		using v_api_name,v_start_date,v_sysdate;
			
		
		if  v_count >= 4 then 
			
			v_alert_flag = 1 ;
			p_json := jsonb_set(p_json,'{alert_flag}',('"'||v_alert_flag||'"')::text::jsonb,true);
		else
			v_alert_flag = 0 ;
			p_json := jsonb_set(p_json,'{alert_flag}',('"'||v_alert_flag||'"')::text::jsonb,true);
			
		end if;
		p_result := p_json;
		
		/*exception when others then 
		
		p_result:= '{}'::jsonb;*/

		
				  

	end;
$_$;


--
