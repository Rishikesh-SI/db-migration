-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_check_mobilenum_exist_r(jsonb)
-- Type: FUNCTION

-- Name: labwis_check_mobilenum_exist_r(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_check_mobilenum_exist_r(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
		/* 
		'{
  "type":3,
  "email_id": "xj4MJSW6UUqQ5MyxIbvhFAl52on0PcrC5RouXJwhwxhbERpaorkcSeZQatF6WbnsNVKDSSe+TNMmVj6+B3dPBA=="
}'*/
	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_status numeric;
	v_type numeric;
	v_msg text;
	
	v_accept_tnc boolean;
	v_subscribe_for_email boolean;
	v_accept_disclaimer boolean;

begin
	select p_inputjson->>'mobile_no',
		    p_inputjson->>'email_id',
			p_inputjson->>'type' 
	into v_mobile_no,
		 v_email_id,
		 v_type;
		 
		 raise notice '% ,% ',v_mobile_no,v_email_id;
		 
		 
	if v_mobile_no is not null and 	v_email_id is not null then
	
			v_status := -1 ;
	        v_msg := 'Invalid Request';
		 
	elseif 	v_mobile_no is null and v_email_id is null then 
	
			v_status := -1 ;
	       v_msg := 'Invalid Request';
		 
	elseif 	v_email_id is not null then
	
		if v_type=3 then

if exists(select 1 from labwis.labwis_web_user
					  where email_id = v_email_id  and is_verified=1 and is_active = 1 and is_deleted = 0) then
					 v_status := 0 ;
					 v_msg := 'Email ID already exists. Please use another Email ID.';
					 
					 SELECT accept_tnc, subscribe_for_email, accept_disclaimer FROM labwis.labwis_web_user 
					 into v_accept_tnc, v_subscribe_for_email, v_accept_disclaimer
					 where email_id = v_email_id  and is_verified=1 and is_active = 1 and is_deleted = 0;
			else
					v_status := 1 ;
					 v_msg := 'email_id do not exist';
					 v_accept_tnc:=false;
					 v_subscribe_for_email:=false;
					 v_accept_disclaimer:=false;
			
			end if;
		else 
		
			if exists(select 1 from labwis.labwis_web_user
					  where email_id = v_email_id  and is_active = 1 and is_deleted = 0) then
					v_status := 0 ;
					 v_msg := 'Email ID already exists. Please use another Email ID.';

					SELECT accept_tnc, subscribe_for_email, accept_disclaimer FROM labwis.labwis_web_user 
					 into v_accept_tnc, v_subscribe_for_email, v_accept_disclaimer
					 where email_id = v_email_id  and is_verified=1 and is_active = 1 and is_deleted = 0;
			else
					v_status := 1 ;
					 v_msg := 'email_id do not exist';
					 v_accept_tnc:=false;
					 v_subscribe_for_email:=false;
					 v_accept_disclaimer:=false;
			
			end if;

		end if;	
	
	elseif v_mobile_no is not null then
	
	if exists(select 1 from labwis.labwis_web_user
					  where mobile_no = v_mobile_no  and mobile_verified = 1 and is_active = 1 and is_deleted = 0) then
					 v_status := 0 ;
					 v_msg := 'mobile number already exists.';
					 
					 SELECT accept_tnc, subscribe_for_email, accept_disclaimer FROM labwis.labwis_web_user 
					 into v_accept_tnc, v_subscribe_for_email, v_accept_disclaimer
					 where mobile_no = v_mobile_no  and mobile_verified = 1 and is_active = 1 and is_deleted = 0;
	
	else	
			
				 v_status := 1 ;
				 v_msg := 'mobile number do not exist';
				 v_accept_tnc:=false;
				 v_subscribe_for_email:=false;
				 v_accept_disclaimer:=false;
				 

			end if;	
	
	end if;		

p_data := '{
				"status": "'|| coalesce(v_status::varchar,'')||'",
				 "message": "'|| coalesce(v_msg,'')||'",
				 "accept_tnc": "'||coalesce(v_accept_tnc::text,'false')||'",
				 "subscribe_for_emai": "'||coalesce(v_subscribe_for_email::text,'false')||'",
				 "accept_disclaimer": "'|| coalesce(v_accept_disclaimer::text,'false')||'"
  			}';

    
	

end;
$$;


--
