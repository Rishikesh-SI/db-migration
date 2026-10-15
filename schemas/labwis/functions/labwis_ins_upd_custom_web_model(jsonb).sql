-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labwis_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
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

v_count_of_yes numeric;
v_count_of_no numeric;
v_total_count numeric;
		
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
		   p_json->'data'->'user_info'->>'email_id'
         
into 
	v_module_name,
	v_user_guid,
	v_captcha,
	v_email_id;

if lower(v_module_name) = 'luckydraw' then
   
   if not exists(select 1 from labwis.labwis_custom_web_json
			 where datajson->'data'->'user_info'->>'email_id'=v_email_id and module_name='luckydraw')
			 
			 then
			
					v_custom_id:=nextval('labwis.seq_labwis_custom_id');

					insert into labwis.labwis_custom_web_json
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
   

	if not exists (select 1 from labwis.labwis_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'playerofthematch')
	then
 
 					v_custom_id:=nextval('labwis.seq_labwis_custom_id');

					insert into labwis.labwis_custom_web_json
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
   

	if not exists (select 1 from labwis.labwis_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'virtualplayermeet')
	then
 
 					v_custom_id:=nextval('labwis.seq_labwis_custom_id');

					insert into labwis.labwis_custom_web_json
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
   

	if not exists (select 1 from labwis.labwis_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'fantership')
	then
 
 					v_custom_id:=nextval('labwis.seq_labwis_custom_id');

					insert into labwis.labwis_custom_web_json
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
   

	if not exists (select 1 from labwis.labwis_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'fanticket')
	then
 
 					v_custom_id:=nextval('labwis.seq_labwis_custom_id');

					insert into labwis.labwis_custom_web_json
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
		
-------------------
elseif lower(v_module_name) = 'ticket-purchase' then
   v_custom_id:=nextval('labwis.seq_labwis_custom_id');

					insert into labwis.labwis_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

select
            coalesce(sum(case when datajson->'data'->>'message' = 'yes' then 1 else 0 end), 0)::numeric as count_of_yes,
            coalesce(sum(case when datajson->'data'->>'message' = 'no' then 1 else 0 end), 0)::numeric as count_of_no,
            coalesce(sum(case when datajson->'data'->>'message' is not null then 1 else 0 end), 0)::numeric as total_count
        into
            v_count_of_yes,
            v_count_of_no,
            v_total_count
        from labwis.labwis_custom_web_json g
		where g.datajson->'data'->>'module'= 'ticket-purchase';

		 p_data := format('{
					"data": {
            "status": "1",
            "message": "Success",
            "yes_count": %s,
            "no_count": %s,
            "total_count": %s
        }}', v_count_of_yes, v_count_of_no, v_total_count);

-------------------
elseif lower(v_module_name) = 'wisden-ticket-purchase-test' then
   v_custom_id:=nextval('labwis.seq_labwis_custom_id');

					insert into labwis.labwis_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
        select
            coalesce(sum(case when datajson->'data'->>'message' = 'yes' then 1 else 0 end), 0)::numeric as count_of_yes,
            coalesce(sum(case when datajson->'data'->>'message' = 'no' then 1 else 0 end), 0)::numeric as count_of_no,
            coalesce(sum(case when datajson->'data'->>'message' is not null then 1 else 0 end), 0)::numeric as total_count
        into
            v_count_of_yes,
            v_count_of_no,
            v_total_count
        from labwis.labwis_custom_web_json g
		where g.datajson->'data'->>'module'= 'wisden-ticket-purchase-test';
    
		 p_data := format('{
					"data": {
            "status": "1",
            "message": "Success",
            "yes_count": %s,
            "no_count": %s,
            "total_count": %s
        }}', v_count_of_yes, v_count_of_no, v_total_count);
	
	else  
	  p_data:='{
					"data": {
					"status":"0",
					"message":"un sucessful"
					}
					}';
	  
	  
			
		
	  end if;

--end if;

end;
$$;


--
