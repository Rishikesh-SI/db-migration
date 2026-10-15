-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_ins_upd_video_upload(jsonb)
-- Type: FUNCTION

-- Name: labpkl_v1_ins_upd_video_upload(jsonb); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_ins_upd_video_upload(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
/*{
  "data": {
    "id": "",
    "asset_type": "1",
    "videotype":"1",
    "fullpath":"s3://apsouth1.aws.com/path/<filename>/input/<filename>",
    "is_publish": "1",
    "published_date": "2021-12-13 07:36:00",
    "status": "1",
    "created_by": "1",
    "edited_by": "81",
    "created_by_name": null,
    "edited_by_name": null
  }
}*/
	v_video_upload_id numeric;
	v_asset_type_id numeric;
	v_videotype numeric;
	v_fullpath character varying;
	v_created_by numeric;
    v_updated_by numeric;
	v_is_published numeric;
	v_published_date timestamp;
	v_status numeric;

	begin
    
	select p_json->'data'->>'id',
		   p_json->'data'->>'asset_type',
		   p_json->'data'->>'videotype',
		   p_json->'data'->>'fullpath',
		   p_json->'data'->>'is_publish',
		   p_json->'data'->>'published_date',
		   p_json->'data'->>'created_by',
		   p_json->'data'->>'edited_by',
		   p_json->'data'->>'status'
	into   v_video_upload_id,
	       v_asset_type_id,
		   v_videotype,
		   v_fullpath,
		   v_is_published,
		   v_published_date,
		   v_created_by,
		   v_updated_by,
		   v_status ;
	
	if v_video_upload_id is null then
	 
	     v_video_upload_id :=  nextval('labpkl_v1.seq_labpkl_v1_video_upload_id') ;
		 
		 p_json := jsonb_set(p_json, '{data,id}', v_video_upload_id::text::jsonb, true);
		 
		 insert into labpkl_v1.labpkl_v1_video_upload(video_upload_id,asset_type_id ,videotype,fullpath,
													  created_date,updated_date,published_date,created_by,
													  updated_by,is_active,is_deleted,is_published,
													  asset_guid,video_json)
		 values(v_video_upload_id,v_asset_type_id,v_videotype,v_fullpath,current_timestamp at time zone 'utc',
			    current_timestamp at time zone 'utc',v_published_date,v_created_by,v_updated_by,
			     v_status,case v_status when 1 then 0 when 0 then 1 end,v_is_published,uuid_generate_v4(),p_json);
				 
				 
				 
	 else
	 	update labpkl_v1.labpkl_v1_video_upload
		set videotype = coalesce(v_videotype,videotype),
		    fullpath =   coalesce(v_fullpath,fullpath),
		    updated_date = current_timestamp at time zone 'utc',
			updated_by = coalesce(v_updated_by,updated_by),
			is_active = coalesce(v_status,is_active),
			is_deleted = case v_status when 1 then 0 when 0 then 1 end,
			is_published = coalesce(v_is_published,is_published),
			video_json = p_json
		where video_upload_id =	v_video_upload_id ;
			 
	 end if;
	
	
	p_result :=  1;	   
		   

	end;

	
$$;


--
