-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_user_login(jsonb, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: gpn_user_login(jsonb, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_user_login(p_json jsonb, p_user_cur refcursor, p_event_cur refcursor, p_sport_cur refcursor, p_language_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

 

declare 

v_json							jsonb;
v_sysdate						timestamp;
V_username          varchar(2000);
V_password          varchar(2000);
v_is_valid          numeric:=0;
v_ADMIN_USER_ID	NUMERIC:=0;
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
v_client_code varchar(50);
v_client_id numeric:=0;
v_success numeric;
v_ret   numeric:=0;

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
                p_json->'password',
                p_json->'client_code'
      into      V_username,
                V_password,
                v_client_code;
                
      V_username:=REPLACE(V_username,'"','');
      V_password:=REPLACE(V_password,'"',''); 
      v_client_code:=REPLACE(v_client_code,'"',''); 
      v_client_code:=lower(v_client_code);
      
      SELECT CLIENT_ID 
      into  v_client_id
      FROM gpn.gpn_client
      WHERE lower(client_code)=v_client_code;         
      
      SELECT ADMIN_USER_ID 
      into  v_ADMIN_USER_ID
      FROM gpn.gpn_admin_user 
      WHERE  USER_NAME=V_username  
      AND USER_PWD=V_password 
      and client_id=v_client_id;         
      
      SELECT count(1) 
      into  v_is_locked
      FROM gpn.gpn_admin_user 
      WHERE  ADMIN_USER_ID=v_ADMIN_USER_ID AND UNLOCK_DATE >= v_sysdate;  
      
      IF v_ADMIN_USER_ID > 0 and v_is_locked = 0 THEN
       --   v_json 	         := jsonb_set(v_json, '{success}', 'true'::text::jsonb, true);
          
          v_success:=1;
          
--          SELECT USER_NAME, FULL_NAME, DISPLAY_NAME, PARTNER_ID, EMAIL_ID, 
--          COALESCE(PROFILE_PICTURE_URL,''), IS_ACTIVE, IS_DELETED, IS_PUBLISHED, USER_GUID
-- 
--          into v_USER_NAME	,v_FULL_NAME , v_DISPLAY_NAME , v_PARTNER_ID , v_EMAIL_ID , 
--          v_PROFILE_PICTURE_URL , v_IS_ACTIVE , v_IS_DELETED , v_IS_PUBLISHED , v_USER_GUID
--          FROM gpn.gpn_admin_user 
--          WHERE  ADMIN_USER_ID=v_ADMIN_USER_ID ;  
          
          UPDATE gpn.gpn_admin_user 
          SET     FAILED_ATTEMPTS = 0,UNLOCK_DATE=null
          WHERE  ADMIN_USER_ID=v_ADMIN_USER_ID ;  
          
--          v_json 	         := jsonb_set(v_json, '{data,user_id}', ('"'||v_USER_ID||'"')::text::jsonb, true);
--          v_json 	         := jsonb_set(v_json, '{data,email_id}', ('"'||v_EMAIL_ID||'"')::text::jsonb, true);
--          v_json 	         := jsonb_set(v_json, '{data,full_name}',('"'||v_FULL_NAME||'"') ::text::jsonb, true);
--          v_json 	         := jsonb_set(v_json, '{data,is_active}', ('"'||v_IS_ACTIVE||'"')::text::jsonb, true);
--          v_json 	         := jsonb_set(v_json, '{data,user_guid}', ('"'||v_USER_GUID||'"')::text::jsonb, true);
--          v_json 	         := jsonb_set(v_json, '{data,user_name}', ('"'||v_USER_NAME||'"')::text::jsonb, true);
--          v_json 	         := jsonb_set(v_json, '{data,is_deleted}',('"'||v_IS_DELETED||'"') ::text::jsonb, true);
--          v_json 	         := jsonb_set(v_json, '{data,partner_id}', ('"'||v_PARTNER_ID||'"')::text::jsonb, true);
--          v_json 	         := jsonb_set(v_json, '{data,display_name}',('"'||v_DISPLAY_NAME||'"') ::text::jsonb, true);
--          v_json 	         := jsonb_set(v_json, '{data,is_published}', ('"'||v_IS_PUBLISHED||'"')::text::jsonb, true);
--          v_json 	         := jsonb_set(v_json, '{data,profile_picture_url}',('"'||v_PROFILE_PICTURE_URL||'"')::text::jsonb, true);

      ELSE
          
          SELECT ADMIN_USER_ID ,FAILED_ATTEMPTS
              into  v_ADMIN_USER_ID,V_FAILED_ATTEMPTS
          FROM gpn.gpn_admin_user 
          WHERE  USER_NAME=V_username;
                    
              V_FAILED_ATTEMPTS:=(COALESCE(V_FAILED_ATTEMPTS,0))+1;
              v_unlock_date:= v_sysdate + interval '15 minutes';
              
              UPDATE gpn.gpn_admin_user 
              SET     FAILED_ATTEMPTS = V_FAILED_ATTEMPTS,
                      UNLOCK_DATE     = CASE WHEN V_FAILED_ATTEMPTS = V_MAX_FAILED_ATTEMPTS 
                                THEN v_unlock_date ELSE UNLOCK_DATE END
              WHERE  ADMIN_USER_ID=v_ADMIN_USER_ID ;  
              
              
--          v_json 	         := jsonb_set(v_json, '{failed_attempts}', ('"'||V_FAILED_ATTEMPTS||'"')::text::jsonb, true);  
--          v_json 	         := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true); 
          
          v_success:=0;
          
          IF v_is_locked = 0 THEN
          		-- v_json 	         := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true); 
              v_success:=0;
--          ELSE
--          		v_json 	         := jsonb_set(v_json, '{is_locked}', 'true'::text::jsonb, true); 
          END IF;
          
      END IF;
     -- p_result:=v_USER_ID;
     -- p_data := v_json;
      IF v_success = 1 THEN
        v_ret:=1;
      ELSIF v_is_locked = 1 THEN
        v_ret:=2;
      ELSE
        v_ret:=0;
      END IF;
      
      IF v_success = 1 THEN
      
      perform 1;
      
        open p_user_cur for
          select v_ret success_status,au.user_name,au.display_name,au.full_name,c.client_id,c.client_name
          from gpn.gpn_admin_user au
          join gpn.gpn_client c
          on au.client_id=c.client_id
          where au.ADMIN_USER_ID=v_ADMIN_USER_ID;
          
        open p_event_cur for
        
          select e.event_id,
          cec.event_id as parent_event_id,-- to ensure parent event id is sent as in case of ISL
          e.event_name,cec.content_type from gpn.gpn_client_event_composition cec 
          join gpn.gpn_event e
          on cec.child_event_id=e.event_id
          where cec.client_id=v_client_id 
          and cec.is_active=1
          and cec.is_deleted=0
          and e.is_active=1
          and e.is_deleted=0
          and cec.for_editorial=1
          order by e.event_name;
        
        open p_sport_cur for
        
          SELECT s.sport_id,s.sport_name,l.league_id,l.league_name,l.source_object_id
          FROM gpn.gpn_client c
          join gpn.gpn_client_league_map cl
          on c.client_id=cl.client_id
          join gpn.gpn_league l
          on cl.league_id=l.league_id
          join gpn.gpn_sport s
          on l.sport_id=s.sport_id
          where c.client_id=v_client_id
          and l.for_editorial=1
          order by s.sport_name;
        
        open p_language_cur for
        
          SELECT  l.language_id,l.language_name from 
          gpn.gpn_language l
          where l.language_id in
          (
          select alm.language_id from gpn.gpn_client_application_map cam
          join gpn.gpn_application_language_map alm
          on cam.application_id=alm.application_id 
          where cam.client_id=v_client_id
          and   cam.is_active=1
          and   cam.is_deleted=0
          and   alm.is_active=1
          and   alm.is_deleted=0)
          order by l.language_name;
      
      ELSE
           open p_user_cur for
            select v_ret success_status;
           open p_event_cur for
            select null;
           open p_sport_cur for
            select null;
           open p_language_cur for
            select null; 
            
      END IF;
END;

$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
