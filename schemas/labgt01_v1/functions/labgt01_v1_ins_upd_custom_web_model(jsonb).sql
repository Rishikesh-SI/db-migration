-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_custom_id numeric;
v_first_name character varying;
	v_last_name character varying;
	v_email_id character varying;
	v_fan_club_name character varying;
	v_captcha character varying;
v_module_name character varying;
v_mobile_no character varying;
v_user_guid character varying;
v_datajson jsonb;
v_email_body character varying;
v_name character varying;
v_player_names text[];
v_count_2026 numeric;
v_scenarios TEXT[];
begin
/*
{
  "data": {
    "module": "luckydraw",
    "user_info": {
      "first_name": "Abu",
      "last_name": "Dan",
      "email_id": "ab@gmail.com",
      "mobile_no": ""
    },
    "captcha": ""
  }
}
*/

 select    p_json->'data'->>'module',
		   p_json->'data'->>'user_guid',
		   p_json->'data'->>'captcha',
		   p_json->'data'->'user_info'->>'email_id',
		   p_json->'data'->'user_info'->>'mobile_no',
		   p_json->'data'->>'email_body',
		   p_json->'data'->'user_info'->>'name',
		   p_json->'data'->'user_info'->>'mobile_no'
         
into 
	v_module_name,
	v_user_guid,
	v_captcha,
	v_email_id,
	v_mobile_no,
	v_email_body,
	v_name,
	v_mobile_no;

if lower(v_module_name) = 'luckydraw' then
   
   if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json
			 where datajson->'data'->'user_info'->>'email_id'=v_email_id and module_name='luckydraw')
			 
			 then
			
					v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

					insert into labgt01_v1.labgt01_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1"
					}
					}';		
					
			else
					
					
					

p_data:='{
					"data": {
					"status":"0"
					}
					}';					
       end if;
      
	 
  elseif lower(v_module_name) = 'playerofthematch' then
   

	if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'playerofthematch')
	then
 
 					v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

					insert into labgt01_v1.labgt01_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
	else  
	  p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';				
					
	
	end if;
	elseif lower(v_module_name) = 'virtualplayermeet' then
   

	if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'virtualplayermeet')
	then
 
 					v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

					insert into labgt01_v1.labgt01_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
	else  
	  p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';				
					
	
	end if;

	elseif lower(v_module_name) = 'fantership' then
   

	if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'fantership')
	then
 
 					v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

					insert into labgt01_v1.labgt01_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
	else  
	  p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';				
					
	
	end if;

	elseif lower(v_module_name) = 'fanticket' then
   

	if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'fanticket')
	then
 
 					v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

					insert into labgt01_v1.labgt01_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
					
		else 
		     
			 p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';
			
		
		end if;			
		
	elseif lower(v_module_name) = 'uttarayan' then
	  		
   			if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'email_id'=v_email_id and module_name='uttarayan') then
				v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
				insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
			else
				p_data:='{
					"data": {
					"status":"0",
					"message":"Duplicate email"
					}
					}';
			end if;	

