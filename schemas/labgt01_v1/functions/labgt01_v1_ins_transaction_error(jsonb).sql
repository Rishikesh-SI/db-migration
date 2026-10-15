-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_ins_transaction_error(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_ins_transaction_error(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_ins_transaction_error(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
		v_client_name character varying;
        v_servicetype character varying;
        v_inputinfo character varying;
        v_eventtype character varying;
        v_email_id character varying;
        v_user_guid character varying;
        v_user_id numeric;
        v_operationalid character varying;
        v_error text;
        v_country_code character varying;
        v_mobile_no character varying;
		v_status boolean;
		v_ref_id character varying;
		v_method character varying;
	begin

		select p_json->>'client_name',
               p_json->>'servicetype',
			   p_json->>'inputinfo',
			   p_json->>'eventtype',
			   p_json->>'email_id',
			   p_json->>'user_guid',
               p_json->>'user_id',
               p_json->>'error',
               p_json->>'operationalid',
               p_json->>'country_code',
               p_json->>'mobile_no',
			   p_json->'status',
			   p_json->>'ref_id',
			   p_json->>'method'
		into   v_client_name,
			   v_servicetype,
			   v_inputinfo,
			   v_eventtype,
			   v_email_id,
               v_user_guid,
               v_user_id,
               v_error,
               v_operationalid,
               v_country_code,
               v_mobile_no,
			   v_status,
			   v_ref_id,
			   v_method;
			   
		INSERT INTO labgt01_v1.labgt01_v1_transaction_logs(
	client_name, user_id, servicetype, email_id, eventtype, user_guid, input_json,error,created_date,operational_id,country_code,mobile_no,
	status,ref_id,method)
	VALUES (v_client_name, v_user_id, v_servicetype, v_email_id, v_eventtype, v_user_guid, v_inputinfo,v_error,current_timestamp,v_operationalid,v_country_code,v_mobile_no,
	v_status,v_ref_id,v_method); 
	   

		
        p_result:= 1;
			  

	end;
$$;


--
