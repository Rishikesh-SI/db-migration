-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_ins_upd_get_calendar(numeric, jsonb)
-- Type: FUNCTION

-- Name: labadkr_ins_upd_get_calendar(numeric, jsonb); Type: FUNCTION; Schema: labadkr; Owner: -
--

CREATE FUNCTION labadkr.labadkr_ins_upd_get_calendar(p_opttype numeric, p_json jsonb, OUT p_team_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

    
	declare
		v_user_guid character varying(500);
		v_calendar_id character varying(500);
		v_current_timestamp timestamp := current_timestamp at time zone 'utc';
		v_user_calendar_id numeric;
		v_type numeric;
		v_cal_id character varying(500);
		v_RefreshToken character varying(500);
		v_user_id  numeric;
		v_season_id numeric;
		/*{
 "data": {
   "teams": [
     {
       "team_name": "Bengaluru Bulls",
       "team_id": "1"
     },
     {
       "team_name": "Bengal Warriors",
       "team_id": "4"
     },
     {
       "team_name": "Dabang Delhi K.C.",
       "team_id": "2"
     },
     {
       "team_name": "Jaipur pink panthers",
       "team_id": "3"
     }
   ],
   "user_guid": "",
   "cal_id": ""
 }
}*/

	BEGIN
	
	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-ins_upd_get_calendar','logs',uuid_generate_v4(),p_json,current_timestamp,'labadkr',p_opttype::character varying);
	
	
	select p_json->'data'->>'user_guid',
           p_json->'data'->>'cal_name',
		   p_json->'data'->>'type',
		   p_json->'data'->>'cal_id',
		   p_json->'data'->>'RefreshToken',
		   p_json->'data'->>'season'
		   into v_user_guid,
		   		v_calendar_id,
				v_type,
				v_cal_id,
				v_RefreshToken,
				v_season_id;
				

	

		if p_opttype = 1 then
			
			select team into p_team_json from labadkr.labadkr_user_calendar
			where  season_id = v_season_id; --user_guid = v_user_guid and
			
			p_result:= 1;
		end if;
		
		if p_opttype = 2 then
			v_user_calendar_id := nextval('labadkr.seq_labadkr_user_calendar_id');
			
-- 			if not exists (select 1 from labadkr.labadkr_user_calendar
-- 							where user_guid = v_user_guid 
-- 						   	and calendar_id = v_calendar_id 
-- 						    and season_id = v_season_id )then
							
				insert into labadkr.labadkr_user_calendar (user_calendar_id,user_guid,calendar_id,team,is_active,
														 is_deleted,created_by,updated_by,created_date,updated_date,type,
														 user_id,social_cal_id,refreshtoken,season_id)
				values(v_user_calendar_id,v_user_guid,v_calendar_id,p_json,1,0,1,1,v_current_timestamp,v_current_timestamp,v_type,
					  v_user_id,v_cal_id,v_RefreshToken,v_season_id);
				
				p_team_json := p_json; 
				p_result:= 1;
-- 			else 
				
-- 				update labadkr.labadkr_user_calendar
-- 				set team = p_json , updated_date = v_current_timestamp,
-- 					social_cal_id = v_cal_id, refreshtoken = v_RefreshToken,
-- 					season_id = v_season_id
-- 				where user_guid = v_user_guid 
-- 				and calendar_id = v_calendar_id
-- 				and season_id = v_season_id;
				
-- 				p_team_json := p_json; 
-- 				p_result:= 1;
-- 		end if; 

	  end if;	

END;

     

$$;


--
