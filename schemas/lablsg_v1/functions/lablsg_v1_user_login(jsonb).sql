-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_user_login(jsonb)
-- Type: FUNCTION

-- Name: lablsg_v1_user_login(jsonb); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_user_login(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

 

declare 

v_json							jsonb;
v_sysdate						timestamp;
v_username          varchar(2000);
v_password          varchar(2000);
v_is_valid          numeric:=0;
v_user_id	numeric:=0;
v_user_name	varchar(300);
v_full_name	varchar(300);
v_display_name	varchar(300);
v_partner_id	varchar(300);
v_email_id	varchar(300);
v_profile_picture_url	varchar(3000);
v_is_active	numeric;
v_is_deleted	numeric;
v_is_published	numeric;
v_user_guid	varchar(256);

v_failed_attempts numeric;
v_max_failed_attempts numeric:=3;
v_unlock_date timestamp;
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
      into       v_username,
                v_password ;
      v_username:=replace(v_username,'"','');
      v_password:=replace(v_password,'"',''); 
      
      select user_id 
      into  v_user_id
      from lablsg_v1.lablsg_v1_user 
      where  user_name=v_username  
      and user_pwd=v_password ;         
      
      select count(1) 
      into  v_is_locked
      from lablsg_v1.lablsg_v1_user 
      where  user_id=v_user_id and unlock_date >= v_sysdate;  
      
      if v_user_id > 0 and v_is_locked = 0 then
          v_json 	         := jsonb_set(v_json, '{success}', 'true'::text::jsonb, true);
          
          select user_name, full_name, display_name, partner_id, email_id, 
          coalesce(profile_picture_url,''), is_active, is_deleted, is_published, user_guid
 
          into v_user_name	,v_full_name , v_display_name , v_partner_id , v_email_id , 
          v_profile_picture_url , v_is_active , v_is_deleted , v_is_published , v_user_guid
          from lablsg_v1.lablsg_v1_user
          where  user_id=v_user_id ;  
          
          update lablsg_v1.lablsg_v1_user
          set     failed_attempts = 0
          where  user_id=v_user_id ;  
          
          v_json 	         := jsonb_set(v_json, '{data,user_id}', ('"'||v_user_id||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,email_id}', ('"'||v_email_id||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,full_name}',('"'||v_full_name||'"') ::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,is_active}', ('"'||v_is_active||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,user_guid}', ('"'||v_user_guid||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,user_name}', ('"'||v_user_name||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,is_deleted}',('"'||v_is_deleted||'"') ::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,partner_id}', ('"'||v_partner_id||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,display_name}',('"'||v_display_name||'"') ::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,is_published}', ('"'||v_is_published||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,profile_picture_url}',('"'||v_profile_picture_url||'"')::text::jsonb, true);

      else
          
          select user_id ,failed_attempts
              into  v_user_id,v_failed_attempts
          from lablsg_v1.lablsg_v1_user 
          where  user_name=v_username;
                    
              v_failed_attempts:=(coalesce(v_failed_attempts,0))+1;
              v_unlock_date:= v_sysdate + interval '15 minutes';
              
              update lablsg_v1.lablsg_v1_user
              set     failed_attempts = v_failed_attempts,
                      unlock_date     = case when v_failed_attempts = v_max_failed_attempts 
                                then v_unlock_date else unlock_date end
              where  user_id=v_user_id ;  
              
              
          v_json 	         := jsonb_set(v_json, '{failed_attempts}', ('"'||v_failed_attempts||'"')::text::jsonb, true);  
          v_json 	         := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true); 
          
          if v_is_locked = 0 then
          		v_json 	         := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true); 
          else
          		v_json 	         := jsonb_set(v_json, '{is_locked}', 'true'::text::jsonb, true); 
          end if;
          
      end if;
      p_result:=v_user_id;
      p_data := v_json;

end;

 

$$;


--
