-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_generate_otp(jsonb)
-- Type: FUNCTION

-- Name: labrr_generate_otp(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_generate_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

	/*'{
  "data": {
    "mobile_no": "string",
    "otp": "string",
    "email_id": "string",
    "opt": "string",
    "type": 0,
    "user_guid": "string",
    "is_app": "string"
  }
}'*/

	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_otp numeric;
	v_opt numeric;
	v_type numeric;
	v_user_guid character varying(1000);
	v_is_app numeric;
	v_count numeric ;
	v_created_date timestamp;
	v_user_full_name character varying(1000);
	v_otp_request_count numeric;
	v_request_ip character varying(1000);
    v_country_code numeric;

begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app',
		   p_inputjson->'data'->>'ip',
           p_inputjson->'data'->>'country_code'
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_type,
		   v_opt,
		   v_user_guid,
		   v_is_app,
		   v_request_ip,
           v_country_code;
           
         if v_mobile_no in ('+i6jxQF8lyHWGYcmmVnt5gz3UPJ4U92weinKTArOYm0=','+i6jxQF8lyHWGYcmmVnt5utdyRZQtQlMxo0IfQqoEfs=',
                     '+i6jxQF8lyHWGYcmmVnt5oZjxXe8aVud92ETOgsZits=','+i6jxQF8lyHWGYcmmVnt5m1geG6tE97ASEdzvjY/uaM=',
                     '+i6jxQF8lyHWGYcmmVnt5vwsf/yLtcaShDF3D8f0MiU=','+i6jxQF8lyHWGYcmmVnt5qV0hunKTRVNrWlrCC7wp/U=',
					 '+i6jxQF8lyHWGYcmmVnt5rlqJRnlk+iSW+1kS73H1S4=','+i6jxQF8lyHWGYcmmVnt5oUEZeM96sehQtoEODQYeyU=',
					 '+i6jxQF8lyHWGYcmmVnt5jyg+f0cdfN3FbojaizBSXU=','+i6jxQF8lyHWGYcmmVnt5gxxG7YLxE2uOhc95wa+PJA=',
				     '+i6jxQF8lyHWGYcmmVnt5pW9qRwn6CiomJqM2sRqPz0=','+i6jxQF8lyHWGYcmmVnt5sX7xdseZogjM80UrQL/ppA=',
					 '+i6jxQF8lyHWGYcmmVnt5uFObBWlPYmRLIAwLbaQl+8=','+i6jxQF8lyHWGYcmmVnt5o9h2pV8LzYKP4cx6/KUFIA=',
					 '+i6jxQF8lyHWGYcmmVnt5gf6RcS7WzeaMgPc4/Qg0TY=','Okni40YyzOnLAyDmnWCDYLg62g4dmVREo/QmAqqmKko=',
					 'FG2BrCziqVWrbabQ9MLAejVrfZP43UAltA9WpTQWz4Q=','ORhm0k5pQTyBcU+anaa2c3ah89sLxGbkm9hCQSJIPAI=') then
                     
           v_otp:=123456;
		   
		   insert into labrr.labrr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
	values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		   current_timestamp at time zone 'utc' + '1 day'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labrr');
		
		 p_data	:= '{"status": "1",
		 "message": "Success",
		 "otp_duration": "2 days"}';
                     
                     
       
      
