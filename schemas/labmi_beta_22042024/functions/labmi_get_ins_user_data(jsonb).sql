-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_ins_user_data(jsonb)
-- Type: FUNCTION

-- Name: labmi_get_ins_user_data(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_ins_user_data(p_insertjson jsonb, OUT p_outputjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
    v_mobie_no character varying(1000);
	v_gender character varying(1000);
	v_dob character varying(1000);
	
/*select * from labmi.labmi_get_ins_user_data('
{
"data": {
"mobile_no": "8286738047",
"dob": "1995-09-22",
"gender": "male"
}
}
');*/	
    
begin
	select p_insertjson->'data'->>'mobile_no',
	p_insertjson->'data'->>'dob',
	p_insertjson->'data'->>'gender'
	into v_mobie_no,v_dob,v_gender;
	
	/*raise notice 'v_mobie_no:%',v_mobie_no;
	raise notice 'v_dob:%',v_dob;
	raise notice 'v_gender:%',v_gender;
	select 1/0;*/
--select * from labmi.labmi_user_whatsapp_bot;	   
--labmi.labmi_user_whatsapp_bot
	if not exists (select 1 from labmi.labmi_user_whatsapp_bot luwb
					where luwb.mobile_no=v_mobie_no) then

		insert into labmi.labmi_user_whatsapp_bot  (mobile_no,dob,gender) 
		values (v_mobie_no,v_dob,v_gender);
			p_outputjson:='{
				"status":"1",
				 "msg":"user data saved"
			  }';
  
  	else 
			  p_outputjson:='{
				"status":"2",
				 "msg":"user data already exist"
			  }';
	end if;

end;

$$;


--
