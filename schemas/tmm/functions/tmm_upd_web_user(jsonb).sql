-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_upd_web_user(jsonb)
-- Type: FUNCTION

-- Name: tmm_upd_web_user(jsonb); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_upd_web_user(p_user_data jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

	declare
	/*p_user_data jsonb := '{
  					"data": {
   							 "social_user_name": "FMBKO08DeKIVJpgxeXtc/ei/OLp7QePNuSQpl1AHwis=",
   				 			 "email_id": "kLujX5oMeVhCbp86pRp7TY/Be3ALsZOO+fS20xeK7xClAHNV5aOLoZTobAG06GPN6zY8UBZ/JurS+b40w3U5Vg1==",
    						 "customized_bib_name": "FMBKO08DeKIVJpgxeXtc/ei/OLp7QePNuSQpl1AHwis=",
                             "user_guid": "9eb9c540-a84a-4454-828a-4031683cf728",
							 "dob": "",
							 "city":"",
							 "gender:""
							 "isinstagram":1
                             }
                           }';*/
	v_social_user_name character varying(1000);
	v_email_id   character varying(1000);
	v_customized_bib_name character varying(1000);
	v_user_guid character varying(1000);
	v_dob character varying(1000);
	v_city character varying(1000);
	v_gender character varying(1000);
	v_is_insta numeric;
	v_web_user_id numeric;
	v_current_timestamp timestamp without time zone;
	
	begin

		select 	p_user_data->'data'->>'social_user_name',
				p_user_data->'data'->>'email_id',
				p_user_data->'data'->>'customized_bib_name',
				p_user_data->'data'->>'user_guid',
				p_user_data->'data'->>'dob',
				p_user_data->'data'->>'city',
				p_user_data->'data'->>'gender',
				p_user_data->'data'->>'isinstagram'
		into	v_social_user_name,	
				v_email_id,
				v_customized_bib_name,
				v_user_guid,
				v_dob,
				v_city,
				v_gender,
				v_is_insta;
				
	
				
		if 	v_is_insta = 1 then
			
			if not exists(select 1 from tmm.tmm_web_user where social_user_name = v_social_user_name) then		
				
				v_web_user_id := nextval('tmm.seq_tmm_web_users_id');               
                v_user_guid := uuid_generate_v4();
				v_current_timestamp := current_timestamp at time zone 'utc';
				
				insert into tmm.tmm_web_user
                    (user_id, client_id, social_user_name, user_full_name, email_id, upper_email_id, user_password,
                     social_id, profile_picture_url, user_guid, is_active, is_deleted, created_by, updated_by, created_date, updated_date, is_registered,
                     is_verified, gender,dob,city,customized_bib_name)
                    select v_web_user_id, 7, v_social_user_name, v_social_user_name, v_email_id, upper(v_email_id), null,
                            null, null, v_user_guid, 1, 0, 1, 1, v_current_timestamp,v_current_timestamp,
                            1, 1,v_gender,v_dob,v_city,v_customized_bib_name ;
							
				p_result := 1;			
			
			else 
				update tmm.tmm_web_user
				set email_id = v_email_id,
					customized_bib_name = v_customized_bib_name,
					dob= v_dob,
					city= v_city,
					gender=v_gender
				where social_user_name = v_social_user_name;
		
			p_result := 1;
		
		
	
			end if;
		
		
		
		else 
				
			if exists(select 1 from tmm.tmm_web_user where user_guid = v_user_guid ) then		
			
				update tmm.tmm_web_user
				set email_id = v_email_id,
					customized_bib_name = v_customized_bib_name,
					dob= v_dob,
					city= v_city,
					gender=v_gender
				where user_guid = v_user_guid;
		
				p_result := 1;
		
			else 
				p_result := -1;
			end if;
			
		end if;
		
	/*	exception 
		when others then
     		p_result := -1;*/
			
			
			
	end;

	$$;


--