-------------------ish
elseif lower(v_module_name) = 'jos_signed_mini_bat' then
   

	if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and lower(module_name) = 'jos_signed_mini_bat')
	then
 
 					v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

					insert into labgt01_v1.labgt01_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
					
		else 
		     
			 p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';
			
		
		end if;			
	  
	
	---------------------  
	
	elseif lower(v_module_name) = 'gtvdc_hospitality_tickets' then
   

	if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and lower(module_name) = 'gtvdc_hospitality_tickets')
	then
 
 					v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

					insert into labgt01_v1.labgt01_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
					
		else 
		     
			 p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';
			
		
		end if;			
	  -----------------------------------
	  elseif lower(v_module_name) = 'gtvdc_tickets_giveaway_contest' then
   

	if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and lower(module_name) = 'gtvdc_tickets_giveaway_contest')
	then
 
 					v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

					insert into labgt01_v1.labgt01_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
					
		else 
		     
			 p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';
			
		
		end if;		
		---------------------------------------------------------
		elseif lower(v_module_name) = 'gtvsrh_tickets_giveaway_contest' then
   

	if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and lower(module_name) = 'gtvsrh_tickets_giveaway_contest')
	then
 
 					v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

					insert into labgt01_v1.labgt01_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
					
		else 
		     
			 p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';
			
		
		end if;		
		---------------------------------------------------------
		elseif lower(v_module_name) = 'gtvsrh_hospitality_tickets' then
   

	if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and lower(module_name) = 'gtvsrh_hospitality_tickets')
	then
 
 					v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

					insert into labgt01_v1.labgt01_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
					
		else 
		     
			 p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';
			
		
		end if;		
		---------------------------------------------------------
		
    elseif lower(v_module_name) = 'waiverform' then
			
					--raise notice 'v_full_name%',v_full_name;
						v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
						
						insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
						p_data:='{
						"data": {
						"status":"1",
						"message":"Success"
						}
						}';
						
						
	elseif lower(v_module_name) = 'ticketsluckydraw' then
					
						v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
						
						insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
						p_data:='{
						"data": {
						"status":"1",
						"message":"Success"
						}
						}';
						
		elseif lower(v_module_name) = 'ticketsluckydrawforlogin' then
					
						v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
						
						insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
						p_data:='{
						"data": {
						"status":"1",
						"message":"Success"
						}
						}';	
						
						
		elseif lower(v_module_name) = 'merchgiveawaycontest' then
	  		
   			if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and module_name='merchgiveawaycontest') then
				v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
				insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
			else
				p_data:='{
					"data": {
					"status":"0",
					"message":"Duplicate mobile number"
					}
					}';
			end if;

		elseif lower(v_module_name) = 'signed_team_jersey' then
	  		
   			if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and module_name='signed_team_jersey') then
				v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
				insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
			else
				p_data:='{
					"data": {
					"status":"0",
					"message":"Duplicate mobile number"
					}
					}';
			end if;

		elseif lower(v_module_name) = 'signed_jersey' then
	  		
   			if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and module_name='signed_jersey') then
				v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
				insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
			else
				p_data:='{
					"data": {
					"status":"0",
					"message":"Duplicate mobile number"
					}
					}';
			end if;
			
		elseif lower(v_module_name) = 'signed_cap' then
	  		
   			if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and module_name='signed_cap') then
				v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
				insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
			else
				p_data:='{
					"data": {
					"status":"0",
					"message":"Duplicate mobile number"
					}
					}';
			end if;
			
		elseif lower(v_module_name) = 'merchandise' then
	  		
   			if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and module_name='merchandise') then
				v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
				insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
			else
				p_data:='{
					"data": {
					"status":"0",
					"message":"Duplicate mobile number"
					}
					}';
			end if;
			
		elseif lower(v_module_name) = 'lavendar_day' then
	    
		if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and module_name='lavendar_day') then
			
			v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
				insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
			else
				p_data:='{
					"data": {
					"status":"0",
					"message":"Duplicate mobile number"
					}
					}';
		end if;
		
		elseif lower(v_module_name) = 'ticket_giveaway_gtvkkr' then
					
						v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
						
						insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
						p_data:='{
						"data": {
						"status":"1",
						"message":"Success"
						}
						}';	
						
	elseif lower(v_module_name) = 'match_travel' then
	    
		if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and lower(module_name)='match_travel') then
			
			v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
				insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
			else
				p_data:='{
					"data": {
					"status":"0",
					"message":"Duplicate mobile number"
					}
					}';
		end if;
		
		
		elseif lower(v_module_name) = 'ipl_retention_2025' then
	    
		if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where user_guid = v_user_guid and module_name = 'ipl_retention_2025' ) then
        
             v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

             select string_to_array(p_json->'data'->>'player_names',',') into v_player_names;

             update labgt01_v1.labgt01_v1_retention_players set count=count+1 where player_name=any(v_player_names);

             insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
		else 
		
			  p_data:='{
					"data": {
					"status":"0",
					"message":"Already Submitted"
					}
					}';	
		
		end if;
	elseif lower(v_module_name) = 'careers_page' then
		--if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and lower(module_name)='careers_page') then
			v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
				insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
					
				p_data:= jsonb_set(p_data,'{data,email_body}',(coalesce(v_email_body,''))::jsonb, true);
				
				--p_data:= jsonb_set(p_data,'{data,email_body,email_id}',(coalesce(v_email_id,''))::jsonb, true);

-- 				p_data := jsonb_set(p_data, '{data,email_body,email_id}', to_jsonb(coalesce(v_email_id, '')), true);

				p_data := jsonb_set(p_data, '{data,email_body,name}', to_jsonb(coalesce(v_name, '')), true);
				
				p_data := jsonb_set(p_data, '{data,email_body,mobile_no}', to_jsonb(coalesce(v_mobile_no, '')), true);

