-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_gallery_listing_web_r(jsonb)
-- Type: FUNCTION

-- Name: labwis_get_gallery_listing_web_r(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_gallery_listing_web_r(p_input jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	/* input json
	{
"pgnum": 1,
"inum": 10,
"user_guid":"3bb23624-8dfd-44ac-9e7a-dde2381450b3"
}
	*/
	
	v_pagenumber numeric;
	v_itemnumber numeric;
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_asset_id character varying;
	v_asset_type_id character varying;
	v_web_listing_json jsonb;
	v_user_guid character varying;
	v_count numeric;
	   
begin
     
	 select p_input->>'pgnum',
			p_input->>'inum',
			p_input->>'asset_id',
			p_input->>'asset_type_id',
			p_input->>'user_guid'
	into 	v_pagenumber,
			v_itemnumber,
			v_asset_id,
			v_asset_type_id,
			v_user_guid
			;
			
	v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
  	v_torownumber   := (v_pagenumber * v_itemnumber);
    
 --    raise notice 'v_fromrownumber: %',v_fromrownumber;
	-- raise notice 'v_torownumber:%',v_torownumber;
 --    raise notice 'p_data:%',p_data;
	-- raise notice 'v_asset_id:%',v_asset_id;
	-- raise notice 'user_guid:%',v_user_guid;
	
	select count(gallery_id) into v_count from labwis.labwis_gallery where user_guid=v_user_guid ;
	raise notice 'v_count:%',v_count;
	
	if (v_asset_id is not null) then --v_asset_type_id is not null and 
	raise notice 'if';
	select ('{"data":'||json_agg(row_to_json(row))::text||',"count":'||v_count||'}')::jsonb
	from
	(
select additional_info,gallery_type,url,gallery_id,rn, first_name, last_name,date, profile,thumbnail
from ((select additional_info, gallery_type,
				  'https://staging.wisden.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url,gallery_id,0 rn,
		  		wu.first_name as first_name, wu.last_name as last_name,g.created_date as date,profile_picture_url profile,
				'https://staging.wisden.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||coalesce(thumbnail,gallery_name) as thumbnail, wu.user_id, g.updated_date
		  from  labwis.labwis_gallery g
		 join labwis.labwis_web_user wu  using(user_guid) where g.status = 1 and 
		 g.gallery_id=30 
		 and case when v_user_guid is not null then 
		 user_guid = v_user_guid else true end
		 )
		 union all
	(select additional_info,gallery_type,url,gallery_id,rn, first_name, last_name,date, profile,thumbnail ,user_id,updated_date from 
		 (select additional_info, gallery_type,
				  'https://staging.wisden.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url,gallery_id,row_number() over(order by is_fav_comment desc,g.updated_date desc) rn,
		  		wu.first_name as first_name, wu.last_name as last_name,g.created_date as date,profile_picture_url profile,
				'https://staging.wisden.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||coalesce(thumbnail,gallery_name) as thumbnail , wu.user_id,g.updated_date
		  from  labwis.labwis_gallery g
		 join labwis.labwis_web_user wu  using(user_guid) where g.status = 1 and 
		 g.gallery_id<>30
		 and case when v_user_guid is not null then 
		 user_guid = v_user_guid else true end
		 )b
		 )) subquery order by subquery.user_id, subquery.updated_date desc
	)row		 
	into p_data	;
--raise notice '2:%',p_data;	

	ELSE
	raise notice 'else test';
		select ('{"data":'||json_agg(row_to_json(row))::text||',"count":'||v_count||'}')::jsonb
	from(select additional_info,gallery_type,url,gallery_id,rn, first_name, last_name,date, profile,thumbnail from 
		 (select additional_info, gallery_type,
				  'https://staging.wisden.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url,gallery_id,row_number() over(order by is_fav_comment desc,g.updated_date desc) rn,
		  		wu.first_name as first_name, wu.last_name as last_name,g.created_date as date,profile_picture_url profile,
				'https://staging.wisden.com/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||coalesce(thumbnail,gallery_name) as thumbnail
		  from  labwis.labwis_gallery g
		 join labwis.labwis_web_user wu  using(user_guid) where g.status = 1 and 
		 case when v_user_guid is not null then 
		 user_guid = v_user_guid else true end)b
		 where rn between v_fromrownumber and v_torownumber)row
	into p_data	;	
	end if;
 --raise notice '3:%',p_data;  
end;
$$;


--
