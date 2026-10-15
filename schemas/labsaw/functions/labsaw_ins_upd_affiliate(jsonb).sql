-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_ins_upd_affiliate(jsonb)
-- Type: FUNCTION

-- Name: labsaw_ins_upd_affiliate(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_ins_upd_affiliate(p_json jsonb, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
/*{
"data": {
"affliate_id": "1",
"affliate_name": "BET",
"affiliate_signup": 1,
"affiliate_deposit": 1,
"affiliate_account_no": "",
"user_guid": "ba4549e3-a01b-42d2-a3f3-f237fa4b4ec1"
}
}*/
	v_affliate_id numeric;
    v_affliate_name character varying;
	v_affiliate_signup numeric;
	v_affiliate_deposit numeric;
    v_affiliate_account_no character varying;
	v_user_guid character varying;
	
	begin
    
	select p_json->'data'->>'affliate_id',
		   p_json->'data'->>'affliate_name',
		   p_json->'data'->>'affiliate_signup',
		   p_json->'data'->>'affiliate_deposit',
		   p_json->'data'->>'affiliate_account_no',
		   p_json->'data'->>'user_guid'
	into   v_affliate_id,
	       v_affliate_name,
		   v_affiliate_signup,
		   v_affiliate_deposit,
		   v_affiliate_account_no,
		   v_user_guid ;
	
	insert into labsaw.labsaw_affliate_data(affliate_data_id,affliate_id,affliate_name,affiliate_signup,
										   affiliate_deposit,affiliate_account_no,user_guid ,created_date,
										   is_approved,affliate_json)										   
     values(nextval('labsaw.seq_labsaw_affliate_data_id'),v_affliate_id,v_affliate_name,v_affiliate_signup,v_affiliate_deposit,
		   v_affiliate_account_no,v_user_guid,current_timestamp at time zone 'utc',0,p_json);
		   
	-- p_result := 1;	   
   
     p_result := '{
	 "status" : 1
	 }';
	 
   
     exception
     when others then
     p_result := '{ "status" : -1}';
	  
	  
     
end;
$$;


--
