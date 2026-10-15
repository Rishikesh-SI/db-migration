-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_gallery_listing(numeric, numeric, numeric, numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labgt_get_gallery_listing(numeric, numeric, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_gallery_listing(p_gallery_type numeric, p_season_id numeric, p_status numeric, p_page1size numeric, p_pagenumber numeric, p_itemnumber numeric, p_opt_type numeric, OUT p_gallery_json jsonb, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_gallery_type_filter varchar(100) := ' ';
	v_season_filter varchar(100) := ' ';
	v_status_filter varchar(100) := ' ';
    v_gallery_id_arr numeric[];
    i numeric;
	p_user_guid character varying;
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
				from labgt.labgt_gallery a
				join labgt.labgt_web_user b
				on a.user_guid = b.user_guid
				where a.is_deleted=0 and a.is_active=1 and process_id=0 '
                ||v_gallery_type_filter
                ||v_season_filter
				||v_status_filter
				
	using p_gallery_type, p_season_id,p_status
    into p_count;
/* 
 select a.user_guid into p_user_guid
				from labgt.labgt_gallery a
				join labgt.labgt_web_user b
				on a.user_guid = b.user_guid
				where a.is_deleted=0 and a.is_active=1 and process_id=0;
			--	and gallery_type=3 and status=1 and season_id=0;
				
   raise notice '%  p_count',p_count;	 
 select a.user_guid into p_user_guid
				from alabgt.labgt_gallery a
				join labgt.labgt_web_user b
				on a.user_guid = b.user_guid
				where a.is_deleted=0 and a.is_active=1 and process_id=0;
 */
	if p_count > 0 then
	
		execute 'select array(select gallery_id
								from(select gallery_id, row_number() over(order by a.updated_date desc) rno
										from labgt.labgt_gallery a
										join labgt.labgt_web_user b
				  						on a.user_guid = b.user_guid
										where a.is_deleted=0 and a.is_active=1 and process_id=0 '
										||v_gallery_type_filter
										||v_season_filter
										||v_status_filter
										||') tab
								)'
		using p_gallery_type, p_season_id,p_status, v_fromrownumber, v_torownumber
		into v_gallery_id_arr;
		

		if array_length(v_gallery_id_arr, 1) <> 0 then
			
			UPDATE labgt.labgt_gallery a
			set process_id=300
			from labgt.labgt_web_user b
			where a.user_guid = b.user_guid
			and a.gallery_id = any(v_gallery_id_arr) -- in (v_gallery_id_arr)
			and a.process_id=0 ;
			
		
			
			select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
			from (select 
				  --gallery_id,
				  -- gallery_name, gallery_path, season_id, gallery_type, thumbnail,
				 -- 'https://stg-royalstag-fw.sportz.io/static-assets/'
				 -- || gallery_path || '/' || coalesce(a.user_guid,'')|| 
				  --'/'||is_gif_created||'/' ||gallery_name as url
				  --,frame_id
				  a.gallery_name,a.gallery_path,a.status,b.user_id,b.user_guid,a.gallery_id,
				  b.user_guid,b.profile_picture_url as user_img,b.social_user_name as user_name,
				  a.config_json,a.process_id,a.img_time,b.first_name,b.last_name,a.optype,a.gallery_guid
				  from labgt.labgt_gallery a
				  join labgt.labgt_web_user b
				  on a.user_guid = b.user_guid
				  where a.gallery_id =any(v_gallery_id_arr)
				 -- and a.process_id=0
				  order by a.updated_date desc
				  limit 10
				 ) row
			into p_gallery_json;
			
			
		
		else
			
			p_gallery_json := null;
			
		end if;
		
	else
		
		p_gallery_json := null;
		
	end if;
    
/*exception
	when others then
		p_count := 0;
		p_gallery_json := '{"items":[]}'::jsonb;
	*/
end;
$_$;


--
