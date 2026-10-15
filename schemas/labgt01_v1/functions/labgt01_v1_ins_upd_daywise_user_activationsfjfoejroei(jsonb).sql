-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_ins_upd_daywise_user_activationsfjfoejroei(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_ins_upd_daywise_user_activationsfjfoejroei(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_ins_upd_daywise_user_activationsfjfoejroei(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
/* input of function:-
	select * from labgt01_v1.labgt01_v1_ins_upd_daywise_user_activations( 
	'{
  "module_name": "day-1-activity",
  "user_guid": "asdfg",
  "asset_id": "6661"
}') 
*/
	v_module_name character varying(1000);
	v_user_guid character varying(1000);
	v_asset_id1 character varying;
	v_asset_id numeric;
	v_daywise_user_activity numeric;
	v_asset_type_id numeric;
	v_json jsonb;
	v_status numeric;
	v_msg character varying;
    v_is_successful numeric;
    v_message character varying;
	v_image_id integer;
	v_internal_referral_code character varying;
	v_referal_user_guid character varying;
	v_date date;
	v_user_id numeric;
	v_mobile_no character varying;
	v_email_id character varying;
	v_country_code character varying;
	v_title character varying;
	v_count numeric;
	v_img_count numeric;
begin

	v_json := p_inputjson;
	
	select v_json->'data'->>'title_alias',
		    v_json->'data'->>'user_guid',
			v_json->'data'->>'content_id',
            v_json->'data'->>'message',
			v_json->'data'->>'image_id',
			v_json->'data'->>'internal_referal_userguid',
			v_json->'data'->>'referal_code'
	into v_module_name,
		 v_user_guid,
		 v_asset_id1,
         v_message,
		 v_image_id,
		 v_referal_user_guid,
		 v_internal_referral_code;

	if v_asset_id1 = '' then
		v_asset_id = null;
	else
		v_asset_id:= v_asset_id1::int;
	end if;
	
	select count(daywise_user_activity_id),dcad.img_count into v_count,v_img_count
				from labgt01_v1.labgt01_v1_daywise_user_activity ua
				join labgt01_v1.labgt01_v1_dynamic_content_additional_info_data dcad on ua.module_name = dcad.slug_url
				where module_name = v_module_name and is_successful = 1 and user_guid = v_user_guid
				group by user_guid,module_name,img_count;

v_title := case 
			 	when v_module_name = 'watch-video' then 'Day 1'
				when v_module_name = 'dandiya-sticks' then 'Day 2'
			 	when v_module_name = 'play-quiz' then 'Day 3'
			 	when v_module_name = 'find-dandiya' then 'Day 4'
				when v_module_name = 'refer-5-friends' then 'Day 5'
				when v_module_name = 'shubman-gill' then 'Day 6'
			 	when v_module_name = 'decode-message' then 'Day 7'
			 	when v_module_name = 'play-poll' then 'Day 8'
			 	when v_module_name = 'fam-wall-upload' then 'Day 9'
			 end;
			 
			 raise notice 'v_title %',v_title;
		 
	
		select date into v_date 
		from labgt01_v1.labgt01_v1_dynamic_content_additional_info_data
		where slug_url = v_module_name;
		 
	if v_module_name='watch-video' then --day 1
	
		if not exists (select 1 from labgt01_v1.labgt01_v1_daywise_user_activity where user_guid=v_user_guid and module_name=v_module_name) THEN

        if exists (select 1 from labgt01_v1.labgt01_v1_dynamic_content_additional_info_data where slug_url=v_module_name and 
            asset_id=v_asset_id) then
            v_is_successful:=1;
        else
            v_is_successful:=0;
        end if;
	
		v_daywise_user_activity := nextval('labgt01_v1.seq_labgt01_v1_daywise_user_activity_id');
		v_asset_type_id := 141;
		
		
		insert into labgt01_v1.labgt01_v1_daywise_user_activity 
		values(v_daywise_user_activity,v_user_guid,v_module_name,v_asset_id,v_asset_type_id,v_is_successful,v_json,1,0,current_timestamp,current_timestamp);	 

		v_status:= 1;
		v_msg:= 'Activity completed for today';
	
	else 
	
		v_status:= 0;
		v_msg:= 'Already Submitted Response';
	
	end if;
	
	elsif v_module_name='dandiya-sticks' then --day 2
	
--			if not exists (select 1 from labgt01_v1.labgt01_v1_daywise_user_activity where user_guid=v_user_guid) THEN

        if (select 1 from labgt01_v1.labgt01_v1_dynamic_content_additional_info_data where slug_url=v_module_name and 
             content_id_array @> array[v_image_id]) then
            v_is_successful:=1;
        else
            v_is_successful:=2;
        end if;
	
		v_daywise_user_activity := nextval('labgt01_v1.seq_labgt01_v1_daywise_user_activity_id');
		v_asset_type_id := 141;
		
		if not exists(select 1 from
				 (select array_agg(dua.asset_id) image_id from labgt01_v1.labgt01_v1_daywise_user_activity dua
						   where user_guid= v_user_guid and module_name = 'dandiya-sticks' 
						   group by user_guid,module_name)a
						  where a.image_id @> array[v_image_id]::numeric[]) then

				insert into labgt01_v1.labgt01_v1_daywise_user_activity 
				values(v_daywise_user_activity,v_user_guid,v_module_name,v_image_id,v_asset_type_id,v_is_successful,v_json,1,0,current_timestamp,current_timestamp);

				
				if(v_count >= v_img_count) then
					v_status:= 1;
					v_msg:= 'Activity completed for today';
				else
					v_status:= 1;
					v_msg:= 'Almost there! One more to go!';
				end if;
		else 
		
				v_status:= 0;
				v_msg:= 'Already submitted';	
		end if;
	
-- 	else 
	
-- 		v_status:= 0;
-- 		v_msg:= 'Already Submitted Response';
	
-- 	end if;
	
	elsif v_module_name='play-quiz' then --day 3
	
		if not exists (select 1 from labgt01_v1.labgt01_v1_daywise_user_activity where user_guid=v_user_guid and module_name=v_module_name) THEN

        if (select 1 from labgt01_v1.labgt01_v1_dynamic_content_additional_info_data where slug_url=v_module_name and 
            asset_id=v_asset_id) then
            v_is_successful:=1;
        else
            v_is_successful:=0;
        end if;
	
		v_daywise_user_activity := nextval('labgt01_v1.seq_labgt01_v1_daywise_user_activity_id');
		v_asset_type_id := 141;

		insert into labgt01_v1.labgt01_v1_daywise_user_activity 
		values(v_daywise_user_activity,v_user_guid,v_module_name,v_asset_id,v_asset_type_id,v_is_successful,v_json,1,0,current_timestamp,current_timestamp);	 

		v_status:= 1;
		v_msg:= 'Activity completed for today';
	
	else 
	
		v_status:= 0;
		v_msg:= 'Already Submitted Response';
	
	end if;	

	elsif v_module_name='refer-5-friends' then --day 5
	
	--	if exists (select 1 from labgt01_v1.labgt01_v1_daywise_user_activity where user_guid=v_user_guid) THEN

        if exists(select 1 from labgt01_v1.labgt01_v1_web_user where internal_referral_code=v_internal_referral_code
             and date(current_timestamp) = v_date) then
            v_is_successful:=1;
        else
            v_is_successful:=2;
        end if;
	
		raise notice 'v_referal_user_guid %',v_referal_user_guid;
		raise notice 'v_internal_referral_code %',v_internal_referral_code;
		
		v_daywise_user_activity := nextval('labgt01_v1.seq_labgt01_v1_daywise_user_activity_id');
		v_asset_type_id := 141;

		insert into labgt01_v1.labgt01_v1_daywise_user_activity 
		values(v_daywise_user_activity,v_user_guid,v_module_name,v_asset_id,v_asset_type_id,v_is_successful,v_json,1,0,current_timestamp,current_timestamp);	 
		
		if(v_count >= 3) then
					v_status:= 1;
					v_msg:= 'Activity completed for today';
				else
					v_status:= 1;
					v_msg:= 'Almost there! One more to go!';
				end if;
	
-- 	else 
	
-- 		v_status:= 0;
-- 		v_msg:= 'Already Submitted Response';
	
-- 	end if;
	
	elsif v_module_name='shubman-gill' then --day 6
	
-- 			if not exists (select 1 from labgt01_v1.labgt01_v1_daywise_user_activity where user_guid=v_user_guid) THEN

        if (select 1 from labgt01_v1.labgt01_v1_dynamic_content_additional_info_data where slug_url=v_module_name and 
             content_id_array @> array[v_image_id]) then
            v_is_successful:=1;
        else
            v_is_successful:=2;
        end if;
	
		v_daywise_user_activity := nextval('labgt01_v1.seq_labgt01_v1_daywise_user_activity_id');
		v_asset_type_id := 141;

		if not exists(select 1 from
			 (select array_agg(dua.asset_id) image_id from labgt01_v1.labgt01_v1_daywise_user_activity dua
						   where user_guid= v_user_guid and module_name = 'shubman-gill' 
						   group by user_guid,module_name)a
						  where a.image_id @> array[v_image_id]::numeric[]) then

		insert into labgt01_v1.labgt01_v1_daywise_user_activity 
		values(v_daywise_user_activity,v_user_guid,v_module_name,v_image_id,v_asset_type_id,v_is_successful,v_json,1,0,current_timestamp,current_timestamp);	 

				if(v_count >= v_img_count) then
					v_status:= 1;
					v_msg:= 'Activity completed for today';
				else
					v_status:= 1;
					v_msg:= 'Almost there! One more to go!';
				end if;
		else 
		
				v_status:= 0;
				v_msg:= 'Already submitted';	
		end if;
	
	
-- 	else 
	
-- 		v_status:= 0;
-- 		v_msg:= 'Already Submitted Response';
	
-- 	end if;
	
	elsif v_module_name='decode-message' then --day 7
	
	if not exists (select 1 from labgt01_v1.labgt01_v1_daywise_user_activity where user_guid=v_user_guid and module_name=v_module_name) THEN

        if (select 1 from labgt01_v1.labgt01_v1_dynamic_content_additional_info_data where slug_url=v_module_name and 
            lower(additional_info->'additional_info'->>'decode_message')=lower(v_message)) then
            v_is_successful:=1;
        else
            v_is_successful:=0;
        end if;
	
		v_daywise_user_activity := nextval('labgt01_v1.seq_labgt01_v1_daywise_user_activity_id');
		v_asset_type_id := 141;

		insert into labgt01_v1.labgt01_v1_daywise_user_activity 
		values(v_daywise_user_activity,v_user_guid,v_module_name,v_asset_id,v_asset_type_id,v_is_successful,v_json,1,0,current_timestamp,current_timestamp);	 

		v_status:= 1;
		v_msg:= 'Activity completed for today';
	
	else 
	
		v_status:= 0;
		v_msg:= 'Already Submitted Response';
	
	end if;
	
	elsif v_module_name='play-poll' then --day 8
	
		if not exists (select 1 from labgt01_v1.labgt01_v1_daywise_user_activity where user_guid=v_user_guid and module_name=v_module_name) THEN

        if (select 1 from labgt01_v1.labgt01_v1_dynamic_content_additional_info_data where slug_url=v_module_name and 
            asset_id=v_asset_id) then
            v_is_successful:=1;
        else
            v_is_successful:=0;
        end if;
	
		v_daywise_user_activity := nextval('labgt01_v1.seq_labgt01_v1_daywise_user_activity_id');
		v_asset_type_id := 141;

		insert into labgt01_v1.labgt01_v1_daywise_user_activity 
		values(v_daywise_user_activity,v_user_guid,v_module_name,v_asset_id,v_asset_type_id,v_is_successful,v_json,1,0,current_timestamp,current_timestamp);	 

		v_status:= 1;
		v_msg:= 'Activity completed for today';
	
	else 
	
		v_status:= 0;
		v_msg:= 'Already Submitted Response';
	
	end if;	

	elsif v_module_name='fam-wall-upload' then --day 9
	
		if not exists (select 1 from labgt01_v1.labgt01_v1_daywise_user_activity where user_guid=v_user_guid and module_name=v_module_name) THEN

        if (select 1 from labgt01_v1.labgt01_v1_dynamic_content_additional_info_data where slug_url=v_module_name 
            ) then
            v_is_successful:=1;
        else
            v_is_successful:=0;
        end if;
	
		v_daywise_user_activity := nextval('labgt01_v1.seq_labgt01_v1_daywise_user_activity_id');
		v_asset_type_id := 141;

		insert into labgt01_v1.labgt01_v1_daywise_user_activity 
		values(v_daywise_user_activity,v_user_guid,v_module_name,v_asset_id,v_asset_type_id,v_is_successful,v_json,1,0,current_timestamp,current_timestamp);	 

		v_status:= 1;
		v_msg:= 'Activity completed for today';
	
	else 
	
		v_status:= 0;
		v_msg:= 'Already Submitted Response';
	
	end if;	
	
	else 
	
		p_data := '{
		"status":"0",
		"message":"Wrong Input"
		}';

	end if;
	
	select user_id,mobile_no,email_id,country_code
	into v_user_id,v_mobile_no,v_email_id,v_country_code
	from labgt01_v1.labgt01_v1_web_user 
	where user_guid = v_user_guid;

	p_data := '{"data": {
				"status": "'|| coalesce(v_status::varchar,'')||'",
				 "message": "'|| coalesce(v_msg,'')||'",
				 "mobile_no": "'|| coalesce(v_mobile_no,'')||'",
				  "user_id": "'|| coalesce(v_user_id,0)||'",
				  "email_id": "'|| coalesce(v_email_id,'')||'",
				  "user_guid": "'|| coalesce(v_user_guid,'')||'",
				  "country_code": "'|| coalesce(v_country_code,'')||'",
				   "day": "'|| coalesce(v_title,'')||'"
  			}}';

    
	

end;
$$;


--
