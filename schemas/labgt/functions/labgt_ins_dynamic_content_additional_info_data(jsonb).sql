-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ins_dynamic_content_additional_info_data(jsonb)
-- Type: FUNCTION

-- Name: labgt_ins_dynamic_content_additional_info_data(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_ins_dynamic_content_additional_info_data(p_inputjson jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare

	v_module_name character varying(1000);
	v_user_guid character varying(1000);
    v_asset_id numeric;
	v_asset_id1 character varying;
	v_additional_info_data_id numeric;
	v_asset_type_id numeric;
	v_json jsonb;
	v_status numeric;
	v_msg character varying;
	v_additional_info jsonb;
	v_content_id integer[];
	v_dynamic_data_id numeric;
	v_date character varying;
	v_date1 date;
	v_img_count numeric;
begin

	v_json := p_inputjson;
	
	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values (nextval('siwaf.seq_siwaf_api_error_log_id'),'ins_dynamic_content_additional_info_data','logs',uuid_generate_v4(),v_json,current_timestamp,'labgt','logs');
	
	
	select v_json->>'asset_type_id',
		    v_json->>'slug_url',
			v_json->'dynamic_form_data',
            v_json->'dynamic_form_data'->>'content_id'
	into v_asset_type_id,
		 v_module_name,
		 v_additional_info,
         v_asset_id1;
raise notice 'v_additional_info %',v_additional_info;
v_img_count := v_additional_info->'additional_info'->>'img_count';

raise notice 'v_img_count %',v_img_count;

if v_asset_id1 ='' then
v_asset_id:=null;
else 
v_asset_id:=v_asset_id1::numeric;
end if;
		 
	if(v_module_name = 'watch-video') then

if not exists(select 1 from labgt.labgt_dynamic_content_additional_info_data where slug_url=v_module_name) then
		v_additional_info_data_id := nextval('labgt.seq_labgt_additional_info_data_id');
        insert into labgt.labgt_dynamic_content_additional_info_data(
		additional_info_data_id, slug_url, dynamic_content_type_data_id, asset_id, content_id_array, additional_info)
		values (v_additional_info_data_id,v_module_name,null,v_asset_id,null,v_additional_info);
        else
        update labgt.labgt_dynamic_content_additional_info_data 
		set dynamic_content_type_data_id = v_dynamic_data_id,
		asset_id = v_asset_id,
        additional_info = v_additional_info
		where slug_url = 'watch-video';
        
        end if;
	elsif(v_module_name = 'play-poll') then
--day 8
    if not exists(select 1 from labgt.labgt_dynamic_content_additional_info_data where slug_url=v_module_name) then
		
        v_additional_info_data_id := nextval('labgt.seq_labgt_additional_info_data_id');
        insert into labgt.labgt_dynamic_content_additional_info_data(
	additional_info_data_id, slug_url, dynamic_content_type_data_id, asset_id, content_id_array, additional_info)
	values (v_additional_info_data_id,v_module_name,null,v_asset_id,null,v_additional_info);
        else

        update labgt.labgt_dynamic_content_additional_info_data 
		set dynamic_content_type_data_id = v_dynamic_data_id,
		asset_id = v_asset_id,
        additional_info = v_additional_info
		where slug_url = 'play-poll';
        
        end if;
		
	elsif(v_module_name = 'play-quiz') then
--day 8
    if not exists(select 1 from labgt.labgt_dynamic_content_additional_info_data where slug_url=v_module_name) then
		
        v_additional_info_data_id := nextval('labgt.seq_labgt_additional_info_data_id');
        insert into labgt.labgt_dynamic_content_additional_info_data(
	additional_info_data_id, slug_url, dynamic_content_type_data_id, asset_id, content_id_array, additional_info)
	values (v_additional_info_data_id,v_module_name,null,v_asset_id,null,v_additional_info);
        else

        update labgt.labgt_dynamic_content_additional_info_data 
		set dynamic_content_type_data_id = v_dynamic_data_id,
		asset_id = v_asset_id,
        additional_info = v_additional_info
		where slug_url = 'play-quiz';
        
        end if;
		
	elsif(v_module_name = 'dandiya-sticks') then
		v_additional_info_data_id := nextval('labgt.seq_labgt_additional_info_data_id');
		--v_asset_id := 10;
		
		with extracted_ids as (
				select jsonb_array_elements(a.page_items->'image_items') as image_items from
						(select jsonb_array_elements(page->'page_items') as page_items
            from jsonb_array_elements(v_json->'dynamic_form_data'->'additional_info'->'multiple_event') as page)a
		)
		
		select array_agg((image_items->>'image_id')::numeric)
    	into v_content_id from extracted_ids;
		
		raise notice 'v_content_id %',v_content_id;
		
		if not exists(select 1 from labgt.labgt_dynamic_content_additional_info_data where slug_url = v_module_name) then
		
         INSERT INTO labgt.labgt_dynamic_content_additional_info_data(
	        additional_info_data_id, slug_url, dynamic_content_type_data_id, asset_id, content_id_array, additional_info,img_count)
	        VALUES (v_additional_info_data_id,v_module_name,v_dynamic_data_id,v_asset_id,v_content_id,v_additional_info,v_img_count);
		
		else 
		
		update labgt.labgt_dynamic_content_additional_info_data 
		set dynamic_content_type_data_id = v_dynamic_data_id,
		asset_id = v_asset_id,
		content_id_array = v_content_id,
        additional_info = v_additional_info,
		img_count = v_img_count
		where slug_url = 'dandiya-sticks';
		end if;
        
    elsif(v_module_name = 'decode-message') then
    --Day 7 activity
        
        if not exists(select 1 from labgt.labgt_dynamic_content_additional_info_data where slug_url=v_module_name) then
		v_additional_info_data_id := nextval('labgt.seq_labgt_additional_info_data_id');
        
        INSERT INTO labgt.labgt_dynamic_content_additional_info_data(
	        additional_info_data_id, slug_url, dynamic_content_type_data_id, asset_id, content_id_array, additional_info)
	        VALUES (v_additional_info_data_id,v_module_name,null,v_asset_id,null,v_additional_info);

        else

        update labgt.labgt_dynamic_content_additional_info_data 
		set dynamic_content_type_data_id = v_dynamic_data_id,
		asset_id = v_asset_id,
        additional_info = v_additional_info
		where slug_url = 'decode-message';
        
        end if;
		
	elsif(v_module_name = 'refer-5-friends') then
--day5 activity	

		if not exists(select 1 from labgt.labgt_dynamic_content_additional_info_data where slug_url=v_module_name) then
		v_additional_info_data_id := nextval('labgt.seq_labgt_additional_info_data_id');
		
		raise notice 'v_date %',v_date;
        
        insert into labgt.labgt_dynamic_content_additional_info_data(
	        additional_info_data_id, slug_url, dynamic_content_type_data_id, asset_id, content_id_array, additional_info,date)
	        values (v_additional_info_data_id,v_module_name,null,v_asset_id,null,v_additional_info,date(v_additional_info->'additional_info'->>'date'));

        else

        update labgt.labgt_dynamic_content_additional_info_data 
		set dynamic_content_type_data_id = v_dynamic_data_id,
		asset_id = v_asset_id,
        additional_info = v_additional_info,
		date = date(v_additional_info->'additional_info'->>'date')
		where slug_url = 'refer-5-friends';
        
        end if;
		
	elsif(v_module_name = 'shubman-gill') then
	
	raise notice 'v_json %',v_json;
	
		with extracted_ids as (
				select jsonb_array_elements(a.page_items->'image_items') as image_items from
						(select jsonb_array_elements(page->'page_items') as page_items
            from jsonb_array_elements(v_json->'dynamic_form_data'->'additional_info'->'multiple_event') as page)a
		)
		
		select array_agg((image_items->>'image_id')::numeric)
    	into v_content_id from extracted_ids;
	
		raise notice 'v_content_id %',v_content_id;
	
		if not exists(select 1 from labgt.labgt_dynamic_content_additional_info_data where slug_url=v_module_name) then
		v_additional_info_data_id := nextval('labgt.seq_labgt_additional_info_data_id');
        
        insert into labgt.labgt_dynamic_content_additional_info_data(
	        additional_info_data_id, slug_url, dynamic_content_type_data_id, asset_id, content_id_array, additional_info,img_count)
	        values (v_additional_info_data_id,v_module_name,null,v_content_id,null,v_additional_info,v_img_count);

        else
		raise notice 'v_content_id %',v_content_id;
        update labgt.labgt_dynamic_content_additional_info_data 
		set dynamic_content_type_data_id = v_dynamic_data_id,
		asset_id = v_asset_id,
		content_id_array = v_content_id,
        additional_info = v_additional_info,
		img_count = v_img_count
		where slug_url = 'shubman-gill';
		end if;
        
		
	
	elsif(v_module_name = 'fam-wall-upload') then
--Day 9 activity	
		if not exists(select 1 from labgt.labgt_dynamic_content_additional_info_data where slug_url=v_module_name) then
		v_additional_info_data_id := nextval('labgt.seq_labgt_additional_info_data_id');
        
        insert into labgt.labgt_dynamic_content_additional_info_data(
	        additional_info_data_id, slug_url, dynamic_content_type_data_id, asset_id, content_id_array, additional_info)
	        values (v_additional_info_data_id,v_module_name,null,v_asset_id,null,v_additional_info);

        else

        update labgt.labgt_dynamic_content_additional_info_data 
		set dynamic_content_type_data_id = v_dynamic_data_id,
		asset_id = v_asset_id,
        additional_info = v_additional_info
		where slug_url = 'fam-wall-upload';
        
        end if;
	
	elsif(v_module_name = 'wordle-activity') then
--Day 9 activity	
		if not exists(select 1 from labgt.labgt_dynamic_content_additional_info_data where slug_url=v_module_name) then
		v_additional_info_data_id := nextval('labgt.seq_labgt_additional_info_data_id');
        
        insert into labgt.labgt_dynamic_content_additional_info_data(
	        additional_info_data_id, slug_url, dynamic_content_type_data_id, asset_id, content_id_array, additional_info)
	        values (v_additional_info_data_id,v_module_name,null,v_asset_id,null,v_additional_info);

        else

        update labgt.labgt_dynamic_content_additional_info_data 
		set dynamic_content_type_data_id = v_dynamic_data_id,
		asset_id = v_asset_id,
        additional_info = v_additional_info
		where slug_url = 'wordle-activity';
        
        end if;
	
	end if;
	

end;
$$;


--
