-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_ins_upd_user_ar(jsonb)
-- Type: FUNCTION

-- Name: labboost_ins_upd_user_ar(jsonb); Type: FUNCTION; Schema: labboost; Owner: -
--

CREATE FUNCTION labboost.labboost_ins_upd_user_ar(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sysdate			   timestamp;
    v_key_expiry_date      timestamp;
    v_result_json          jsonb;
    v_json			       jsonb;
    v_user_id			   numeric := 0;
    v_email_id             varchar(2000);
    v_user_name            varchar(2000);
    v_full_name		       varchar(300);
	v_display_name		   varchar(300);
	v_partner_id		   varchar(300);
    v_profile_picture_url  varchar(3000);
    v_updated_by           numeric;
    v_is_published         numeric;
    v_user_guid	           varchar(256);
    v_reset_key            varchar(256);
    v_password             varchar(2000);
    v_old_password         varchar(2000);
    v_opt_type             numeric := -1;
    v_bio			       text;
    v_role_json            json;
    v_role_data            jsonb;
    v_role_id              numeric;
	v_user_role_id         numeric;
	v_user_role_guid       varchar(256);
    v_is_locked            numeric;
    v_is_deleted	       numeric;
    v_failed_attempts      numeric;
    v_unlock_date          timestamp;
    v_is_active            numeric := 0;
    v_userlangjson         json;
    v_userlang             json;
    v_langid               numeric;
    v_lang_master_id       numeric;
    v_lang_name            varchar(4000);
    v_user_language_map_id numeric;
    v_action char(1);
	
begin
	
	v_sysdate         := current_timestamp at time zone 'utc';
	v_key_expiry_date := v_sysdate + interval '15 minutes';
	v_json            := p_json;
    
	select v_json->'data'->>'user_id',
		   v_json->'data'->>'email_id',
		   v_json->'data'->>'user_name',
		   v_json->'data'->>'full_name',
		   v_json->'data'->>'display_name',
		   v_json->'data'->>'partner_id',
		   v_json->'data'->>'profile_picture_url',
		   v_json->'data'->>'updated_by',
		   v_json->'data'->>'is_published',
		   v_json->'data'->>'guid',
		   v_json->'data'->>'reset_key',
		   v_json->'data'->>'password',
		   v_json->'data'->>'old_password',
		   v_json->'data'->>'opt_type',
           v_json->'data'->>'bio',
           v_json->'data'->>'is_active',
           v_json->'data'->'user_data'
	into   v_user_id,
		   v_email_id,
		   v_user_name,
		   v_full_name,
		   v_display_name,
		   v_partner_id,
		   v_profile_picture_url,
		   v_updated_by,
		   v_is_published,
		   v_user_guid,
		   v_reset_key,
		   v_password,
		   v_old_password,
		   v_opt_type,
           v_bio,
           v_is_active,
           v_userlangjson;
	
	if v_opt_type = 0 then
	-- insert / update user	
		if v_userlangjson is not null then
        	
            if v_user_id is not null then
            	v_action := 'u';
			else
            	v_action    := 'i';
                v_user_id   := nextval('labboost.seq_labboost_user_id');
            	v_user_guid := uuid_generate_v4();
            end if;
            
            for v_userlang in select * from json_array_elements(v_userlangjson)
            loop
            	
                select v_userlang->>'lang_id', v_userlang->>'full_name', v_userlang->>'display_name', v_userlang->>'bio'
                into   v_langid, v_full_name, v_display_name, v_bio;
                
                select em.entity_master_id, entity_name
                into   v_lang_master_id, v_lang_name
                from   labboost.labboost_entity_master em
                join   labboost.labboost_entity_role_map erm
                on     erm.entity_master_id   = em.entity_master_id
                where  erm.entity_role_map_id = v_langid;
                
                if v_lang_name = 'english' then
                	
                    if v_action = 'i' then
                    	insert into labboost.labboost_user(user_id, user_name, full_name, display_name, partner_id, email_id, profile_picture_url, created_date,
                                                 updated_date, created_by, updated_by, is_active, is_deleted, is_published, user_guid, user_pwd,
                                                 reset_key, key_expiry_date, failed_attempts, unlock_date, bio)
						values (v_user_id, v_user_name, v_full_name, v_display_name, v_partner_id, v_email_id, v_profile_picture_url, v_sysdate,
                                v_sysdate, v_updated_by, v_updated_by, v_is_active, 0, v_is_published, v_user_guid, v_password, null, null, null, null,
                                v_bio);
                    else
                    	update labboost.labboost_user
						set    user_name           = v_user_name,
                        	   full_name           = v_full_name,
                               display_name        = v_display_name,
                               partner_id          = v_partner_id,
                               email_id            = v_email_id,
                               profile_picture_url = v_profile_picture_url,
                               updated_date        = v_sysdate,
                               updated_by          = v_updated_by,
                               is_active           = v_is_active,
                               is_deleted          = 0,
                               is_published        = v_is_published,
                               bio                 = v_bio
						where  user_id             = v_user_id;
                    end if;
                    
				else
                	
                    if v_action = 'i' then
                        v_user_language_map_id := nextval('labboost.seq_labboost_user_language_map_id');
                        insert into labboost.labboost_user_language_map(user_language_map_id, user_id, language_master_id, user_name, full_name, display_name,
                                                              created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published,
                                                              bio)
						values (v_user_language_map_id, v_user_id, v_lang_master_id, v_user_name, v_full_name, v_display_name, v_sysdate, v_sysdate,
                                v_updated_by, v_updated_by, v_is_active, 0, v_is_published, v_bio);
                    else
                    	update labboost.labboost_user_language_map
						set    user_name           = v_user_name,
                        	   full_name           = v_full_name,
                               display_name        = v_display_name,
                               updated_date        = v_sysdate,
                               updated_by          = v_updated_by,
                               is_active           = v_is_active,
                               is_deleted          = 0,
                               is_published        = v_is_published,
                               bio                 = v_bio
						where  user_id             = v_user_id
                        and    language_master_id  = v_lang_master_id;
                    end if;
                    
				end if;
                
			end loop;
            
		end if;
        
        if v_action = 'i' then
        	v_json := jsonb_set(v_json, '{data,user_id}', v_user_id::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,user_guid}', ('"'||v_user_guid||'"')::text::jsonb, true);
		end if;
        
		select v_json->'data'->>'user_role'
		into   v_role_json;
		
		if v_role_json is not null then
        	
            delete
			from   labboost.labboost_user_role
			where  user_id = v_user_id;
			
			for v_role_data in select * from json_array_elements(v_role_json)
			loop
				
				select v_role_data->>'role_id' 
				into   v_role_id ;
				
				if v_role_id is not null then
					
					v_user_role_id   := nextval('labboost.seq_labboost_user_role_id');
					v_user_role_guid := uuid_generate_v4();
					
					insert into labboost.labboost_user_role(user_role_id, user_id, role_id, created_date, updated_date, created_by, updated_by, is_active,
                                                  is_deleted, is_published, user_role_guid)
					values (v_user_role_id, v_user_id, v_role_id, v_sysdate, v_sysdate, v_updated_by, v_updated_by, v_is_active, 0, v_is_published,
                            v_user_role_guid);
					
				end if;
				
			end loop;
			-- v_result_json:=v_json;
		end if;
        
	elsif v_opt_type = 1 and v_email_id is not null then
	-- forgot username using email_id
    	
		select user_name
        into   v_user_name
        from   labboost.labboost_user
        where  email_id = v_email_id;
        
		v_json := jsonb_set(v_json, '{data,user_name}', ('"'||v_user_name||'"')::text::jsonb, true);
		
	elsif v_opt_type = 2 and v_user_name is not null then
	-- forgot password using username
    	
		v_reset_key := uuid_generate_v4() ;
		
		select email_id
        into   v_email_id
        from   labboost.labboost_user
        where  user_name = v_user_name;
		
		update labboost.labboost_user
		set    reset_key       = v_reset_key,
          	   key_expiry_date = v_key_expiry_date,
               updated_date    = v_sysdate
		where  user_name       = v_user_name;
		
		v_json := jsonb_set(v_json, '{data,reset_key}', ('"'||v_reset_key||'"')::text::jsonb, true);
		v_json := jsonb_set(v_json, '{data,email_id}', ('"'||v_email_id||'"')::text::jsonb, true);
		
	elsif v_opt_type = 3 and v_user_name is not null and v_reset_key is not null and v_password is not null then
	-- update password using reset_key
		
		select count(1)
		into   v_user_id
		from   labboost.labboost_user
		where  user_name = v_user_name
        and    reset_key = v_reset_key
        and    key_expiry_date >= v_sysdate;
		
		select count(1)
		into   v_is_locked
		from   labboost.labboost_user
		where  user_id = v_user_id
        and    unlock_date >= v_sysdate;
        
		if v_user_id > 0 and v_is_locked = 0 then
        	
			v_json := jsonb_set(v_json, '{success}', 'true'::text::jsonb, true);
			
			select user_name, full_name, display_name, partner_id, email_id, profile_picture_url, is_active, is_deleted, is_published, user_guid
			into   v_user_name, v_full_name, v_display_name, v_partner_id, v_email_id, v_profile_picture_url, v_is_active, v_is_deleted,
            	   v_is_published, v_user_guid
			from   labboost.labboost_user
			where  user_id = v_user_id;
			
			update labboost.labboost_user
			set    failed_attempts = 0,
               	   user_pwd        = v_password,
                   updated_date    = v_sysdate
			where  user_id         = v_user_id;
			
			v_json := jsonb_set(v_json, '{data,user_id}', ('"'||v_user_id||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,email_id}', ('"'||v_email_id||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,full_name}',('"'||v_full_name||'"') ::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,is_active}', ('"'||v_is_active||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,user_guid}', ('"'||v_user_guid||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,user_name}', ('"'||v_user_name||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,is_deleted}',('"'||v_is_deleted||'"') ::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,partner_id}', ('"'||v_partner_id||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,display_name}',('"'||v_display_name||'"') ::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,is_published}', ('"'||v_is_published||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,profile_picture_url}', ('"'||v_profile_picture_url||'"')::text::jsonb, true);
			
		else
        	
            select user_id, failed_attempts
			into   v_user_id, v_failed_attempts
			from   labboost.labboost_user
			where  user_name = v_username;
			
			v_failed_attempts := (coalesce(v_failed_attempts,0))+1;
			v_unlock_date     := v_sysdate + interval '15 minutes';
			
			update labboost.labboost_user
			set    failed_attempts = v_failed_attempts,
               	   unlock_date     = case when v_failed_attempts = v_max_failed_attempts then v_unlock_date else unlock_date end
			where  user_id         = v_user_id;
			
			v_json := jsonb_set(v_json, '{failed_attempts}', ('"'||v_failed_attempts||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true);
			
			if v_is_locked = 0 then
               	v_json := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true);
			else
				v_json := jsonb_set(v_json, '{is_locked}', 'true'::text::jsonb, true);
			end if;
			
		end if;
        
	elsif v_opt_type = 4 and v_username is not null and v_oldpassword is not null and v_password is not null then
	-- update password using reset_key
    	
		select user_id
		into   v_user_id
		from   labboost.labboost_user
		where  user_name = v_username
        and    user_pwd  = v_oldpassword;
		
		select count(1)
		into   v_is_locked
		from   labboost.labboost_user
		where  user_id = v_user_id
        and    unlock_date >= v_sysdate;
		
		if v_user_id > 0 and v_is_locked = 0 then
        	
			v_json := jsonb_set(v_json, '{success}', 'true'::text::jsonb, true);
			
            select user_name, full_name, display_name, partner_id, email_id, profile_picture_url, is_active, is_deleted, is_published, user_guid
			into   v_user_name, v_full_name, v_display_name, v_partner_id, v_email_id, v_profile_picture_url, v_is_active, v_is_deleted,
            	   v_is_published, v_user_guid
			from   labboost.labboost_user 
			where  user_id = v_user_id;
			
			update labboost.labboost_user
			set    failed_attempts = 0,
               	   user_pwd        = v_password,
                   updated_date    = v_sysdate
			where  user_id         = v_user_id;
			
			v_json := jsonb_set(v_json, '{data,user_id}', ('"'||v_user_id||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,email_id}', ('"'||v_email_id||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,full_name}',('"'||v_full_name||'"') ::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,is_active}', ('"'||v_is_active||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,user_guid}', ('"'||v_user_guid||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,user_name}', ('"'||v_user_name||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,is_deleted}',('"'||v_is_deleted||'"') ::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,partner_id}', ('"'||v_partner_id||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,display_name}',('"'||v_display_name||'"') ::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,is_published}', ('"'||v_is_published||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,profile_picture_url}', ('"'||v_profile_picture_url||'"')::text::jsonb, true);
			
		else
        	
			select user_id, failed_attempts
			into   v_user_id, v_failed_attempts
			from   labboost.labboost_user
			where  user_name = v_username;
			
			v_failed_attempts := (coalesce(v_failed_attempts, 0)) + 1;
			v_unlock_date     := v_sysdate + interval '15 minutes';
			
			update labboost.labboost_user
			set    failed_attempts = v_failed_attempts,
            	   unlock_date     = case when v_failed_attempts = v_max_failed_attempts then v_unlock_date else unlock_date end
			where  user_id         = v_user_id;
			
			v_json := jsonb_set(v_json, '{failed_attempts}', ('"'||v_failed_attempts||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true);
			
			if v_is_locked = 0 then
            	v_json := jsonb_set(v_json, '{success}', 'false'::text::jsonb, true); 
			else
				v_json := jsonb_set(v_json, '{is_locked}', 'true'::text::jsonb, true); 
			end if;
			
		end if;
		
	end if;
    
	p_result := v_user_id;
	p_data   := v_json;
    
/*exception
	when others then
    	
        select -1
        into p_result
        from labboost.labboost_user
        where user_name = v_user_name;
        
        p_data := null;*/
	
end;

 $$;


--