-- 			else
-- 				p_data:='{
-- 					"data": {
-- 					"status":"0",
-- 					"message":"Duplicate mobile number"
-- 					}
-- 					}';
-- 		end if;

elseif lower(v_module_name) = 'gtvspbks_match_tickets_giveaway' then
	    
		if not exists(select 1 from labgt01_v1.labgt01_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no and lower(module_name)='gtvspbks_match_tickets_giveaway') then
			
			v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');
				insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
			else
				p_data:='{
					"data": {
					"status":"0",
					"message":"Duplicate mobile number"
					}
					}';
		end if;

elseif lower(v_module_name) = 'ipl_retention_2026' then
	    
		if not exists (select 1 from labgt01_v1.labgt01_v1_custom_web_json where user_guid = v_user_guid and module_name = 'ipl_retention_2026' ) then
        
             v_custom_id:=nextval('labgt01_v1.seq_labgt01_v1_custom_id');

/*
select * from labgt01_v1.labgt01_v1_ins_upd_custom_web_model('{
  "data": {
    "module": "ipl_retention_2026",
    "player_names": "Shubman Gill,Shahrukh Khan",  
    "user_guid": "ae350560-9aa2-46999-99ce-1124eefbe638",
    "mobile_no": "8766677478",
    "email_id": "",
    "captcha": ""
  }
}');*/

-- 			 select string_to_array(p_json->'data'->>'player_names',',') into v_player_names;
				
-- 				raise notice 'v_player_names:%',v_player_names;

--  NEW CODE STARTS HERE
        select array_agg(lower(player->>'player_name'))
        into v_player_names
        from jsonb_array_elements(p_json->'data'->'player_names') as player;

        raise notice 'v_player_names: %', v_player_names;
        --  NEW CODE ENDS HERE
             
				UPDATE labgt01_v1.labgt01_v1_retention_players_2026
				SET count = count + 1
				WHERE lower(player_name) = ANY (
					SELECT lower(unnest(v_player_names))
				);

             insert into labgt01_v1.labgt01_v1_custom_web_json values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
				
				p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
		else 
		
			  p_data:='{
					"data": {
					"status":"0",
					"message":"Already Submitted"
					}
					}';	
		
		end if;
		
		
		
--------------------------------------------
ELSEIF lower(v_module_name) = 'auction_activation_2026' THEN
    -- Check if the user has already submitted for this module
    IF EXISTS (
        SELECT 1
        FROM labgt01_v1.labgt01_v1_custom_web_json
        WHERE user_guid = v_user_guid
        AND module_name = 'auction_activation_2026'
    ) THEN
        -- User already submitted, return "already exists" message inside "data"
        p_data := jsonb_build_object(
            'data', jsonb_build_object(
                'status', '0',
                'message', 'already exists'
            )
        );
    ELSE
        -- Proceed with insertion
        BEGIN
            v_custom_id := nextval('labgt01_v1.seq_labgt01_v1_custom_id');
            -- Insert scenarios into auction_activation_2026 table
            INSERT INTO labgt01_v1.labgt01_v1_auction_activation_2026
            (id, user_guid, scenario_id, scenario_text, scenario_position, created_at, count, "position")
            SELECT
                nextval('labgt01_v1.seq_labgt01_v1_auction_id'),
                v_user_guid,
                scenario->>'scenario_id',
                scenario->>'scenario_text',
                scenario->>'position',
                current_timestamp,
                1,
                scenario->>'position'
            FROM jsonb_array_elements(p_json->'data'->'scenarios') AS scenario;

            -- Insert a record into custom_web_json
            INSERT INTO labgt01_v1.labgt01_v1_custom_web_json
            VALUES (
                v_custom_id,
                v_captcha,
                current_timestamp,
                current_timestamp,
                v_user_guid,
                v_module_name,
                p_json
            );

            -- Return success message inside "data"
            p_data := jsonb_build_object(
                'data', jsonb_build_object(
                    'status', '1',
                    'message', 'success'
                )
            );
        EXCEPTION WHEN OTHERS THEN
            -- Return error message inside "data"
            p_data := jsonb_build_object(
                'data', jsonb_build_object(
                    'status', '0',
                    'message', 'error: ' || SQLERRM
                )
            );
        END;
    END IF;


-------------------------------------
		
	else 
	  p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';	
		
	  end if;
	  

--end if;

end;
$$;


--
