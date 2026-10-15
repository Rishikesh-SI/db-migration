-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_ins_upd_daywise_user_activations_bkp_raf(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_ins_upd_daywise_user_activations_bkp_raf(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_ins_upd_daywise_user_activations_bkp_raf(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
		/* input of function:-
	
	select * from labgt01_v1.labgt01_v1_ins_upd_daywise_user_activations_bkp_raf( 
	'{
  "module_name": "day-1-activity",
  "user_guid": "asdfg",
  "asset_id": "6661"
}') */
	v_module_name character varying(1000);
	v_user_guid character varying(1000);
	v_asset_id numeric;
	v_daywise_user_activity numeric;
	v_asset_type_id numeric;
	v_json jsonb;
	v_status numeric;
	v_msg character varying;
begin

	v_json := p_inputjson;
	select v_json->>'module_name',
		    v_json->>'user_guid',
			v_json->>'asset_id' 
	into v_module_name,
		 v_user_guid,
		 v_asset_id;
		 
	if exists(select 1 from labgt01_v1.labgt01_v1_web_user where user_guid = v_user_guid) then
		 
		v_daywise_user_activity := nextval('labgt01_v1.seq_labgt01_v1_daywise_user_activity_id');
		v_asset_type_id := 141;

		insert into labgt01_v1.labgt01_v1_daywise_user_activity 
		values(v_daywise_user_activity,v_user_guid,v_module_name,v_asset_id,v_asset_type_id,0,v_json,1,0,current_timestamp,current_timestamp);	 

		v_status:= 1;
		v_msg:= 'done';
		
	else
		v_status := 0;
		v_msg := 'user is not present';
		
	end if;

	p_data := '{
				"status": "'|| coalesce(v_status::varchar,'')||'",
				 "message": "'|| coalesce(v_msg,'')||'"
  			}';

    
	

end;
$$;


--
