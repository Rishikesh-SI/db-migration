-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_ins_upd_get_web_users(jsonb, refcursor, refcursor)
-- Type: FUNCTION

-- Name: dd_ins_upd_get_web_users(jsonb, refcursor, refcursor); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_ins_upd_get_web_users(p_user_json jsonb, p_user_cur refcursor, p_result refcursor) RETURNS SETOF refcursor
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
    --v_mobile_no character varying(20);
    v_gender character varying(10);
    v_sport_skill json;
    v_sport_skill_map json; 
    v_sport_id numeric;
    v_skill_level numeric;
    v_result numeric;
    v_is_verified numeric;
	v_mob_number numeric;
	v_country character varying(100);
	v_country_code numeric;
    v_user_guid1 character varying(100);
	
    
	
	
	v_product_cart_id numeric;
	v_total_price numeric ;
	v_total_select_product numeric ;
	
	v_login_product_cart_id numeric;
	
	v_count numeric;
	v_tokencode text;
	
	
	
begin
	
    select p_user_json->'data'->'opt_type'
    into   v_opt_type;
    
    if v_opt_type in (1,3) then

  
        select p_user_json->'data'->>'client_id',
        		trim(p_user_json->'data'->>'social_user_name'),
                trim(p_user_json->'data'->>'user_full_name'),
                trim(p_user_json->'data'->>'email_id'),
                p_user_json->'data'->>'user_password',
                p_user_json->'data'->>'social_id',
                p_user_json->'data'->>'mobile_number',
				trim(p_user_json->'data'->>'country'),
                trim(p_user_json->'data'->>'gender'),
                p_user_json->'data'->>'country_code',
                p_user_json->'data'->>'profile_picture',
                trim(p_user_json->'data'->>'user_guid'),
				trim(p_user_json->'data'->>'tokencode')
                
    	into   v_client_id,
        		v_social_user_name,
                v_user_full_name,
                v_email_id,
                v_user_password,
                v_social_id,
                v_mob_number,
                v_country,
                v_gender,
                v_country_code,
                v_profile_picture_url,
                v_user_guid,
				v_tokencode;
                
                
                
                
           -- IMP LOGIC
		if exists (select 1 from dd.dd_product_cart where user_cart_guid=v_user_guid)
		then 
		 if v_user_guid is not null
             
             then 
               
              select user_guid into v_user_guid1 
			from  dd.dd_web_user
              where client_id = v_client_id
               and social_id = v_social_id ;
               
              update dd.dd_product_cart
                set user_cart_guid=v_user_guid1
               where user_cart_guid=v_user_guid;
                
             -- test   
		      select count(1) into v_count  from dd.dd_product_cart
              where user_cart_guid=v_user_guid1;
    
             if v_count >1 then 
    
                select  product_cart_id,total_price,total_select_product 
			    into v_product_cart_id,v_total_price,v_total_select_product
                from dd.dd_product_cart
                where user_cart_guid=v_user_guid1
                and is_login_user=0
                and is_active=1;
    
    
    
            select  product_cart_id into v_login_product_cart_id-- ,total_price,total_select_product 
            from dd.dd_product_cart
            where user_cart_guid=v_user_guid1
            and is_login_user=1
            and is_active=1;
    
	    
           update dd.dd_product_cart
           set total_price=total_price+v_total_price ,
		   delivery_charges= case when (total_price+v_total_price) >500 then 0 else 50 end ,
           total_select_product=total_select_product+v_total_select_product
           where  user_cart_guid=v_user_guid1
           and is_login_user=1
           and is_active=1;
    
    
         update   dd.dd_product_cart
         set   is_active=0
         where  user_cart_guid=v_user_guid1
         and is_login_user=0
         and is_active=1;
        
        
          update   dd.dd_product_cart_details
          set   product_cart_id=v_login_product_cart_id
          where product_cart_id=v_product_cart_id
		   ;
				
				
			end if 	
				 ;
                 
              --   test
				
				
				
                
           end if;
            end if;
		
		   -- IMP LOGIC
                
		
        v_upper_email_id := upper(v_email_id);
        
        if not exists(select 1 from dd.dd_web_user where client_id = v_client_id and social_id = v_social_id) then
        	
        	v_web_user_id := nextval('dd.seq_dd_web_users_id');
        	
        	v_is_active := 1;
        	v_is_deleted := 0;
        	v_created_by := 1;
        	v_updated_by := 1;
        	v_created_date := v_current_timestamp;
        	v_updated_date := v_current_timestamp;
        	
            raise notice  'guid %' , v_user_guid ; 
            if v_user_guid is null 
            then 
            	v_user_guid := uuid_generate_v4();
          --  else 
           
            end if ;
            
        	insert into dd.dd_web_user
			(user_id, client_id, social_user_name, user_full_name, email_id, upper_email_id, user_password, social_id, mobile_no,
			 gender, country, country_code, profile_picture_url,
             user_guid, is_active, is_deleted, created_by, updated_by, created_date, updated_date,auth_token)
			values(v_web_user_id, v_client_id, v_social_user_name, v_user_full_name, v_email_id, v_upper_email_id, v_user_password, v_social_id,
				   v_mob_number, v_gender, v_country, v_country_code, v_profile_picture_url,
                   v_user_guid, v_is_active, v_is_deleted, v_created_by, v_updated_by, v_created_date, v_updated_date,v_tokencode);
			
            v_result := v_web_user_id;
            
		else
        	
            begin
                
                select user_id
				into strict v_web_user_id
				from   dd.dd_web_user
            	where  social_id = v_social_id
            	and    client_id = v_client_id;
                
                v_result := 1;
                
            exception
            	when no_data_found then
                	v_result := 0;
			end;
            
		end if;
        
	elsif v_opt_type = 2 then
    	
        select p_user_json->'data'->>'client_id',
                trim(p_user_json->'data'->>'user_full_name'),
                trim(p_user_json->'data'->>'email_id'),
                p_user_json->'data'->>'user_password',
				p_user_json->'data'->>'mobile_number',
				trim(p_user_json->'data'->>'tokencode')
    	into   v_client_id,
                v_user_full_name,
                v_email_id,
                v_user_password,
				v_mob_number,
				v_tokencode;
		
        v_upper_email_id := upper(v_email_id);
        
        if not exists(select 1 from dd.dd_web_user where client_id = v_client_id and upper_email_id = v_upper_email_id) then
        	
        	v_web_user_id := nextval('dd.seq_dd_web_users_id');
        	v_user_guid := uuid_generate_v4();
        	v_is_active := 1;
        	v_is_deleted := 0;
        	v_created_by := 1;
        	v_updated_by := 1;
        	v_created_date := v_current_timestamp;
        	v_updated_date := v_current_timestamp;
        	
        	insert into dd.dd_web_user(user_id, client_id, 
									user_full_name, 
									email_id,
									upper_email_id, 
									user_password,
									mobile_no,
									user_guid, 
									is_active,
                                             is_deleted, created_by,
									updated_by, created_date, 
									updated_date,auth_token)
			values(v_web_user_id, v_client_id, v_user_full_name,
				v_email_id, v_upper_email_id, v_user_password, v_mob_number,v_user_guid, v_is_active, v_is_deleted,
                   v_created_by, v_updated_by, v_created_date, v_updated_date,v_tokencode);
        	
        	v_result := 1;
            
        else
        	
        	v_result := 0;
            
        end if;
        
	elsif v_opt_type = 4 then
    	
        select trim(p_user_json->'data'->>'email_id'),
                p_user_json->'data'->>'user_password'
    	into   v_email_id,
                v_user_password;
		
        v_upper_email_id := upper(v_email_id);
        
        begin
        	
        	select user_id
			into strict v_web_user_id
			from   dd.dd_web_user
        	where  upper_email_id = v_upper_email_id
        	and    user_password = v_user_password;
			
            v_result := 1;
            
        exception
        	when no_data_found then
            	v_result := 0;
        end;
        
	elsif v_opt_type = 5 then
    	
        select trim(p_user_json->'data'->>'email_id'),
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
			from   dd.dd_web_user
			where  upper_email_id = v_upper_email_id
        	and    client_id = v_client_id;
        	
        	update dd.dd_web_user
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
            from dd.dd_web_user
            where reset_key = v_reset_key
            and client_id = v_client_id;
            
        	select key_expiry_date, reset_key_status
        	into strict v_key_expiry_date, v_reset_key_status
        	from   dd.dd_web_user
        	where  user_id = v_web_user_id;
        	
        	if v_reset_key_status = 1 and v_key_expiry_date > v_current_timestamp and v_key_expiry_date is not null then
        		
            	update dd.dd_web_user
            	set    old_password = user_password,
            		   user_password = v_user_password,
                       reset_key_status = 0,
                       reset_key = null
				where  user_id = v_web_user_id;
            	
			else
            	
            	update dd.dd_web_user
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
        	from dd.dd_web_user
        	where user_id = v_web_user_id;
            
            if v_is_verified = 1 then
            	v_result := -3;
			else
            	update dd.dd_web_user set is_verified = 1 where user_id = v_web_user_id;
            	v_result := 1;
            end if;
            
        exception
        	when no_data_found then
            	v_result := 0;
        end;
    
    end if;
    
    open p_user_cur for
    select a.*, dd.dd_get_product_cart_count(user_guid) as product_draft_count
	
    from   dd.dd_web_user a
    where  user_id = v_web_user_id;
    
    open p_result for
    select v_result as result;
    
end;

$$;


--
