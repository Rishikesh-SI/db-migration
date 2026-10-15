-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_gallery_listing_web_r_03march2026(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_get_gallery_listing_web_r_03march2026(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_gallery_listing_web_r_03march2026(p_input jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	/* input json
	{"pgnum":"1","inum":"10","asset_id":"","asset_type_id":""}
	*/
	
	v_pagenumber numeric;
	v_itemnumber numeric;
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_asset_id character varying;
	v_asset_type_id character varying;
	v_web_listing_json jsonb;
	v_gallery_type text;
	v_gallery_type_arr numeric[];
	   
begin
     
	 select p_input->>'pgnum',
			p_input->>'inum',
			p_input->>'asset_id',
			p_input->>'asset_type_id',
			p_input->>'gallery_type'
	into 	v_pagenumber,
			v_itemnumber,
			v_asset_id,
			v_asset_type_id,
			v_gallery_type;
			
	v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
  	v_torownumber   := (v_pagenumber * v_itemnumber);
    
     raise notice 'v_fromrownumber:%',v_fromrownumber;
     raise notice 'v_pagenumber:%',v_torownumber;
	 raise notice '1p data: %',p_data;

	 v_gallery_type_arr := 
	    case
		  when v_gallery_type is null or v_gallery_type = '' then null
		  else string_to_array(v_gallery_type, ',')::numeric[]
		end;
	
	if (v_asset_id is not null) then --v_asset_type_id is not null and 
	
	select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
	from
	((select additional_info, gallery_type,
				  'https://stagingapps.kkr.in/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url,
	  gallery_id,0 rn,
		  		wu.first_name as first_name, wu.last_name as last_name,g.created_date as date,profile_picture_url profile,
				'https://stagingapps.kkr.in/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||coalesce(thumbnail,gallery_name) as thumbnail
		  from  labkc_v1.labkc_v1_gallery g
		 join labkc_v1.labkc_v1_web_user wu using(user_guid) 
	  
	  where g.status = 1 and g.gallery_id=v_asset_id::numeric and (v_gallery_type_arr is null or g.gallery_type = any(v_gallery_type_arr)))
		 union all
	 
	 
	 
	(select additional_info,gallery_type,url,gallery_id,rn, first_name, last_name,date, profile,thumbnail from 
		 (select additional_info, gallery_type,
				  'https://stagingapps.kkr.in/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url,gallery_id,row_number() over(order by g.created_date desc) rn,
		  		wu.first_name as first_name, wu.last_name as last_name,g.created_date as date,profile_picture_url profile,
				'https://stagingapps.kkr.in/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||coalesce(thumbnail,gallery_name) as thumbnail
		  from  labkc_v1.labkc_v1_gallery g
		 join labkc_v1.labkc_v1_web_user wu using(user_guid) where g.status = 1 and g.gallery_id<>v_asset_id::numeric and (v_gallery_type_arr is null or g.gallery_type = any(v_gallery_type_arr)))b
		 where rn between v_fromrownumber and v_torownumber))row	 
	into p_data	;
	raise notice '2p data: %',p_data;
	
	ELSE
	
		select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
	from(select additional_info,gallery_type,url,gallery_id,rn, first_name, last_name,date, profile,thumbnail from 
		 (select additional_info, gallery_type,
				  'https://stagingapps.kkr.in/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url,gallery_id,row_number() over(order by g.created_date desc) rn,
		  		wu.first_name as first_name, wu.last_name as last_name,g.created_date as date,profile_picture_url profile,
				'https://stagingapps.kkr.in/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||coalesce(thumbnail,gallery_name) as thumbnail
		  from  labkc_v1.labkc_v1_gallery g
		 join labkc_v1.labkc_v1_web_user wu using(user_guid) where g.status = 1 and (v_gallery_type_arr is null or g.gallery_type = any(v_gallery_type_arr)))b
		 where rn between v_fromrownumber and v_torownumber)row
	into p_data;
	
	
	end if;
   raise notice '3p data: %',p_data;
end;
$$;


--