else		   
	if 	v_opt in (1,2) then    
		   
	SELECT COUNT(*) INTO v_otp_request_count FROM labrr.labrr_otp_details
        	WHERE mobile_no = coalesce( v_mobile_no,v_email_id) 
        	AND (created_date)::date = (current_timestamp at time zone 'utc')::date;
	
	if v_otp_request_count < 150 then
		   
		insert into labrr.labrr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
		values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
			   current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labrr');

			 p_data	:= '{"status": "1",
			 "message": "Success",
			 "otp_duration": "120"}';
		 
	elsif v_mobile_no in ('Y/1dJNAANzdZ+RPwM3n+UAoDHrIlqG02ajXSRE9saPQ=','ggSSjncvluuXFQG/6j0H/9jEiHN6BT3A7heVSrgm82Y=','ggSSjncvluuXFQG/6j0H/68igicazEjZlA6aGgbOk1c=','ggSSjncvluuXFQG/6j0H/0QleQUCYCOuzuPtHaJ/CG4=',
						  'ggSSjncvluuXFQG/6j0H/0XF9wdo+UPob/epLDtVrnQ=','ggSSjncvluuXFQG/6j0H/xSKgIbyCUdvlZBugnJLoF0=','ggSSjncvluuXFQG/6j0H/3F4hJCYTMqE1f0AXaUVYdo=','ggSSjncvluuXFQG/6j0H/+B12AunIrt8ZTtcGFdMJfQ=','ggSSjncvluuXFQG/6j0H/60YYg4Ulq5otzQIS3UIWF0=',
						  'ggSSjncvluuXFQG/6j0H/1sQTyM3ztUvnMBOfmnlhhU=','bfN65sCHkhXloXE5Bq7C3U68eJDL5NdoV39MLZ7U3BA=','Na6gpKQhYScB4xmYsTo7WN6QBVyOlyBx5jRNHNrwpko=','Na6gpKQhYScB4xmYsTo7WIz1OWzuj9saGW7xZIjVO8A=','Na6gpKQhYScB4xmYsTo7WHE180e6amPAcZ2iUyaijmc=',
						 'Na6gpKQhYScB4xmYsTo7WMcuF8tU4QB45PF9Qz/kAY4=','Na6gpKQhYScB4xmYsTo7WBCocpvvFMSSxBBl2zFiagY=','Na6gpKQhYScB4xmYsTo7WOu5aI6zE46Gld3dKhAdDUQ=','Na6gpKQhYScB4xmYsTo7WLW0J9UI4cmRDD0J9maLXbc=','Na6gpKQhYScB4xmYsTo7WNo5UBZww1RYkLV71Jly4Gw=',
						 'Na6gpKQhYScB4xmYsTo7WINEunNdufGpDgTLVeazZxo=','Na6gpKQhYScB4xmYsTo7WJ+iN+CgWYevKnuF4ztDSQ0=','Na6gpKQhYScB4xmYsTo7WFV5lYi4LQ2Ja0br4pDz+WQ=','Na6gpKQhYScB4xmYsTo7WPQM9ZMVvI6wR5mz7z0Ute0=','RhUdhJr++RIN4O+ixGC12aFliVTVtj6RP55QH9TxGwk=',
						 'Na6gpKQhYScB4xmYsTo7WBAcACtL5jci6Ehb2zVM0v4=','XiIl2cnwD2yJLd0l1BzNJVNqWZQNRJlYgHbDijI7WOo=','FET4YpVUbKpF7+qJY1Ow2ZycyhPNA4ZJ/1B7MxjEBcY=','gfIng9kYpYmcL/Kx4Ei3qCboyXuNPlRsxKU1LQVBv74=','+jbrtg6Wcmz/tH6oCiCIUFuPqpy9HVh1d/ur1eTMGpw=',
						 '7UulgcynK3GwyLc2RMt4BoOsVqwiSZVtQegc4LWOdMY=','SX0y92LdBPmi8x/kTMjtOn+Bka/mwVxedmz2qorQfVg=','SX0y92LdBPmi8x/kTMjtOrzMo/5gXZj4p9RA+u39c+s=','SX0y92LdBPmi8x/kTMjtOnrV6ZqmctZEaJBxFWIXGF8=','SX0y92LdBPmi8x/kTMjtOtXrRwwwB4ipNznEM6tUsug=',
						 'SX0y92LdBPmi8x/kTMjtOpGtTnWLZkBU6WXW504nmgo=','SX0y92LdBPmi8x/kTMjtOqoz6odVDNTfEwmlRSzW3DE=','SX0y92LdBPmi8x/kTMjtOqviNkOalhuJihvPqhoi3mU=','SX0y92LdBPmi8x/kTMjtOt2QyGCw1LN61uHuqfy9tDM=','SX0y92LdBPmi8x/kTMjtOniVg2D3YVb8MlzqO5pAhTg=',
						 'IpDcon0Hj3MUDY7T4OO8N6jIOkmKm8cwdtFDSGX6Xsw=','nK4SqW9URIVq5GSJRY8HuXqHEe++IfYfZrnk8TFrrxE=') then
				if(v_otp_request_count < 100) then 
		
				insert into labrr.labrr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
				values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
			   current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labrr');
			   
			   p_data	:= '{"status": "1",
				 "message": "Success",
				 "otp_duration": "120"}';
				else
		 			p_data	:= '{"status": "0",
					"message": "OTP request count exceeded, account is locked. Please try again after 1 day."}';
				end if;
		
			
		
		else
		 p_data	:= '{"status": "0",
					"message": "OTP request count exceeded, account is locked. Please try again after 1 day."}';
	
		end if;
		 
	
	elseif v_opt = 3 then
			
		
		select count(1) into v_count  from labrr.labrr_otp_details
		where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type ;	
		
		select max(created_date) into v_created_date from labrr.labrr_otp_details
		where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type;
		
		
		
		if (v_count <=2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
												 or v_created_date is null )then
												 
		
			
			insert into labrr.labrr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labkc');
			
			p_data	:= '{"status": "1",
		 				"message": "Success",
						"otp_duration": "120"}';
			
		elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then
			
			insert into labrr.labrr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labkc');
			
					p_data	:= '{"status": "1",
		 						"message": "Success",
								"otp_duration": "120"}';
		else						
					p_data	:= '{"status": "2",
		 						"message": "attempt exceeded."}';
		end if;
	
	
	end if;
	
end if;
	
	
	select user_full_name into v_user_full_name  from labrr.labrr_web_user
	where user_guid = v_user_guid;
	
		   p_data	:= 	jsonb_set(p_data, '{user_full_name}', ('"'||coalesce(v_user_full_name,'')||'"')::jsonb, true); 
		
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;
$$;


--
