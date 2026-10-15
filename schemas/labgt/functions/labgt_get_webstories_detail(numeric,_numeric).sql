-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_webstories_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labgt_get_webstories_detail(numeric, numeric); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_webstories_detail(p_webstoryid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_webstoryjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
 

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_created_by numeric;
	 v_checked_out_by numeric;
	 v_checked_out_by_name character varying;
	 v_created_by_name character varying;
	 v_content_type_fields jsonb;
	 i jsonb ;
	 v_imageName character varying;
	 v_imagePath character varying;
	 v_full_img_path character varying;
	 counter numeric :=0;
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  labgt.labgt_webstory
          where  	  webstory_id = p_webstoryid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
	 
	 
	 select created_by,checked_out_by from labgt.labgt_webstory where webstory_id=p_webstoryid into v_created_by,v_checked_out_by;
	 select display_name into v_checked_out_by_name from labgt.labgt_user where user_id = v_checked_out_by;
     select display_name into v_created_by_name from labgt.labgt_user where user_id = v_created_by;

     select asset_data
     into strict p_webstoryjson
     from   	  labgt.labgt_asset_draft
     where  	  asset_type_id  = 142
     and    	  asset_id       = p_webstoryid
	and    	  version_number = v_versionnumber;

raise notice '1';	
    
--          select json_agg(tab) from
--      (
--     SELECT b.content_type_field_id as content_field_id,b.content_type_id, b.field_name, b.field_data_type, b.field_defaultvalue, b.field_type, b.field_label, b.show_in_listing_json, b.is_active, b.is_deleted, b.created_date,b.updated_date, b.created_by, b.updated_by,b.order_no, b.settingjson::text, b.is_required
--          from labgt.labgt_content_type_fields b 
--      left join labgt.labgt_asset_type a
--      on a.asset_type_id = b.content_type_id
--          and a.is_content_type=1
--      where b.is_active=1
--      )tab
--      into v_content_type_fields;

--     p_webstoryjson := jsonb_set(p_webstoryjson,'{data,breakout_code}',coalesce(v_content_type_fields,'[]'),true);
     
     select image_path
     into   v_image_path
     from 	labgt.labgt_image
     where image_id = (
     select webstory_id
     from   labgt.labgt_webstory_asset_map
     where  webstory_id = p_webstoryid limit 1
     --and is_cover = 1
	 );
     
     -- p_webstoryjson := jsonb_set(p_webstoryjson,'{data,image_path}',v_image_path::jsonb,true);
	 p_webstoryjson :=jsonb_set(p_webstoryjson,'{data,created_by}',('"'||coalesce(v_created_by::text,'')||'"')::jsonb, true);
	 p_webstoryjson := jsonb_set(p_webstoryjson,'{data,checked_out_by}',to_jsonb(coalesce((v_checked_out_by)::text,'')), true);
	 p_webstoryjson := jsonb_set(p_webstoryjson,'{data,checked_out_by_name}',to_jsonb(coalesce((v_checked_out_by_name)::text,'')), true);
	 p_webstoryjson := jsonb_set(p_webstoryjson,'{data,created_by_name}',to_jsonb(coalesce((v_created_by_name)::text,'')), true);

	--  for i in select jsonb_array_elements(p_webstoryjson->'data'->'slides')->'data'
	--  loop
	--  select i->'photoimagdata'->>'imageName',
	--  i->'photoimagdata'->>'imagePath'
	--  into 
	--  v_imageName,
	--  v_imagePath;

	 
	--  v_full_img_path := 'https://staging.wisden.com/static-assets/waf-images/'||v_imagePath||'/'||v_imageName;
	--  p_webstoryjson := jsonb_set(p_webstoryjson,array['data', 'slides', counter::text, 'data', 'photoimagdata', 'full_img_path'],to_jsonb(coalesce((v_full_img_path)::text,'')), true);
	 
	-- counter = counter+1;
	--  end loop;
	 
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
end;

 
$$;


--
