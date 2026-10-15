-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_gallery_listing_web_r_1042026(jsonb)
-- Type: FUNCTION

-- Name: labgt_get_gallery_listing_web_r_1042026(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_gallery_listing_web_r_1042026(p_input jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	/* input json
	{"pgnum":"1","inum":"10","asset_id":"","asset_type_id":"",
		"hashtag":""}
	*/
	
	v_pagenumber numeric;
	v_itemnumber numeric;
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_asset_id character varying;
	v_asset_type_id character varying;
	v_web_listing_json jsonb;
	   
begin
     
	 select p_input->>'pgnum',
			p_input->>'inum',
			p_input->>'asset_id',
			p_input->>'asset_type_id'
	into 	v_pagenumber,
			v_itemnumber,
			v_asset_id,
			v_asset_type_id
			;
			
	v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
  	v_torownumber   := (v_pagenumber * v_itemnumber);
    
--     raise notice '%',v_fromrownumber;
--     raise notice '%',v_torownumber;
raise notice '1:%',p_data;
	
	if (v_asset_id is not null) then --v_asset_type_id is not null and 
	
	select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
	from
	((select additional_info, gallery_type,
				  'https://www.gujarattitansipl.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url,gallery_id,0 rn,
		  		wu.first_name as first_name, wu.last_name as last_name,g.created_date as date,profile_picture_url profile,
				'https://www.gujarattitansipl.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||coalesce(thumbnail,gallery_name) as thumbnail
		  from  labgt.labgt_gallery g
		 join labgt.labgt_web_user wu  using(user_guid) where g.status = 1 and g.gallery_id=v_asset_id::numeric)
		 union all
	(select additional_info,gallery_type,url,gallery_id,rn, first_name, last_name,date, profile,thumbnail from 
		 (select additional_info, gallery_type,
				  'https://www.gujarattitansipl.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url,gallery_id,row_number() over(order by is_fav_comment desc,g.updated_date desc) rn,
		  		wu.first_name as first_name, wu.last_name as last_name,g.created_date as date,profile_picture_url profile,
				'https://www.gujarattitansipl.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||coalesce(thumbnail,gallery_name) as thumbnail
		  from  labgt.labgt_gallery g
		 join labgt.labgt_web_user wu  using(user_guid) where g.status = 1 and g.gallery_id<>v_asset_id::numeric)b
		 where rn between v_fromrownumber and v_torownumber))row	 
	into p_data	;
raise notice '2:%',p_data;	
	ELSE
	
		select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
	from(select additional_info,gallery_type,url,gallery_id,rn, first_name, last_name,date, profile,thumbnail from 
		 (select additional_info, gallery_type,
				  'https://www.gujarattitansipl.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url,gallery_id,row_number() over(order by is_fav_comment desc,g.updated_date desc) rn,
		  		wu.first_name as first_name, wu.last_name as last_name,g.created_date as date,profile_picture_url profile,
				'https://www.gujarattitansipl.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||coalesce(thumbnail,gallery_name) as thumbnail
		  from  labgt.labgt_gallery g
		 join labgt.labgt_web_user wu  using(user_guid) where g.status = 1)b
		 where rn between v_fromrownumber and v_torownumber)row
	into p_data	;	
	end if;
 raise notice '3:%',p_data;  
end;
$$;


--
