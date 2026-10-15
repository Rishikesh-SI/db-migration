-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_user_login(jsonb)
-- Type: FUNCTION

-- Name: tcs_user_login(jsonb); Type: FUNCTION; Schema: tcs; Owner: -
--

CREATE FUNCTION tcs.tcs_user_login(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$    

 

declare 

v_json							jsonb;
v_sysdate						timestamp;
V_username          varchar(2000);
V_password          varchar(2000);
v_is_valid          numeric:=0;
v_USER_ID	NUMERIC:=0;
v_USER_NAME	VARCHAR(300);
v_FULL_NAME	VARCHAR(300);
v_DISPLAY_NAME	VARCHAR(300);
v_PARTNER_ID	VARCHAR(300);
v_EMAIL_ID	VARCHAR(300);
v_PROFILE_PICTURE_URL	VARCHAR(3000);
v_IS_ACTIVE	NUMERIC;
v_IS_DELETED	NUMERIC;
v_IS_PUBLISHED	NUMERIC;
v_USER_GUID	VARCHAR(256);

V_FAILED_ATTEMPTS NUMERIC;
V_MAX_FAILED_ATTEMPTS NUMERIC:=3;
v_unlock_date TIMESTAMP;
v_is_locked numeric;

begin

        v_sysdate:=current_timestamp at time zone 'utc';
        
      -------------------------------------------------------
      
      v_json := '{
                  "success": "",
                  "failed_attempts": "",
                  "is_locked": "",
                  "data": { 
                    "user_id":"",
                    "user_name":"",
                    "full_name":"", 
                    "display_name":"", 
                    "partner_id":"",
                    "email_id":"",
                    "profile_picture_url":"",
                    "is_active":"", 
                    "is_deleted":"",
                    "is_published":"",
                    "user_guid":""
                  }
                }';
      -------------------------------------------------------
      select    p_json->'username',
                p_json->'password'
      into       V_username,
                V_password ;
      V_username:=REPLACE(V_username,'"','');
      V_password:=REPLACE(V_password,'"',''); 
      
      SELECT USER_ID 
      into  v_USER_ID
      FROM tcs.tcs_USER 
      WHERE  USER_NAME=V_username  
      AND USER_PWD=V_password ;         
      
      SELECT count(1) 
      into  v_is_locked
      FROM tcs.tcs_USER 
      WHERE  USER_ID=v_USER_ID AND UNLOCK_DATE >= v_sysdate;  
      
      IF v_USER_ID > 0 and v_is_locked = 0 THEN
          v_json 	         := jsonb_set(v_json, '{success}', 'true'::text::jsonb, true);
          
          SELECT USER_NAME, FULL_NAME, DISPLAY_NAME, PARTNER_ID, EMAIL_ID, 
          COALESCE(PROFILE_PICTURE_URL,''), IS_ACTIVE, IS_DELETED, IS_PUBLISHED, USER_GUID
 
          into v_USER_NAME	,v_FULL_NAME , v_DISPLAY_NAME , v_PARTNER_ID , v_EMAIL_ID , 
          v_PROFILE_PICTURE_URL , v_IS_ACTIVE , v_IS_DELETED , v_IS_PUBLISHED , v_USER_GUID
          FROM tcs.tcs_USER 
          WHERE  USER_ID=v_USER_ID ;  
          
          UPDATE tcs.tcs_USER 
          SET     FAILED_ATTEMPTS = 0
          WHERE  USER_ID=v_USER_ID ;  
          
          v_json 	         := jsonb_set(v_json, '{data,user_id}', ('"'||v_USER_ID||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,email_id}', ('"'||v_EMAIL_ID||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,full_name}',('"'||v_FULL_NAME||'"') ::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,is_active}', ('"'||v_IS_ACTIVE||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,user_guid}', ('"'||v_USER_GUID||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,user_name}', ('"'||v_USER_NAME||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,is_deleted}',('"'||v_IS_DELETED||'"') ::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,partner_id}', ('"'||v_PARTNER_ID||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,display_name}',('"'||v_DISPLAY_NAME||'"') ::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,is_published}', ('"'||v_IS_PUBLISHED||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,profile_picture_url}',('"'||v_PROFILE_PICTURE_URL||'"')::text::jsonb, true);

      ELSE
          
          SELECT USER_ID ,FAILED_ATTEMPTS
              into  v_USER_ID,V_FAILED_ATTEMPTS
          FROM tcs.tcs_USER 
          WHERE  USER_NAME=V_username;
                    
              V_FAILED_ATTEMPTS:=(COALESCE(V_FAILED_ATTEMPTS,0))+1;
              v_unlock_date:= v_sysdate + interval '15 minutes';
              
              UPDATE tcs.tcs_USER 
              SET     FAILED_ATTEMPTS = V_FAILED_ATTEMPTS,
                      UNLOCK_DATE     = CASE WHEN V_FAILED_ATTEMPTS = V_MAX_FAILED_ATTEMPTS 
                                THEN v_unlock_date ELSE UNLOCK_DATE END
              WHERE  USER_ID=v_USER_ID ;  
              
              
          v_json 	         := jsonb_set(v_json, '{failed_attempts}', ('"'||V_FAILED_ATTEMPTS||'"')::text::jsonb, true);  
          v_json 	         := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true); 
          
          IF v_is_locked = 0 THEN
          		v_json 	         := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true); 
          ELSE
          		v_json 	         := jsonb_set(v_json, '{is_locked}', 'true'::text::jsonb, true); 
          END IF;
          
      END IF;
      p_result:=v_USER_ID;
      p_data := v_json;

END;

    $$;


--
