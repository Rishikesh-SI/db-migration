-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_ins_upd_custom_web_model_24042023(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_ins_upd_custom_web_model_24042023(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_ins_upd_custom_web_model_24042023(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
    v_custom_id numeric;
    v_first_name character varying;
	v_last_name character varying;
	v_email_id character varying;
	v_fan_club_name character varying;
	v_captcha character varying;
    v_module_name character varying;
    v_mobile_no character varying;
	v_user_guid character varying;
	v_datajson jsonb;
begin
/*
{
  "data": {
    "user_info": {
      "first_name": "abc",
      "last_name": "abc",
      "mobile_no": "9876543210",
      "email_id": "abc@gmail.com",
      "country": "",
      "city": ""
    },
    "user_guid": "45e9cdb8-34c2-4807-9d05-7666a1ef547e-06042023035035981",
    "captcha": "03AKH6MRGTxwvug6mXbM1Zxw8i73h_B-gfTqRdY91jbCez_gxbZWNSFoUsf7npulRRi_V-usf4B_aoD50O-eMcH9mRB34bdSr4sVPmzQXHCNJnKKh_WhTmHhHAhg02IqpszxszH2DeXPBS-38jx2qAxNM8VWXAZQACuKtlL9X2exl8HxaeNLMpmfJw598WyBo3I6aLRjhVn4QiGXAiJyjWaJOFEMH0Aev2tv7DqdcxHROtq2HGqyUF1GrbVyv80WaQyjfPud1ClXMmSN2PGWOOe-UO6CG7wwryDzsxM8onuR-AcnH98dNOeCWOaoh2kD4pKsKY55oIqp3T15wNoVkLtz-I7Pm28oRNzP5ClOE8pbJKWmxPyc23sOg8eglloFdY3S4MJrZrL9uFgye7-SI33nO6z3D6Llz0j95RDuU4KVrk4yOuHmipzoRtyoYMMOIlCKoJOYsP3Th3ROMxIxBFA9zof7dhom--f_yyrAeu64CReW3h_XlEdwXjnW5OXh-7Ih5hSzxrXydvqPjHMauuyr4SMJN3HUtxzw",
    "module": "fanclub",
    "club_name": "XYZ",
    "club_description": "dfghkefvbnm",
    "social_ids": ""
  }
}
*/

 select    p_json->'data'->>'module',
		   p_json->'data'->>'user_guid',
		   p_json->'data'->>'captcha',
		   p_json->'data'->'user_info'->>'email_id'
         
into 
	v_module_name,
	v_user_guid,
	v_captcha,
	v_email_id;
	
	--raise notice '%',v_module_name;
                  
				if not exists(select 1 from labkc_v1.labkc_v1_custom_web_json
						 where user_guid = v_user_guid and lower(module_name) = lower(v_module_name))  then
				  
 					v_custom_id:=nextval('labkc_v1.seq_labkc_v1_custom_id');

					insert into labkc_v1.labkc_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
					
					
				else
				
					p_data:='{
					          "data": {
					                  "status":"0"
					                  }
					          }';		
				
				end if;
	

--end if;

end;
$$;


--
