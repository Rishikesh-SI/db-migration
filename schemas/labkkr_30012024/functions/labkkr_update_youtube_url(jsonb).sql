-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_update_youtube_url(jsonb)
-- Type: FUNCTION

-- Name: labkkr_update_youtube_url(jsonb); Type: FUNCTION; Schema: labkkr_30012024; Owner: -
--

CREATE FUNCTION labkkr_30012024.labkkr_update_youtube_url(v_json jsonb, OUT para numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_video_array jsonb;
v_vide_data jsonb;
v_videogram_url character varying;
v_youtube_url character varying;
v_asset_id numeric;
v_version_number numeric;
v_web_listing_json jsonb;
v_web_detail_jsn jsonb;
v_asset_data jsonb;
begin

select v_json->>'data' into v_video_array;
for v_vide_data in select * from jsonb_array_elements(v_video_array)
      loop
        select v_vide_data->>'video_gram_url',
       v_vide_data->>'youtube_url'
	   into
	   v_videogram_url,
	   v_youtube_url;
    begin
	
	   raise notice ' v_videogram_url %',v_videogram_url;
	
 	    select video_id into v_asset_id
		from labkkr.labkkr_video
		where video_url=v_videogram_url;
		
		raise notice ' v_asset_id %',v_asset_id;
		
		update labkkr.labkkr_video
		set video_url=v_youtube_url,content_source_id=1
		where video_id=v_asset_id;
		
		
		select published_version_number,web_listing_json,web_detail_jsn
		into v_version_number,v_web_listing_json,v_web_detail_jsn
		from labkkr.labkkr_asset_list
		where asset_id=v_asset_id and asset_type_id=4;
		
		--raise notice ' json data %',v_web_listing_json;
		--raise notice 'v_web_detail_jsn %',v_web_detail_jsn;
		
		
		v_web_listing_json:=jsonb_set(v_web_listing_json, '{content_source_id}','"1"', true);
		
		v_web_listing_json = replace(v_web_listing_json::TEXT,v_videogram_url,v_youtube_url)::jsonb ;
		

		
		
		v_web_detail_jsn:=jsonb_set(v_web_detail_jsn,'{data,content_source_id}','"1"', true);
		v_web_detail_jsn:=jsonb_set(v_web_detail_jsn,'{data,videosourceid}','"1"', true);
		--v_web_detail_jsn:=jsonb_set(v_web_detail_jsn,'{data,video_url}',v_youtube_url, true);
		--raise notice 'before update %',v_web_detail_jsn;
		v_web_detail_jsn = replace(v_web_detail_jsn::TEXT,v_videogram_url,v_youtube_url)::jsonb ;
		--raise notice 'after update %',v_web_detail_jsn;
		
		update labkkr.labkkr_asset_list
		set web_listing_json=v_web_listing_json,
		web_detail_jsn=v_web_detail_jsn
		where asset_id=v_asset_id and asset_type_id=4;
		
		select asset_data
		into v_asset_data
		from labkkr.labkkr_asset_draft
		where asset_id=v_asset_id and asset_type_id=4 and version_number=v_version_number;
		
		v_asset_data:=jsonb_set(v_asset_data,'{content_source_id}','"1"', true);
		--v_asset_data:=jsonb_set(v_asset_data,'{video_url}',v_youtube_url, true);
		--raise notice 'before update v_asset_data %',v_asset_data;
		v_asset_data = replace(v_asset_data::TEXT,v_videogram_url,v_youtube_url)::jsonb ;
		v_asset_data:=jsonb_set(v_asset_data,'{videosourceid}','"1"', true);
		--raise notice 'after update v_asset_data %',v_asset_data;
		
		
		--select 1/0;
		update labkkr.labkkr_asset_draft
		set asset_data=v_asset_data
		where asset_id=v_asset_id and asset_type_id=4;
  end;
  
end loop;
para:=1;
end;
$$;


--
