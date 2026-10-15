-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_get_gallery_listing_web_r(jsonb)
-- Type: FUNCTION

-- Name: lablsg_get_gallery_listing_web_r(jsonb); Type: FUNCTION; Schema: lablsg; Owner: -
--

CREATE FUNCTION lablsg.lablsg_get_gallery_listing_web_r(p_input jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	/* input json
	{"pgnum":"1","inum":"10"}
	*/
	
	v_pagenumber numeric;
	v_itemnumber numeric;
	v_fromrownumber numeric;
    v_torownumber numeric;
	   
begin
     
	 select p_input->>'pgnum',
			p_input->>'inum'			
	into 	v_pagenumber,
			v_itemnumber ;
			
	v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
  	v_torownumber   := (v_pagenumber * v_itemnumber);
	select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
	from(select additional_info,gallery_type,url,gallery_id,rn, first_name, last_name,date, profile from 
		 (select additional_info, gallery_type,
				  'https://stg-gujarat-titans.sportz.io/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url,gallery_id,row_number() over(order by is_fav_comment desc,g.updated_date desc) rn,
		  		wu.first_name as first_name, wu.last_name as last_name,g.created_date as date,profile_picture_url profile
		  from  lablsg.lablsg_gallery g
		 join lablsg.lablsg_web_user wu  using(user_guid) where g.status = 1)b
		 where rn between v_fromrownumber and v_torownumber)row
	into p_data	;
   
end;
$$;


--
