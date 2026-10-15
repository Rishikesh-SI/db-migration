-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_upd_club_status(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_upd_club_status(jsonb); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_upd_club_status(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
    v_custom_id numeric;
	v_status numeric;
	v_remark character varying;
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

 select    p_json->'data'->>'custom_id',
			 p_json->'data'->>'remark',
			 p_json->'data'->>'status'

into 
	v_custom_id,
	v_remark,
	v_status;
	
if exists (select 1 from labkc_v1.labkc_v1_custom_web_json where custom_id=v_custom_id) then

update labkc_v1.labkc_v1_custom_web_json
set remark=v_remark,status=v_status
where custom_id=v_custom_id;

p_data:='{
"status":1
}';

else

p_data:='{
"status":0
}';

end if;

end;
$$;


--
