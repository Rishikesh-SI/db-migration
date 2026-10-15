-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_gallery_listing_admin_r(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_get_gallery_listing_admin_r(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_gallery_listing_admin_r(p_json jsonb, OUT p_gallery_json jsonb, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
    p_gallery_type numeric;
	p_status numeric;
	p_user_guid character varying;
	p_season_id numeric;
	p_page1size numeric;
	p_pagenumber numeric;
	p_itemnumber numeric;
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_gallery_type_filter varchar(100) := ' ';
	v_season_filter varchar(100) := ' ';
	v_status_filter varchar(100) := ' ';
    v_gallery_id_arr numeric[];
	v_filtertype varchar(100);
	v_user_guid_filter varchar(300) := ' ';
    
begin

            select p_json->>'p_page1size',
				   p_json->>'page',
				   p_json->>'item',
				   p_json->>'filtertype',
				   p_json->>'galleryType'
				   
            		
            		
    		into   p_page1size,
			       p_pagenumber,
				   p_itemnumber,
				   v_filtertype,
				   p_gallery_type;
	
	p_status:=1;
	p_season_id:=0;
	
	if v_filtertype='admin' or v_filtertype='mi' then
	   v_user_guid_filter :='and user_guid=''571a5989-99f9-443a-b372-d1fa22b311b5''';
	elseif v_filtertype='user' then
	   v_user_guid_filter :='and user_guid!=''571a5989-99f9-443a-b372-d1fa22b311b5''';
	end if;
    				
            

	
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
				from labmi_v1.labmi_v1_gallery
				where is_deleted=0 and is_active=1 '
				||v_user_guid_filter
                ||v_gallery_type_filter
                ||v_season_filter
				||v_status_filter
	using p_gallery_type, p_season_id,p_status,p_user_guid
    into p_count;
    
	if p_count > 0 then
	
		execute 'select array(select gallery_id
								from(select gallery_id, row_number() over(order by updated_date desc) rno
										from labmi_v1.labmi_v1_gallery
										where is_deleted=0 and is_active=1'
										||v_user_guid_filter
										||v_gallery_type_filter
										||v_season_filter
										||v_status_filter
										||') tab
								where rno between $5 and $6)'
		using p_gallery_type, p_season_id,p_status,p_user_guid, v_fromrownumber, v_torownumber
		into v_gallery_id_arr;
		
		if array_length(v_gallery_id_arr, 1) <> 0 then
			
			select ('{"items":'||json_agg(row_to_json(row))::text||'}')::jsonb
			from (select 
				  
				  'https://beta-mi.sportz.io/static-assets/'
				  || gallery_path || '/' || coalesce(user_guid,'')|| 
				  '/'||is_gif_created||'/' ||gallery_name as url
				   ,gallery_id
				  from labmi_v1.labmi_v1_gallery
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
