-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_ins_kid(jsonb)
-- Type: FUNCTION

-- Name: stn_ins_kid(jsonb); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_ins_kid(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

/*
{
  "kid_data": [
    {
      "first_name": null,
      "last_name": null,
      "dob": null,
      "gender": null,
      "city": null,
      "state": null
    },
    {
      "first_name": null,
      "last_name": null,
      "dob": null,
      "gender": null,
      "city": null,
      "state": null
    }
  ],
  "user_id":null,
  "team_id": null
}
*/
declare
	
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_team_id numeric;
	v_parent_id numeric;
	v_kid_data json;
	v_json json;
	v_counter numeric := 0;
	v_user_id numeric;
	v_team_user_map_id numeric;
	v_first_name text;
	v_last_name text;
	v_dob text;
	v_gender char(1);
	v_city numeric;
	v_state numeric;
	v_user_name text;
	v_user_password text;
	v_region_name text;
	
begin
	
	select p_json->>'team_id',
			p_json->>'user_id',
			(p_json->'kid_data')::json
	into v_team_id,
			v_parent_id,
			v_kid_data;
	
	for v_json in select * from json_array_elements(v_kid_data)
	loop
		
		v_counter := v_counter + 1;
		v_user_id := nextval('stn.seq_stn_game_user_id');
		v_team_user_map_id := nextval('stn.seq_stn_team_user_map_id');
		
		select v_json->>'first_name',
				v_json->>'last_name',
				v_json->>'dob',
				v_json->>'gender',
				v_json->>'city',
				v_json->>'state',
				v_json->>'user_name',
				v_json->>'password'
		into v_first_name,
				v_last_name,
				v_dob,
				v_gender,
				v_city,
				v_state,
				v_user_name,
				v_user_password;
		
		select rm.region_name
		into v_region_name
		from stn.stn_region_master rm
		join stn.stn_state_master sm
		on sm.region_id = rm.region_id
		join stn.stn_city_master cm
		on cm.state_id = sm.state_id
		where cm.city_id = v_city
		and cm.state_id = v_state;
		
		insert into stn.stn_user_info(user_id,user_name,user_password,first_name,last_name,email_id,gender,mobile_no,dob,state_id,city_id,region,
												age_category,is_kid,parent_id,created_date,updated_date,is_active,is_deleted,user_guid)
		select v_user_id,v_user_name,v_user_password,v_first_name,v_last_name,null,v_gender,null,v_dob::date,v_state,v_city,v_region_name,null,1,
				v_parent_id,v_current_timestamp,v_current_timestamp,1,0,uuid_generate_v4();
		
		insert into stn.stn_team_user_map(team_user_map_id,team_id,user_id,player_no,created_date,updated_date,is_active,is_deleted,tum_guid)
		select v_team_user_map_id,v_team_id,v_user_id,v_counter,v_current_timestamp,v_current_timestamp,1,0,uuid_generate_v4();
		
	end loop;
	
	p_result := 1;
	
end;

$$;


--
