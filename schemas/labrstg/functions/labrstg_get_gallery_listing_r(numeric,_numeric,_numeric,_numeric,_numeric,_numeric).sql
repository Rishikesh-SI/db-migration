-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_gallery_listing_r(numeric, numeric, numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labrstg_get_gallery_listing_r(numeric, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_gallery_listing_r(p_gallery_type numeric, p_season_id numeric, p_status numeric, p_page1size numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_gallery_json jsonb, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_gallery_type_filter varchar(100) := ' ';
	v_season_filter varchar(100) := ' ';
	v_status_filter varchar(100) := ' ';
    v_gallery_id_arr numeric[];
    
begin
	
    if p_page1size is null then
    	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
        v_torownumber   := p_pagenumber * p_itemnumber;
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
    	v_season_filter := ' and season_id = $2 ';
    end if;
	
	if p_status is not null then
    	v_status_filter := ' and status = $3 ';
    end if;
    
    execute 'select count(1)
				from labrstg.labrstg_gallery
				where is_deleted=0 and is_active=1'
                ||v_gallery_type_filter
                ||v_season_filter
				||v_status_filter
	using p_gallery_type, p_season_id,p_status
    into p_count;
    
	if p_count > 0 then
	
		execute 'select array(select gallery_id
								from(select gallery_id, row_number() over(order by updated_date desc) rno
										from labrstg.labrstg_gallery
										where optype=1 and is_deleted=0 and is_active=1'
										||v_gallery_type_filter
										||v_season_filter
										||v_status_filter
										||') tab
								where rno between $4 and $5)'
		using p_gallery_type, p_season_id,p_status, v_fromrownumber, v_torownumber
		into v_gallery_id_arr;
		
		if array_length(v_gallery_id_arr, 1) <> 0 then
			
			select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
			from (select 
				  --gallery_id,
				  -- gallery_name, gallery_path, season_id, gallery_type, thumbnail,
				  'https://stg-royalstag-fw.sportz.io/static-assets/'
				  || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url
				  --,frame_id
				  ,*
				  from labrstg.labrstg_gallery
				  where gallery_id =any(v_gallery_id_arr)
				  order by updated_date desc
				 ) row
			into p_gallery_json;
			
		else
			
			p_gallery_json := '{"items":[]}'::jsonb;
			
		end if;
		
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
