-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_get_dynamic_content_detail_r(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labupw_get_dynamic_content_detail_r(numeric, numeric, numeric); Type: FUNCTION; Schema: labupw; Owner: -
--

CREATE FUNCTION labupw.labupw_get_dynamic_content_detail_r(p_dynamic_content_id numeric, p_versionnumber numeric, p_content_type_id numeric, OUT p_result numeric, OUT p_contenttypejson jsonb, OUT p_datajson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
     v_versionnumber numeric;
     v_isdeletedquery text := ' ';
     v_publishedversionnumber numeric := 0;
     v_imagejsonarr jsonb[];
     v_imagejson jsonb;
     v_json text := '{"items":[';
     v_image_count numeric;
     p_datajson1 jsonb;
begin
	
	if p_dynamic_content_id is not  null then
	
		 if p_versionnumber is null then
			
			  select      published_version_number
			  into strict v_versionnumber
			  from   	  labupw.labupw_content_type_data
			  where  	  dynamic_content_type_data_id = p_dynamic_content_id;
			  
			  v_isdeletedquery := ' and aam.is_deleted = 0 ';
			  
		 else
			
			  v_versionnumber := p_versionnumber;
			  
		 end if;
     
		 select 	  asset_data
		 into strict p_datajson1
		 from   	  labupw.labupw_asset_draft
		 where  	  asset_type_id  = p_content_type_id
		 and    	  asset_id       = p_dynamic_content_id
		and    	  version_number = v_versionnumber;
		
		select p_datajson1->>'data' into p_datajson;
	
	end if;
     
	select ''||json_agg(r)||'' from
	(select content_type_field_id as content_field_id, content_type_id, field_name, field_data_type, 
     field_defaultvalue, field_type, field_label, show_in_listing_json, is_active, 
     is_deleted, created_date, updated_date, created_by, updated_by, order_no, settingjson::text, 
     is_required 
     from labupw.labupw_content_type_fields 
     where content_type_id =p_content_type_id
	 and is_active=1 and is_deleted=0)r
	 into p_contenttypejson;
     
         p_result := 1;
         

end;
$$;


--
