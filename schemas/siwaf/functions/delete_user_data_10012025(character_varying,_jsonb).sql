-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _delete_user_data_10012025(character varying, jsonb)
-- Type: FUNCTION

-- Name: _delete_user_data_10012025(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._delete_user_data_10012025(p_schema_prefix character varying, p_json jsonb, OUT p_data jsonb) RETURNS jsonb
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

	begin
    v_json:=p_json;
    
    
    select v_json->'data'->>'email_id',
           v_json->'data'->>'mobile_no',
           v_json->'data'->>'user_guid'
    into 
    v_email_id,
    v_mobile_no,
    v_user_guid;
    
    if v_user_guid is not null and v_user_guid<>''  then

    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
			 	where user_guid = $1 RETURNING user_id,mobile_no,email_id' into p_result,user_mobile,user_email
                using v_user_guid;
				
	execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user_audit
			 	where user_guid = $1'using v_user_guid;
    
    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_otp_details
			 	where mobile_no in ($1,$2) RETURNING mobile_no' into p_result1
                using user_mobile,user_email;
				
	elsif v_email_id is not null and v_email_id<>'' then

    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
			 	where email_id = $1 RETURNING user_id,user_guid' into p_result,p_user_guid
                using v_email_id;
	execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user_audit
			 	where user_guid = $1'using p_user_guid;             
    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_otp_details
			 	where mobile_no in ($1) RETURNING mobile_no' into p_result1
                using v_email_id;
                
    elsif v_mobile_no is not null and v_mobile_no<>'' then
    
    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
			 	where mobile_no = $1 RETURNING user_id,user_guid' into p_result,p_user_guid
                using v_mobile_no;          
    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user_audit
			 	where user_guid = $1'using p_user_guid;              
    execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_otp_details
			 	where mobile_no in ($1) RETURNING mobile_no' into p_result1
                using v_mobile_no;
    end if;
    
    
    if p_result is not null or p_result1 is not null then
                
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
                 "message":"Something went wrong"
              }
            }';
	end;
$_$;


--
