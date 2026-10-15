-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _login_cms_user_17052024(character varying, jsonb)
-- Type: FUNCTION

-- Name: _login_cms_user_17052024(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._login_cms_user_17052024(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_user_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_user_name text;
	v_user_password text;
	v_user_id numeric;
	v_max_failed_attempts numeric := 3;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_is_locked numeric;
	v_unlock_date timestamp := v_current_timestamp + '15 minutes'::interval;
	v_unlock_date_ch timestamp;
	v_failed_attempts numeric;
    v_notification_configuration_json jsonb;
	v_role_id numeric;
	p_data jsonb;
	v_log_type text;
	v_old_pass text;
    v_new_pass text;
	v_nt numeric;
	v_reset_key text;
	v_email_id text;
	v_upd_date timestamp;
	v_mint text;
	v_key_exp numeric;
	v_pwd_exp numeric;
	v_is_login numeric;
	v_session_start_time timestamp;
	v_failed_attemptscnt numeric;
	v_unlock_date_intable timestamp;
	v_unlock_inmin character varying;
	
begin
	
	select lower(p_json->>'username'), 
	       		 p_json->>'password',
		   		 p_json->>'user_login_type',
				 p_json->>'reset_key'
		   		
	into 		v_user_name,
	    		v_user_password , 
				v_log_type,
				v_reset_key;
	-- 1 login 
	-- 2 forgot password
	-- 3 change password
	
-- 	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'login_cms_user','logs',uuid_generate_v4(),p_json,current_timestamp,p_schema_prefix,'logs');
  
	
    if (v_log_type is null or v_log_type ='') then 
				execute 'select user_id
     		from '||p_schema_prefix||'.'||p_schema_prefix||'_user
			where lower(user_name) = '''||v_user_name||'''
			and user_pwd = '''||v_user_password||'''
			and is_active=1'
	        into v_user_id;	
			
			execute 'select unlock_date,failed_attempts
     		from '||p_schema_prefix||'.'||p_schema_prefix||'_user
			where lower(user_name) = '''||v_user_name||'''
			and is_active=1'
	        into v_unlock_date_intable,v_failed_attempts;	
			
			
				-- If user_name and password is correct and if user is locked then they can only login after 15min
				if v_user_id is not null and (v_unlock_date_intable<current_timestamp or v_unlock_date_intable is null) then
		
					execute 'select count(1)
							from '||p_schema_prefix||'.'||p_schema_prefix||'_user
							where user_id = '||v_user_id||'
							and unlock_date >= '''||v_current_timestamp||''''
					into v_is_locked;
		
						if v_is_locked = 0 then
               
							   execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user
									set failed_attempts = 0,
										unlock_date = null
									where user_id = '||v_user_id;
               
									execute 'select row_to_json(row)::jsonb
											from (select ''true''::bool as success, 0 as failed_attempts, ''false''::bool as is_locked,''Successfully Login'' as message,
															(select row_to_json(tab)
																	from (select u.user_id, u.display_name, u.email_id, u.partner_id, u.is_active, u.profile_picture_url,
																				u.full_name, u.is_deleted, u.user_guid, u.is_published, u.user_name,
																				string_agg(ur.role_id::text,'','') as roles, null as push_notification
																	from '||p_schema_prefix||'.'||p_schema_prefix||'_user u
																	join '||p_schema_prefix||'.'||p_schema_prefix||'_user_role ur
																	on ur.user_id = u.user_id
																	where u.user_id = '||v_user_id||'
																	group by u.user_id, u.display_name,u.email_id, u.partner_id, u.is_active, u.profile_picture_url,
																			u.full_name, u.is_deleted, u.user_guid, u.is_published, u.user_name
																)tab
														) as data
												) row'
									into p_user_json;

									   select notification_configuration into v_notification_configuration_json
									   from siwaf.siwaf_client_notification
									   where client_code = p_schema_prefix;

									   if v_notification_configuration_json is not null then
										p_user_json := jsonb_set(p_user_json,'{data,PushNotification}',v_notification_configuration_json,true);
									   end if;
			
							p_result := 1;
			
						else
          	
						execute 'select row_to_json(row)::jsonb
								from (select ''false''::bool as success,''User Account is locked contact to DB Person'' as message,
								0 as failed_attempts, ''true''::bool as is_locked, null as data) row'
						into p_user_json;

						p_result := -2;

						end if;
				--If user_name is correct but password is wrong
				elsif v_user_id is null then
						--After 3rd wrong attempt by same user_name and user_name account locked 15min ago 
						If v_unlock_date_intable<current_timestamp and v_failed_attempts>=3 then
						
						p_result:=-2;
						execute 'select row_to_json(row)::jsonb
									from (select ''false''::bool as success, '||v_failed_attempts||' as failed_attempts,
													''true''::bool as is_locked, null as data,
													''User Account is locked contact to DB Person'' as message,
													   null as push_notification) row'
							into p_user_json;
						--Trying to login with user_name
						elsif (v_unlock_date_intable is null) then
							raise notice '1';
							execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user
									set failed_attempts = coalesce(failed_attempts,0) + 1,
										unlock_date = case when (failed_attempts + 1) >= '||v_max_failed_attempts||' then timestamp '''||v_unlock_date||''' else null end
									where lower(user_name) = '''||v_user_name||'''
									returning failed_attempts'
							into v_failed_attempts;
							  
							  v_is_locked := 0;
							  
							  if v_failed_attempts >= v_max_failed_attempts then
								v_is_locked := 1;
							  end if;
							
							execute 'select row_to_json(row)::jsonb
									from (select ''false''::bool as success, '||v_failed_attempts||' as failed_attempts,''Try again with correct password'' as message,
													(case '||v_is_locked||' when 1 then ''true''::bool else ''false''::bool end) as is_locked, null as data,
													   null as push_notification) row'
							into p_user_json;
							
							  p_result := case v_is_locked when 1 then -2 else 0 end;
							  
						--After 3rd wrong attempt by same user_name and user_name account can be unlock in 15min  
						else
						select TO_CHAR(v_unlock_date_intable-current_timestamp, 'MI "Minutes, "SS "Seconds"') into v_unlock_inmin;
						p_result:=-2;
						execute 'select row_to_json(row)::jsonb
									from (select ''false''::bool as success, '||v_failed_attempts||' as failed_attempts,
													''true''::bool as is_locked, null as data,
													''Try Again after '||v_unlock_inmin||''' as message,
													   null as push_notification) row'
							into p_user_json;
						end if;
			   
				ELSE
				--If user_name and password is correct but account is lock will unlock after 15min
						select TO_CHAR(v_unlock_date_intable-current_timestamp, 'MI "Minutes, "SS "Seconds"') into v_unlock_inmin;
						p_result:=-2;
						execute 'select row_to_json(row)::jsonb
									from (select ''false''::bool as success, '||v_failed_attempts||' as failed_attempts,
													''true''::bool as is_locked, null as data,
													''Try Again after '||v_unlock_inmin||''' as message,
													   null as push_notification) row'
							into p_user_json;
					
				end if;
	
   -- if v_log_type=3 then
   elsif v_log_type='3' then
	 begin
	 
	 
	 select p_json->>'old_password',
	       	p_json->>'new_password'
	 into 	v_old_pass,
	      	v_new_pass;
			
	raise notice '%' ,v_new_pass;		
	  
	execute 'select  1  from  '||p_schema_prefix||'.'||p_schema_prefix||'_user
	         where lower(user_name) = $1
			 and user_pwd = $2'
			 
   into strict v_nt 
   using v_user_name,v_old_pass;
   -- raise notice '%',v_new_pass;
  -- select 1/0;
    execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user
	         set user_pwd='''||v_new_pass||''',
			 is_password_changed=1
	         where lower(user_name) = '''||v_user_name||'''
			 and user_pwd = '''||v_old_pass||''''
			 ;
			 
	if p_schema_prefix = 'labmi' then
	
		execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user
	         set pwd_expiry_date = (current_timestamp at time zone ''utc'' + ''15 days''::interval)
	         where lower(user_name) = '''||v_user_name||'''
			 and user_pwd = '''||v_new_pass||'''' ;
	
	end if;		 
			 
	----p_user_json := jsonb_set(p_user_json,'{data,password}',v_notification_configuration_json,true);
	p_result=1;
	p_user_json:=p_json;
	exception when others then
	-- old password not corrected 
	p_result :=2;
	p_user_json:=p_json;
    end ;
  elsif v_log_type='2' then 
    begin 
	select p_json->>'username',
	       p_json->>'new_password'
		   
	 into v_user_name,
	      v_new_pass;
	 
	 if ( v_reset_key is null)
	  then 
	   v_reset_key :=uuid_generate_v4();	
  
	  execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user
	            set reset_key=$2,updated_date=$3,key_expiry=0
	        	where lower(user_name) = $1'
				using v_user_name,v_reset_key,v_current_timestamp;
	
	   execute  'select email_id from '||p_schema_prefix||'.'||p_schema_prefix||'_user
	            where lower(user_name) = $1'	 
       into  v_email_id 
       using v_user_name;
	   
	   p_result:=1;
	   p_json :=jsonb_set(p_json,'{reset_key}',('"'||coalesce(v_reset_key,null)||'"')::text::jsonb,true);
	   p_user_json :=jsonb_set(p_json,'{email_id}',('"'||coalesce(v_email_id,null)||'"')::text::jsonb,true);
	 --- 1 st call
	 --p_user_json := jsonb_set(p_user_json,'{email_id}',('"'||coalesce(v_email_id,null)||'"')::text::jsonb,true);
	  elsif  ( v_reset_key is not  null and v_new_pass is null) then 
	 	 execute 'select updated_date from '||p_schema_prefix||'.'||p_schema_prefix||'_user
	  			  where reset_key=$1' into v_upd_date
	     using v_reset_key;
	  
	  execute 'SELECT (DATE_PART(''minute'', $2::timestamp - $3::timestamp)) , key_expiry
	  			from '||p_schema_prefix||'.'||p_schema_prefix||'_user
	  			where reset_key=$1' into v_mint ,v_key_exp
	  using v_reset_key,v_current_timestamp,v_upd_date; 
	  
	  if ((v_mint::numeric <=5) and (v_key_exp =0)  ) then 
	    p_result:=1;
		else 
		 p_result:=5;
	    end if ;
	
	  	else 
	  	     execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user
	            set user_pwd = $3,updated_date=$4,key_expiry=1
	        	where reset_key=$2
				'
				using null,v_reset_key,v_new_pass,v_current_timestamp; 
	   			p_result:=1;
	   			p_user_json:=p_json;
	   

		end if;
	
	
	end ;  
end if;
---raise notice '%',v_user_id;
/*
if ((p_schema_prefix='labyho') 
	 or (p_schema_prefix='labstmp') or (p_schema_prefix='labkxp')
     or (p_schema_prefix='labtmum')  
	 or (p_schema_prefix='labecn') or (p_schema_prefix='labrs') 
	 or (p_schema_prefix='labhsl')or (p_schema_prefix='upy') or (p_schema_prefix='labmi')
	 or (p_schema_prefix='gfg')  or (p_schema_prefix='labhkind') or (p_schema_prefix='labbsc') or (p_schema_prefix='labbsc_dev')
     or (p_schema_prefix='labiis')or (p_schema_prefix='labkkr')or (p_schema_prefix='labtkr') or (p_schema_prefix='labtcs')
   or (p_schema_prefix='labctkr') or (p_schema_prefix='labstlz') or (p_schema_prefix='dhm') or (p_schema_prefix='labisp')
   or (p_schema_prefix='labkc') or (p_schema_prefix='labmcfc')or (p_schema_prefix='labsaw')
   or (p_schema_prefix='upstox')or (p_schema_prefix='labrstg') or (p_schema_prefix='labeisl')  or (p_schema_prefix='labpkl_v1') or (p_schema_prefix='labfih') or (p_schema_prefix='labw88')
	or (p_schema_prefix='labgt') or (p_schema_prefix='labkxip') or (p_schema_prefix='labbg') or (p_schema_prefix='labuww') or (p_schema_prefix='labukk') or (p_schema_prefix='labman')
   or (p_schema_prefix='labpvl') or (p_schema_prefix='labbr') or (p_schema_prefix='labgmr'))  then 
*/

if exists(SELECT (1) FROM information_schema.tables 
    		  WHERE table_schema = p_schema_prefix AND 
              table_name = p_schema_prefix||'_user_role_menu_action_map2') then

execute 'select role_id  from '||p_schema_prefix||'.'||p_schema_prefix||'_user_role
where  user_id=$1'
into v_role_id
using v_user_id;

execute 'select row_to_json(r,true) 
from (
select 
json_agg(tab) as menu,
r.role_id,
r.role_name,
r.role_desc,
r.created_by
from (
SELECT
d.user_menu_id as menu_id,   
d.menu_name as title,
d.css_class as CSSclass,
d.redirect_url as link,	
d.menu_level,
d.menu_ord,
d.is_visible,	
coalesce(d.parent_id,0) as parent_id,    
dc.role_id,
jsonb_agg(tab) AS actions
FROM siwaf.siwaf_user_menu d
INNER JOIN '||p_schema_prefix||'.'||p_schema_prefix||'_user_role_menu_action_map2 dc 
           ON (dc.user_menu_id = d.user_menu_id ) 
		   and (dc.user_action_id is null)

    left join (select user_action_id as action_id,action_name ,
			    cm.role_menu_action_id ,cm.is_active,ma.status_flg
                ,cm.user_menu_id,ordring as order_by
					from siwaf.siwaf_menu_action ma
        INNER JOIN '||p_schema_prefix||'.'||p_schema_prefix||'_user_role_menu_action_map2  cm 
		ON  (ma.menu_action_id = cm.user_action_id ) 
		  where cm.is_active=1
			and cm.role_id=$1) tab 
		on tab.user_menu_id=dc.user_menu_id
     where dc.role_id=$1
	 and dc.is_active=1
	 and d.module_flag=1
	 group by d.user_menu_id,   
      d.menu_name,d.parent_id,dc.role_id,d.css_class,
d.redirect_url,d.menu_level,menu_ord,d.is_visible
order by d.menu_level,menu_ord 	 asc
)tab 
join '||p_schema_prefix||'.'||p_schema_prefix||'_role r on r.role_id=tab.role_id
group by 
r.role_id,
r.role_name,
r.role_desc,
r.created_by
	)r' into  p_data
	using v_role_id;
    
	p_user_json :=jsonb_set(p_user_json,'{permission}',coalesce(p_data,'{}'),true);
raise notice 'p_user_json %',p_user_json;
end if;

	if p_schema_prefix = 'labmi' then
	
		execute 'select coalesce((pwd_expiry_date + ''5.30 hour''::interval)::date  - 
				(current_timestamp at time zone ''utc'' + ''5.30 hour''::interval)::date , 0),coalesce(is_login,0),
				session_start_time
				from '||p_schema_prefix||'.'||p_schema_prefix||'_user
				where lower(user_name) = '''||v_user_name||''''	
		into v_pwd_exp,v_is_login,v_session_start_time;
		raise notice 'v_pwd_exp %',v_pwd_exp;
		v_pwd_exp :=  case when v_pwd_exp >= 0 then v_pwd_exp
							when v_pwd_exp < 0 then 0 end ;
				 	    raise notice 'v_pwd_exp %',v_pwd_exp;
	
        
		if (v_log_type is null or v_log_type ='') then 
		 
		 	if v_is_login = 0 and v_session_start_time is null then
			
				execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user
	            		 set is_login = 1 , session_start_time = current_timestamp at time zone ''utc''
	        			 where lower(user_name) = '''||lower(v_user_name)||'''
							and user_pwd = '''||v_user_password||'''';
						 
			elseif  v_is_login = 1 and (v_session_start_time + '1 hour'::interval) < current_timestamp at time zone 'utc' then
				
				execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user
	            		 set session_start_time = current_timestamp at time zone ''utc''
	        			 where lower(user_name) = '''||lower(v_user_name)||'''
						and user_pwd = '''||v_user_password||'''';
						 
					v_is_login := 0 ;
						 	 			 				
			end if; 
		    p_user_json :=jsonb_set(p_user_json,'{data,is_login}',('"'||coalesce(v_is_login,0)||'"')::text::jsonb,true);
			
		 end if;
		
		if v_log_type='3' then
		p_user_json :=jsonb_set(p_user_json,'{pwd_exp}',('"'||coalesce(v_pwd_exp,null)||'"')::text::jsonb,true);
		else
		 p_user_json :=jsonb_set(p_user_json,'{data,pwd_exp}',('"'||coalesce(v_pwd_exp,0)||'"')::text::jsonb,true);
		end if;
		
	end if;
	
	
--exception
	--when others then
		--p_result := -1;
		--p_user_json := '{"data":null,"success":false,"failed_attempts":"","is_locked":false}'::jsonb;
end;
$_$;


--
