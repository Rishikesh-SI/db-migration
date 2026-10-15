-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_gallery_listing_r_26_12_2025(numeric, numeric, numeric, numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labkc_v1_get_gallery_listing_r_26_12_2025(numeric, numeric, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_gallery_listing_r_26_12_2025(p_gallery_type numeric, p_season_id numeric, p_status numeric, p_page1size numeric, p_pagenumber numeric, p_itemnumber numeric, p_opt_type numeric, OUT p_gallery_json jsonb, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_gallery_type_filter varchar(100) := ' ';
	v_season_filter varchar(100) := ' ';
	v_status_filter varchar(100) := ' ';
    v_gallery_id_arr numeric[];
	v_opt_type numeric;
	v_first_name varchar;
	v_last_name  varchar;
    
begin

    if p_page1size is null then
    	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		raise notice 'v_fromrownumber %',v_fromrownumber;
        v_torownumber   := p_pagenumber * p_itemnumber;
		raise notice 'v_torownumber %', v_torownumber;
	else
    	if p_pagenumber = 1 then
        	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		else
        	v_fromrownumber := p_page1size + ( (( (p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
		end if;
		v_torownumber   := p_page1size + ( (p_pagenumber-1) * p_itemnumber);
	end if;
    
    if p_gallery_type is not null then
    	v_gallery_type_filter := ' and gallery_type = $1 ';
    end if;
    
	if p_season_id is not null then
    	v_season_filter := ' and coalesce(season_id,0) = $2 ';
		raise notice 'v_season_filter %',v_season_filter;
    end if;
	
	if p_status is not null then
    	v_status_filter := ' and status = $3 ';
		raise notice 'v_status_filter %',v_status_filter;
    end if;
	
	v_opt_type := coalesce(p_opt_type,1);
	
    raise notice 'v_opt_type %',v_opt_type;
    execute 'select count(1)
				from labkc_v1.labkc_v1_gallery g
				  join labkc_v1.labkc_v1_web_user wu using(user_guid)
				where g.is_deleted= 0 and g.is_active=1 '
--                 ||v_gallery_type_filter
--                 ||v_season_filter
				||v_status_filter
	using p_gallery_type, p_season_id,p_status,v_opt_type
    into p_count;
    
	raise notice 'p_count %',p_count;
	
	if p_count > 0 then
	
		execute 'select array(select gallery_id
								from(select gallery_id, row_number() over(order by updated_date desc) rno
										from labkc_v1.labkc_v1_gallery
										where  is_deleted=0 and is_active=1'
										--||v_season_filter
										||v_status_filter
										||') tab
								where rno between $4 and $5)'
		using p_gallery_type, p_season_id,p_status, v_fromrownumber, v_torownumber,v_opt_type
		into v_gallery_id_arr;
		
		--raise notice '%',v_opt_type;
		--raise notice 'v_gallery_id_arr %',v_gallery_id_arr;
	--	if array_length(v_gallery_id_arr, 1) <> 0 then
		
		--raise notice 'p_count %',p_count;
	
		
		--raise notice 'v_first_name %', v_first_name;
		
		
			select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
			from (select gallery_id,comment,is_fav_comment,gallery_name,gallery_path,
				  season_id, gallery_type, thumbnail,url
				  ,frame_id,user_guid,additional_info,json_build_object('first_name',first_name,'last_name',last_name) as user_info, status , user_guid from
				  (select 
				  gallery_id,comment,coalesce(is_fav_comment,0) as is_fav_comment,
				   gallery_name, gallery_path, season_id, gallery_type, thumbnail,
				  'https://stg-kc.sportz.io/static-assets/'
				 || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url
				  ,frame_id,g.user_guid as user_guid,g.additional_info as additional_info,wu.first_name as first_name, wu.last_name as last_name,
				  g.status
				 -- ,*
				  from labkc_v1.labkc_v1_gallery g
				  join labkc_v1.labkc_v1_web_user wu using(user_guid)
				  where gallery_id =any(v_gallery_id_arr)
				  order by g.updated_date desc)a
				 ) row
			into p_gallery_json;
			
			
-- 			p_gallery_json:=jsonb_set(p_gallery_json, '{data,user_info,first_name}',coalesce(v_first_name,''), true);
-- 			p_gallery_json:=jsonb_set(p_gallery_json, '{data,user_info,last_name}',coalesce(v_last_name,'null'), true);
			
			
			
-- 		else
			
-- 			p_gallery_json := '{"items":[]}'::jsonb;
			
-- 		end if;
		
	else
		
		p_gallery_json := '{"items":[]}'::jsonb;
		
	end if;
    
/*exception
	when others then
		p_count := 0;
		p_gallery_json := '{"items":[]}'::jsonb;
	*/
end;
$_$;


--
