-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_ins_upd_user_access_token(jsonb)
-- Type: FUNCTION

-- Name: labkkr_ins_upd_user_access_token(jsonb); Type: FUNCTION; Schema: labkkr; Owner: -
--

CREATE FUNCTION labkkr.labkkr_ins_upd_user_access_token(p_json jsonb, OUT p_result numeric, OUT p_out_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
     
     v_currenttimestamp    timestamp;
	 v_user_id numeric;
	 v_user_guid text;
	 v_client_id numeric;
	 v_access_token text;
	 v_social_id character varying;
	 v_long_live_access_token text;
     
begin
     v_currenttimestamp := current_timestamp at time zone 'utc';
         
		 select p_json->'data'->>'social_id',
		 		p_json->'data'->>'user_guid',
				p_json->'data'->>'client_id',
				p_json->'data'->>'access_token',
				p_json->'data'->>'long_live_access_token'
		 into v_social_id,
		      v_user_guid,
			  v_client_id,
			  v_access_token,
			  v_long_live_access_token
			  ;
			  
		if not exists(select 1 from labkkr.labkkr_user_acess_token where social_id = v_social_id 
                          and client = v_client_id and user_guid=v_user_guid
				 )then
				 
		 insert into labkkr.labkkr_user_acess_token
		 select null,v_user_guid,v_client_id,v_access_token,v_currenttimestamp,v_social_id,v_long_live_access_token,v_currenttimestamp;
	    
		else
		
		update  labkkr.labkkr_user_acess_token
		set access_token=v_access_token,
		long_live_access_token=v_long_live_access_token,
		updated_date=v_currenttimestamp
		where client=v_client_id and social_id=v_social_id and user_guid=v_user_guid;
		
		
		end if;
     
p_result=1;
p_out_json='{"status":1}';
 /*exception
	 when others then
      p_result := -1;
	  p_out_json='{"status":-1}';*/

end;

 $$;


--
