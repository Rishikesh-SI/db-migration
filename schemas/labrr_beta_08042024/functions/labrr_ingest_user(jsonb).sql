-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_ingest_user(jsonb)
-- Type: FUNCTION

-- Name: labrr_ingest_user(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_ingest_user(p_input jsonb, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare 
i jsonb;
v_json jsonb;
v_user_id numeric;
v_rr_user_id numeric;
v_first_name text := ' ';
v_last_name text := ' ';
v_email_id text := ' ';
v_mobile_no character varying;
v_country_code numeric;
p_email_id numeric[];
p_mobile_no numeric[];
p_out_json jsonb;
v_client_id numeric;
v_otp numeric;
v_is_whatsapp boolean;
v_email_verify numeric;
v_mobile_verify numeric;
v_jersey_name character varying;
v_jersey_number numeric;
v_dob character varying;
v_gender character varying;
v_user_guid character varying;
v_currenttimestamp timestamp;
v_is_active numeric:=1;
v_is_deleted numeric:=0;
v_user_password character varying;
v_is_platform character varying;
v_install_id character varying;
v_social_id character varying;
v_full_name character varying;
v_country_id numeric;
v_fav_player_id numeric;

begin 

--delete from labrr.labrr_duplicate_users;

select p_input->'user_data' into p_input;

for i in select * from jsonb_array_elements(p_input)
loop

select i->>'rr_userid',
i->>'first_name',
i->>'last_name',
i->>'email_id',
i->>'mobile_no',
i->>'country_code',
i->>'client_id',
i->>'otp',
i->>'is_whatsapp',
i->>'email_verify',
i->>'mobile_verify',
i->>'jersey_number',
i->>'jersey_name',
i->>'dob',
i->>'gender',
i->>'password',
i->>'is_platform',
i->>'install_id',
i->>'social_id',
i->>'full_name',
i->>'country_id',
i->>'fav_player_id'
into	
v_rr_user_id,
v_first_name,
v_last_name,
v_email_id,
v_mobile_no,
v_country_code,
v_client_id,
v_otp,
v_is_whatsapp,
v_email_verify,
v_mobile_verify,
v_jersey_number,
v_jersey_name,
v_dob,
v_gender,
v_user_password,
v_is_platform,
v_install_id,
v_social_id,
v_full_name,
v_country_id,
v_fav_player_id
;

if v_mobile_no='' then --or  or  or 
v_mobile_no:=null;
end if;

if v_email_id='' then
v_email_id:=null;
end if;

if v_first_name= '' then
v_first_name:=null;
end if;

if v_last_name='' then
v_last_name:=null;
end if;

if v_dob='' then
v_dob:=null;
end if;

if v_gender='' then
v_gender:=null;
end if;
	v_currenttimestamp := current_timestamp at time zone 'utc';

	if not exists(select 1 from labrr.labrr_web_user where (v_email_id is not null and email_id = v_email_id) or (v_mobile_no is not null and mobile_no = v_mobile_no) ) then
		begin
			v_user_guid:= uuid_generate_v4();
			insert into labrr.labrr_web_user(user_id,rr_user_id,first_name,last_name,email_id,mobile_no,country_code,client_id,subscribe_for_watsapp,
											 email_verified,mobile_verified,dob,gender,user_guid,created_date,updated_date,is_active,is_deleted,created_by,updated_by,user_password,is_platform_rr,install_id,social_id,
											 user_full_name,upper_email_id,is_verified,country_id)
			values(nextval('labrr.seq_labrr_web_users_id'),v_rr_user_id,v_first_name,v_last_name,v_email_id,v_mobile_no,v_country_code,v_client_id,v_is_whatsapp,
										   v_email_verify,v_mobile_verify,v_dob,v_gender,v_user_guid,v_currenttimestamp,v_currenttimestamp,v_is_active,v_is_deleted,v_is_active,v_is_active,v_user_password,v_is_platform,v_install_id,v_social_id,
										   v_full_name,v_email_id,1,v_country_id);
		exception
			when others then
			 insert into labrr.labrr_duplicate_users(rr_user_id) values(v_rr_user_id);
			
		end;

	

		else 

		

		insert into labrr.labrr_duplicate_users(rr_user_id) values(v_rr_user_id);

	end if;

end loop;

select '{"data":'||json_agg(x)||'}' from 
(select rr_user_id 
 from labrr.labrr_duplicate_users )x 
 into p_out_json;
p_result:= p_out_json;

if p_result is null then
p_result:='{"data":[]}';
end if;

end ;
$$;


--
