-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_ins_upd_get_web_users(jsonb, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labkxp_ins_upd_get_web_users(jsonb, refcursor, refcursor); Type: FUNCTION; Schema: labkxp; Owner: -
--

CREATE FUNCTION labkxp.labkxp_ins_upd_get_web_users(p_user_json jsonb, p_user_cur refcursor, p_result refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_timestamp timestamp without time zone := current_timestamp at time zone 'utc';
    v_opt_type numeric;
    v_client_id numeric;
    v_social_user_name character varying(100);
    v_user_full_name character varying(100);
    v_email_id character varying(100);
    v_user_password character varying(256);
    v_social_id character varying(100);
    v_upper_email_id character varying(100);
    v_web_user_id numeric;
    v_user_guid character varying(256);
    v_is_active numeric;
    v_is_deleted numeric;
    v_created_by numeric;
    v_updated_by numeric;
    v_created_date timestamp without time zone;
    v_updated_date timestamp without time zone;
    v_reset_key character varying(256);
    v_key_expiry_date timestamp without time zone;
    v_reset_key_status numeric;
    v_dob date;
    v_profile_picture_url character varying(100);
    v_city character varying(100);
    v_mobile_no character varying(20);
    v_gender character varying(10);
    v_sport_skill json;
    v_sport_skill_map json; 
    v_sport_id numeric;
    v_skill_level numeric;
    v_result numeric;
    v_is_verified numeric := 0;
	v_is_first_login numeric := 0;
	v_is_welcome_email_sent numeric := 0;
     v_is_welcome_email_sent_1 numeric := 0;
    
begin
	
    select p_user_json->'data'->'opt_type'
    into   v_opt_type;
    
    if v_opt_type in (1,3) then
    	
        select p_user_json->'data'->>'client_id',
        		p_user_json->'data'->>'social_user_name',
                p_user_json->'data'->>'user_full_name',
                p_user_json->'data'->>'email_id',
                p_user_json->'data'->>'user_password',
                p_user_json->'data'->>'social_id'
    	into   v_client_id,
        		v_social_user_name,
                v_user_full_name,
                v_email_id,
                v_user_password,
                v_social_id;
		
        v_upper_email_id := upper(v_email_id);
        
		if v_social_id is not null then
			
			if v_email_id is not null and v_user_full_name is not null then
				v_is_verified := 1;
			end if;
			
			if not exists(select 1 from labkxp.labkxp_web_user where client_id = v_client_id and social_id = v_social_id) then
				
				v_web_user_id := nextval('labkxp.seq_labkxp_web_users_id');
        		v_user_guid := uuid_generate_v4();
        		v_is_active := 1;
        		v_is_deleted := 0;
        		v_created_by := 1;
        		v_updated_by := 1;
        		v_created_date := v_current_timestamp;
        		v_updated_date := v_current_timestamp;
				v_is_first_login := 1;
        		
               if v_email_id is not null then
               	if exists(select 1 from labkxp.labkxp_web_user where upper_email_id = v_upper_email_id) then
                    	v_is_welcome_email_sent := 1;
                    end if;
               	v_is_welcome_email_sent_1 := 1;
               end if;
               
        		insert into labkxp.labkxp_web_user(user_id, client_id, social_user_name, user_full_name, email_id, upper_email_id, user_password,
												social_id, user_guid, is_active, is_deleted, created_by, updated_by, created_date, updated_date,
												is_verified, is_welcome_email_sent)
				values(v_web_user_id, v_client_id, v_social_user_name, v_user_full_name, v_email_id, v_upper_email_id, v_user_password, v_social_id,
						v_user_guid, v_is_active, v_is_deleted, v_created_by, v_updated_by, v_created_date, v_updated_date, v_is_verified,
                           v_is_welcome_email_sent_1
                          );
				
            	v_result := v_web_user_id;
				
			else
				
            	begin
					
                	select user_id,upper_email_id
					into strict v_web_user_id, v_upper_email_id
					from   labkxp.labkxp_web_user
            		where  social_id = v_social_id
            		and    client_id = v_client_id;
                	
               	if exists(select 1 from labkxp.labkxp_web_user where upper_email_id = v_upper_email_id) then
                    	v_is_welcome_email_sent := 1;
                    end if;
                    
                	v_result := 1;
                	
            	exception
            		when no_data_found then
                		v_result := 0;
				end;
            	
			end if;
			
		else
			
			v_result := -1;
			
		end if;
		
        
        
	elsif v_opt_type = 2 then
    	
        select p_user_json->'data'->>'client_id',
                p_user_json->'data'->>'user_full_name',
                p_user_json->'data'->>'email_id',
                p_user_json->'data'->>'user_password'
    	into   v_client_id,
                v_user_full_name,
                v_email_id,
                v_user_password;
		
        v_upper_email_id := upper(v_email_id);
        
        if not exists(select 1 from labkxp.labkxp_web_user where client_id = v_client_id and upper_email_id = v_upper_email_id) then
        	
        	v_web_user_id := nextval('labkxp.seq_labkxp_web_users_id');
        	v_user_guid := uuid_generate_v4();
        	v_is_active := 1;
        	v_is_deleted := 0;
        	v_created_by := 1;
        	v_updated_by := 1;
        	v_created_date := v_current_timestamp;
        	v_updated_date := v_current_timestamp;
			v_is_first_login := 1;
        	
        	insert into labkxp.labkxp_web_user(user_id, client_id, user_full_name, email_id, upper_email_id, user_password, user_guid, is_active,
                                             is_deleted, created_by, updated_by, created_date, updated_date)
			values(v_web_user_id, v_client_id, v_user_full_name, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
                   v_created_by, v_updated_by, v_created_date, v_updated_date);
        	
        	v_result := 1;
            
        else
        	
        	v_result := 0;
            
        end if;
        
	elsif v_opt_type = 4 then
    	
        select p_user_json->'data'->>'email_id',
                p_user_json->'data'->>'user_password'
    	into   v_email_id,
                v_user_password;
		
        v_upper_email_id := upper(v_email_id);
        
        begin
        	
        	select user_id
			into strict v_web_user_id
			from   labkxp.labkxp_web_user
        	where  upper_email_id = v_upper_email_id
        	and    user_password = v_user_password;
			
            v_result := 1;
            
        exception
        	when no_data_found then
            	v_result := 0;
        end;
        
	elsif v_opt_type = 5 then
    	
        select p_user_json->'data'->>'email_id',
        		p_user_json->'data'->>'client_id'
        into   v_email_id,
        		v_client_id;
        
        v_upper_email_id := upper(v_email_id);
        
        v_reset_key := uuid_generate_v4();
        v_key_expiry_date := v_current_timestamp + interval '24 hours';
        v_reset_key_status := 1;
        
        begin
        	
        	select user_id
            into strict v_web_user_id
			from   labkxp.labkxp_web_user
			where  upper_email_id = v_upper_email_id
        	and    client_id = v_client_id;
        	
        	update labkxp.labkxp_web_user
        	set    reset_key = v_reset_key,
        			key_expiry_date = v_key_expiry_date,
                    reset_key_status = v_reset_key_status,
                	updated_date = v_current_timestamp
			where  upper_email_id = v_upper_email_id
        	and    client_id = v_client_id;
            
            v_result := 1;
            
		exception
        	when no_data_found then
            	v_result := 0;
		end;
        
	elsif v_opt_type = 6 then
    	
        select p_user_json->'data'->>'client_id',
                p_user_json->'data'->>'reset_key',
                p_user_json->'data'->>'user_password'
        into   v_client_id,
                v_reset_key,
                v_user_password;
        
        begin
        	
            select user_id
            into strict v_web_user_id
            from labkxp.labkxp_web_user
            where reset_key = v_reset_key
            and client_id = v_client_id;
            
        	select key_expiry_date, reset_key_status
        	into strict v_key_expiry_date, v_reset_key_status
        	from   labkxp.labkxp_web_user
        	where  user_id = v_web_user_id;
        	
        	if v_reset_key_status = 1 and v_key_expiry_date > v_current_timestamp and v_key_expiry_date is not null then
        		
            	update labkxp.labkxp_web_user
            	set    old_password = user_password,
            		   user_password = v_user_password,
                       reset_key_status = 0,
                       reset_key = null
				where  user_id = v_web_user_id;
            	
			else
            	
            	update labkxp.labkxp_web_user
            	set    reset_key_status = 0,
                	   reset_key = null
				where  user_id = v_web_user_id;
            	
        	end if;
			
            v_result := 1;
            
        exception
        	when no_data_found then
            	v_result := 0;
		end;
	
    elsif v_opt_type = 8 then
        
        select p_user_json->'data'->>'web_user_id'
        into   v_web_user_id;
        
        begin
        	
        	select is_verified
        	into strict v_is_verified
        	from labkxp.labkxp_web_user
        	where user_id = v_web_user_id;
            
            if v_is_verified = 1 then
            	v_result := -3;
			else
            	update labkxp.labkxp_web_user set is_verified = 1 where user_id = v_web_user_id;
            	v_result := 1;
            end if;
            
        exception
        	when no_data_found then
            	v_result := 0;
        end;
	
	elsif v_opt_type = 9 then
    	
		select p_user_json->'data'->>'web_user_id',
				p_user_json->'data'->>'social_id',
				p_user_json->'data'->>'client_id',
				p_user_json->'data'->>'user_full_name',
				p_user_json->'data'->>'dob',
				p_user_json->'data'->>'gender',
				p_user_json->'data'->>'city',
				p_user_json->'data'->>'mobile_no',
				trim(p_user_json->'data'->>'email_id')
        into   v_web_user_id,
				v_social_id,
				v_client_id,
				v_user_full_name,
				v_dob,
				v_gender,
				v_city,
				v_mobile_no,
				v_email_id;
        
	   if exists(select 1 from labkxp.labkxp_web_user where upper_email_id = upper(v_email_id) and is_welcome_email_sent = 1) then
					v_is_welcome_email_sent := 1;
		else
			update labkxp.labkxp_web_user set is_welcome_email_sent = 1 where upper_email_id = upper(v_email_id);
				end if;
	   
		if exists(select 1 from labkxp.labkxp_web_user where social_id = v_social_id and user_id = v_web_user_id and client_id = v_client_id) then
			update labkxp.labkxp_web_user
			set user_full_name = v_user_full_name,
				dob = v_dob::date,
				gender = v_gender,
				city = v_city,
				mobile_no = v_mobile_no,
				is_verified = 1
			where user_id = v_web_user_id;
               if exists(select 1 from labkxp.labkxp_web_user where user_id = v_web_user_id and email_id is null) then
               	update labkxp.labkxp_web_user
				set email_id = v_email_id,
				upper_email_id = upper(v_email_id)
				where user_id = v_web_user_id;
               end if;
			v_result := 1;
		else
			v_result := 0;
		end if;
		
    end if;
    
    open p_user_cur for
    select *,v_is_first_login is_first_login, v_is_welcome_email_sent as  is_email_sent
    from   labkxp.labkxp_web_user
    where  user_id = v_web_user_id;
    
    open p_result for
    select v_result as result;
    
end;

$$;


--
