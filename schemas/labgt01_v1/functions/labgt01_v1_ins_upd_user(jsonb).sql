-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_ins_upd_user(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_ins_upd_user(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_ins_upd_user(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare 
	
	v_emailid             varchar(2000);
	v_resetkey            varchar(2000);
	v_json			  jsonb;
	v_sysdate			  timestamp;
	v_username            varchar(2000);
	v_password            varchar(2000);
	v_oldpassword         varchar(2000);
	v_is_valid            numeric := 0;
	v_user_id			  numeric := 0;
	v_user_name		  varchar(300);
	v_full_name		  varchar(300);
	v_display_name		  varchar(300);
	v_partner_id		  varchar(300);
	v_email_id		  varchar(300);
	v_profile_picture_url varchar(3000);
	v_is_active	       numeric;
	v_is_deleted	       numeric;
	v_is_published	       numeric;
	v_user_guid	       varchar(256);
	v_updated_by          numeric;
	v_failed_attempts     numeric;
	v_max_failed_attempts numeric := 3;
	v_unlock_date         timestamp;
	v_is_locked           numeric;
	v_opt_type            numeric := -1;
	v_status              numeric;
	v_reset_key           varchar(256);
	v_key_expiry_date     timestamp;
	v_rolejson            json;
	v_roledata            jsonb;
	v_role_id             numeric;
	v_userroleid          numeric;
	v_userroleguid        varchar(256);
	
begin
	
	v_sysdate := current_timestamp at time zone 'utc';
	v_key_expiry_date := v_sysdate + interval '15 minutes';
	
	v_json := '{
  "success": "",
  "failed_attempts": "",
  "is_locked": "",
  "data": {
    "user_id": "",
    "user_name": "",
    "full_name": "",
    "display_name": "",
    "partner_id": "",
    "email_id": "",
    "profile_picture_url": "",
    "is_active": "",
    "is_deleted": "",
    "is_published": "",
    "user_guid": "",
    "reset_key": ""
  }
}';
	
	select p_json->>'user_id',
		   p_json->>'email_id',
		   p_json->>'user_name',
		   p_json->>'full_name',
		   p_json->>'display_name',
		   p_json->>'partner_id',
		   p_json->>'profile_picture_url',
		   p_json->>'updated_by',
		   p_json->>'status',
		   p_json->>'guid',
		   p_json->>'reset_key',
		   p_json->>'password',
		   p_json->>'old_password',
		   p_json->>'opt_type'
	into   v_user_id,
		   v_emailid,
		   v_username,
		   v_full_name,
		   v_display_name,
		   v_partner_id,
		   v_profile_picture_url,
		   v_updated_by,
		   v_status,
		   v_user_guid,
		   v_resetkey,
		   v_password,
		   v_oldpassword,
		   v_opt_type;
	
	v_emailid:=replace(v_emailid,'"','');
	v_username:=replace(v_username,'"',''); 
	v_full_name:=replace(v_full_name,'"','');
	v_display_name:=replace(v_display_name,'"','');
	v_partner_id:=replace(v_partner_id,'"','');
	v_profile_picture_url:=replace(v_profile_picture_url,'"','');
	v_updated_by:=v_updated_by;
	v_status:=v_status;
	v_user_guid:=replace(v_user_guid,'"','');
	v_resetkey:=replace(v_resetkey,'"',''); 
	v_password:=replace(v_password,'"',''); 
	v_oldpassword:=replace(v_oldpassword,'"','');  
	
	if v_opt_type = 0 then
		
		v_json:=p_json;
		
		if v_user_id is not null then
			
			update labgt01_v1.labgt01_v1_user
			set
			user_name=v_username, full_name=v_full_name, display_name=v_display_name, 
			partner_id=v_partner_id, email_id=v_emailid, profile_picture_url=v_profile_picture_url, 
			updated_date=v_sysdate, updated_by=v_updated_by, is_active=1, is_deleted=0,
			is_published=v_status
			where user_id=v_user_id;
			
		else
			
			v_user_id   := nextval('labgt01_v1.seq_labgt01_v1_user_id');
			v_user_guid := uuid_generate_v4();
			
			insert into labgt01_v1.labgt01_v1_user(
			user_id, user_name, full_name, display_name, partner_id, email_id, profile_picture_url,
			created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published, 
			user_guid, user_pwd, reset_key, key_expiry_date, failed_attempts, unlock_date)
			values (v_user_id, v_username,v_full_name,v_display_name	,v_partner_id	,
			v_emailid, v_profile_picture_url, v_sysdate, v_sysdate, v_updated_by, v_updated_by,
			1, 0, v_status, v_user_guid, v_password, null, null, null, null);
			
			v_json 	         := jsonb_set(v_json, '{data,user_id}', ('"'||v_user_id||'"')::text::jsonb, true);
			v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_user_guid||'"')::text::jsonb, true);
			
		end if;
		
		select v_json->'data'->>'user_role'
		into   v_rolejson;
		
		if v_rolejson is not null then
			
			delete
			from   labgt01_v1.labgt01_v1_user_role
			where  user_id = v_user_id;
			
			for v_roledata in select * from json_array_elements(v_rolejson)
			loop
				
				select v_roledata->>'role_id' 
				into   v_role_id ;
				
				if (v_role_id is not null and v_user_id is not null) then
					
					v_userroleid := nextval('labgt01_v1.seq_labgt01_v1_user_role_id');
					v_userroleguid := uuid_generate_v4();
					
					insert into labgt01_v1.labgt01_v1_user_role(
					user_role_id, user_id, role_id, created_date, updated_date, created_by, 
					updated_by, is_active, is_deleted, is_published, user_role_guid)
					values (v_userroleid, v_user_id, v_role_id, v_sysdate, v_sysdate, v_updated_by,
					v_updated_by, 1, 0, 1, v_userroleguid);              
					
				end if;
				
			end loop;
			
		end if;
		
	elsif v_opt_type = 1 and v_emailid is not null then
	-- forgot username using email_id
		
		select user_name into v_user_name from labgt01_v1.labgt01_v1_user where email_id = v_emailid;
		v_json 	         := jsonb_set(v_json, '{data,user_name}', ('"'||v_user_name||'"')::text::jsonb, true);
		
	elsif v_opt_type = 2 and v_username is not null then
	-- forgot password using username
		
		v_reset_key := uuid_generate_v4() ;
		
		select email_id  into v_emailid from labgt01_v1.labgt01_v1_user where user_name=v_username;
		
		update labgt01_v1.labgt01_v1_user 
		set     reset_key = v_reset_key,
		key_expiry_date = v_key_expiry_date,
		updated_date=v_sysdate
		where  user_name=v_username ;  
		
		v_json 	 := jsonb_set(v_json, '{data,reset_key}', ('"'||v_reset_key||'"')::text::jsonb, true);
		v_json 	 := jsonb_set(v_json, '{data,email_id}', ('"'||v_emailid||'"')::text::jsonb, true);
		
	elsif v_opt_type = 3 and v_username is not null and v_resetkey is not null and v_password is not null then
	-- update password using reset_key
		
		select user_id 
		into  v_user_id
		from labgt01_v1.labgt01_v1_user 
		where  user_name=v_username and reset_key=v_resetkey and key_expiry_date >= v_sysdate;   
		
		select count(1) 
		into  v_is_locked
		from labgt01_v1.labgt01_v1_user 
		where  user_id=v_user_id and unlock_date >= v_sysdate; 
		
		if v_user_id > 0 and v_is_locked = 0 then
			
			v_json 	         := jsonb_set(v_json, '{success}', 'true'::text::jsonb, true);
			
			select user_name, full_name, display_name, partner_id, email_id, 
			profile_picture_url, is_active, is_deleted, is_published, user_guid
			into v_user_name	,v_full_name , v_display_name , v_partner_id , v_email_id , 
			v_profile_picture_url , v_is_active , v_is_deleted , v_is_published , v_user_guid
			from labgt01_v1.labgt01_v1_user 
			where  user_id=v_user_id ;  
			
			update labgt01_v1.labgt01_v1_user 
			set     failed_attempts = 0,user_pwd=v_password,
			updated_date=v_sysdate
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
			from labgt01_v1.labgt01_v1_user 
			where  user_name=v_username;
			
			v_failed_attempts:=(coalesce(v_failed_attempts,0))+1;
			v_unlock_date:= v_sysdate + interval '15 minutes';
			
			update labgt01_v1.labgt01_v1_user 
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
		
	elsif v_opt_type = 4 and v_username is not null and v_oldpassword is not null and v_password is not null then
	-- update password using reset_key
		
		select user_id 
		into  v_user_id
		from labgt01_v1.labgt01_v1_user 
		where  user_name=v_username and user_pwd=v_oldpassword;   
		
		select count(1) 
		into  v_is_locked
		from labgt01_v1.labgt01_v1_user 
		where  user_id=v_user_id and unlock_date >= v_sysdate; 
		
		if v_user_id > 0 and v_is_locked = 0 then
			
			v_json 	         := jsonb_set(v_json, '{success}', 'true'::text::jsonb, true);
			select user_name, full_name, display_name, partner_id, email_id, 
			profile_picture_url, is_active, is_deleted, is_published, user_guid
			
			into v_user_name	,v_full_name , v_display_name , v_partner_id , v_email_id , 
			v_profile_picture_url , v_is_active , v_is_deleted , v_is_published , v_user_guid
			from labgt01_v1.labgt01_v1_user 
			where  user_id=v_user_id ;  
			
			update labgt01_v1.labgt01_v1_user 
			set     failed_attempts = 0,user_pwd=v_password,
			updated_date=v_sysdate
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
			from labgt01_v1.labgt01_v1_user 
			where  user_name=v_username;
			
			v_failed_attempts:=(coalesce(v_failed_attempts,0))+1;
			v_unlock_date:= v_sysdate + interval '15 minutes';
			
			update labgt01_v1.labgt01_v1_user 
			set     failed_attempts = v_failed_attempts,
			unlock_date     = case when v_failed_attempts = v_max_failed_attempts 
			then v_unlock_date else unlock_date end
			where  user_id=v_user_id;
			
			v_json 	         := jsonb_set(v_json, '{failed_attempts}', ('"'||v_failed_attempts||'"')::text::jsonb, true);  
			v_json 	         := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true); 
			
			if v_is_locked = 0 then
				v_json 	         := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true); 
			else
				v_json 	         := jsonb_set(v_json, '{is_locked}', 'true'::text::jsonb, true); 
			end if;
			
		end if;
		
	end if;
	
	p_result:=v_user_id;
	p_data := v_json;
	
end;

 $$;


--
