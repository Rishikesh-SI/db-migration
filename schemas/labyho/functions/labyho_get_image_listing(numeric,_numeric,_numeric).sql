-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_image_listing(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labyho_get_image_listing(numeric, numeric, numeric); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_image_listing(p_status numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_result numeric, OUT p_imagecount numeric, OUT p_imagejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
-- 	v_fromrownumber numeric;
-- 	v_torownumber numeric;
	v_offset numeric := p_itemnumber * (p_pagenumber - 1);
	v_filter_timestamp timestamp := current_timestamp at time zone 'utc' - '1 year'::interval;
     
begin
	
-- 	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
-- 	v_torownumber := (p_pagenumber * p_itemnumber);
	
	select count(*)
	into p_imagecount
	from labyho.labyho_image
	where created_date >= v_filter_timestamp;
	
	select ('{"items":'||json_agg(row_to_json(row))::text||'}')::jsonb
	from (select row_number() over() slno, image_id, image_caption, image_path, image_file_name, title_alias
		  from labyho.labyho_image
		  where created_date >= v_filter_timestamp
		  order by created_date desc
		  limit p_itemnumber
		  offset v_offset
		 )row
	into p_imagejson;
	
	if p_imagejson is not null then
		p_result := 1;
	else
		p_result := 0;
		p_imagejson := '{"items":[]}';
	end if;
	
exception
	
     when others then
     	
          p_result := -1;
          p_imagejson := '{"items":[]}';

end;

 $$;


--
