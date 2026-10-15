-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_daywise_activations(jsonb)
-- Type: FUNCTION

-- Name: labgt_daywise_activations(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_daywise_activations(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
		/* input of function:-
	
	select * from labgt.labgt_check_mobilenum_exist( 
	'{
  "mobile_no": "8108789945",
  "email_id": "abc@gmail.com",
}') */
	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_status numeric;
	v_type numeric;
	v_msg text;

begin
	select p_inputjson->>'mobile_no',
		    p_inputjson->>'email_id',
			p_inputjson->>'type' 
	into v_mobile_no,
		 v_email_id,
		 v_type;
		 
		 -- raise notice '% ,% ',v_mobile_no,v_email_id;
		 

	v_status:= 1;
	v_msg:= 'done';

	p_data := '{
				"status": "'|| coalesce(v_status::varchar,'')||'",
				 "message": "'|| coalesce(v_msg,'')||'"
  			}';

    
	

end;
$$;


--
