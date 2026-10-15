-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _delete_user_data(character varying, jsonb)
-- Type: FUNCTION

-- Name: _delete_user_data(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._delete_user_data(p_schema_prefix character varying, p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
declare
v_json jsonb;
v_email_id character varying;
v_mobile_no character varying;
v_user_guid character varying;
p_result numeric;
p_result1 character varying;
p_result2 character varying;
user_mobile character varying;
user_email character varying;
p_user_guid character varying;
user_arr character varying[];
email_arr character varying[];
mobile_arr character varying[];
v_otp numeric;
v_user_exists numeric;
	begin
    v_json:=p_json;
    
    
    select v_json->'data'->>'email_id',
           v_json->'data'->>'mobile_no',
           v_json->'data'->>'user_guid'
    into 
    v_email_id,
    v_mobile_no,
    v_user_guid;
    
    raise notice 'Input - email_id: %, mobile_no: %, user_guid: %', v_email_id, v_mobile_no, v_user_guid;
    
    if v_user_guid is not null and v_user_guid<>''  then

    if (p_schema_prefix not in ('labmi','labrr')) then
    raise notice '1';
        execute 'select user_guid,mobile_no,email_id from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
                        where user_guid = $1' into p_user_guid, user_mobile, user_email
                        using v_user_guid;

        raise notice 'Found user - p_user_guid: %, user_mobile: %, user_email: %', p_user_guid, user_mobile, user_email;

        if (p_user_guid is not null and p_user_guid<>'') then

            -- Check if user exists before deletion
            execute 'select count(*) from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
                        where user_guid = $1' into v_user_exists
                        using v_user_guid;
            
            raise notice 'User exists count before deletion: %', v_user_exists;

            -- Delete from web_user table
            execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
                        where user_guid = $1' using v_user_guid;
            
            -- Check if user still exists after deletion
            execute 'select count(*) from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
                        where user_guid = $1' into v_user_exists
                        using v_user_guid;
            
            raise notice 'User exists count after deletion: %', v_user_exists;

            if (p_schema_prefix<>'labmi') then
                execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user_audit
                            where user_guid = $1' using v_user_guid;
            end if;

            -- Only delete from otp_details if we have mobile or email
            if (user_mobile is not null and user_mobile <> '') or (user_email is not null and user_email <> '') then
                execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_otp_details
                            where mobile_no in ($1,$2)'
                            using user_mobile,user_email;
            else
                raise notice 'Skipping otp_details deletion - no mobile or email found';
            end if;
            
            p_result:=1;

        else

            p_result:=null;

        end if;

    else
        raise notice '2';
       select case when p_schema_prefix='labmi' then 
       (select * from labmi.labmi_delete_membership(v_user_guid))
       when p_schema_prefix='labrr' then 
       (select * from labrr.labrr_delete_membership(v_user_guid))
        else 0 end into p_result;

        raise notice 'p_result:%',p_result;

    end if;
				
	elsif v_email_id is not null and v_email_id<>'' then

    execute 'select array_agg(user_guid),array_agg(email_id) from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
			 	where email_id = $1' into user_arr,email_arr
                using v_email_id;
                
     if (email_arr is null) then
       email_arr:=array[v_email_id];
     end if;
                
    execute 'select count(*) from '||p_schema_prefix||'.'||p_schema_prefix||'_otp_details
			 	where mobile_no = any($1)' into v_otp
                using email_arr; 
                
                
    if (user_arr is not null and user_arr<>'{}') or (v_otp > 0 and v_otp is not null) then

    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
			 	where user_guid = any($1)' using user_arr;
    if (p_schema_prefix<>'labmi') then
	execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user_audit
			 	where user_guid = any($1)' using user_arr;  
    end if;           
    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_otp_details
			 	where mobile_no = any($1)'
                using email_arr;
    p_result:=1;

    else

    p_result:=null;
    
    end if;
               
               
               
               
    elsif v_mobile_no is not null and v_mobile_no<>'' then

    execute 'select array_agg(user_guid),array_agg(mobile_no) from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
			 	where mobile_no = $1' into user_arr,mobile_arr
                using v_mobile_no;
                
                
     if (mobile_arr is null) then
       mobile_arr:=array[v_mobile_no];
     end if;
                
  execute 'select count(*) from '||p_schema_prefix||'.'||p_schema_prefix||'_otp_details
			 	where mobile_no = any($1)' into v_otp
                using mobile_arr;
                
                raise notice 'v_otp:%',v_otp;
                raise notice 'user_arr:%',user_arr;
                raise notice 'mobile_arr:%',mobile_arr;
                
    if ((user_arr is not null and user_arr<>'{}') or (v_otp > 0 and v_otp is not null))and p_schema_prefix<>'labgt' then

    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
			 	where user_guid = any($1)' using user_arr;
    if (p_schema_prefix<>'labmi') then
	execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user_audit
			 	where user_guid = any($1)' using user_arr;
    end if;  
    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_otp_details
			 	where mobile_no = any($1)'
                using mobile_arr;
			
    
    p_result:=1;
	elsif 
		p_schema_prefix='labgt'
		then 
		execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_otp_details
			 	where mobile_no = any($1)'
                using mobile_arr;
                
		execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
			 	where user_guid = any($1)' using user_arr;
                
		p_result:=1;
		
    else

    p_result:=null;
    
    end if;
    
    
    end if;
    
    
    if p_result is not null then
                
    p_data:='{
              "data": {
                 "status": 1,
                 "message": "Deleted Successfully"
              }
            }';
            
   else
   
       p_data:='{
              "data": {
                 "status": 2,
                 "message": "Detail does not exist in DB"
              }
            }';
    
    end if;
    
    exception
    when others then--SQLSTATE '42703' then
    
    p_data:='{
              "data": {
                 "status": 0,
                 "message":"Something went wrong: " || SQLERRM
              }
            }';
            
    raise notice 'Exception occurred: %', SQLERRM;
	end;
$_$;


--
