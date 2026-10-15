-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_login_signup_game_user(jsonb)
-- Type: FUNCTION

-- Name: stn_login_signup_game_user(jsonb); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_login_signup_game_user(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

/*
{
  "data": {
    "option_type": 1,
    "user_name": "AayushR",
    "user_password": "aayush@123",
    "first_name": "Aayush",
    "last_name": "Rastogi",
    "email_id": "aayush@sportzinteractive.net",
    "gender": "M",
    "mobile_no": "9102313661"
  }
}
*/
declare
	
    v_current_timestamp timestamp without time zone := current_timestamp at time zone 'utc';
    v_json jsonb := p_json;
    v_option_type numeric;
    v_user_name text;
    v_user_password text;
    v_first_name text;
    v_last_name text;
    v_email_id text;
    v_gender char(1);
    v_mobile_no text;
	v_user_id numeric;
    
begin
	
    select v_json->'data'->>'option_type'
    into v_option_type;
	
    if v_option_type = 1 then
    	
    	select trim(v_json->'data'->>'user_name'),
        		trim(v_json->'data'->>'user_password')
		into v_user_name,
        		v_user_password;
        
        if exists(select 1 from stn.stn_user_info where user_name = v_user_name and user_password = v_user_password) then
            
            p_result := 1;
            
		else
        	
            p_result := 0;
            
        end if;
        
    elsif v_option_type = 2 then
    	
        select trim(v_json->'data'->>'first_name'),
        		trim(v_json->'data'->>'last_name'),
                trim(v_json->'data'->>'email_id'),
                trim(v_json->'data'->>'gender'),
                trim(v_json->'data'->>'mobile_no'),
                trim(v_json->'data'->>'user_name'),
                trim(v_json->'data'->>'user_password')
		into v_first_name,
        		v_last_name,
                v_email_id,
                v_gender,
                v_mobile_no,
                v_user_name,
                v_user_password;
		
		if not exists(select 1 from stn.stn_user_info where upper(trim(email_id)) = upper(v_email_id)) then
			
			insert into stn.stn_user_info(user_id,user_name,user_password,first_name,last_name,email_id,gender,mobile_no,dob,state_id,city_id,region,
													age_category,is_kid,parent_id,created_date,updated_date,is_active,is_deleted,user_guid)
			select nextval('stn.seq_stn_game_user_id'),v_user_name,v_user_password,v_first_name,v_last_name,v_email_id,v_gender,v_mobile_no,
					null,null,null,null,null,0,null,v_current_timestamp,v_current_timestamp,1,0,uuid_generate_v4();
			
			p_result := 1;
			
		else
			
			p_result := 0;
			
		end if;
		
	elsif v_option_type = 3 then
		
		select p_user_json->'data'->>'user_id'
        into   v_user_id;
        
        update stn.stn_user_info set is_verified = 1 where user_id = v_user_id;
		
		p_result := 1;
		
    else
    	
    	p_result := -1;
        
    end if;
    
end;

$$;


--
