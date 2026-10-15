-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_get_files_list(numeric[], numeric, numeric)
-- Type: FUNCTION

-- Name: labbg_get_files_list(numeric[], numeric, numeric); Type: FUNCTION; Schema: labbg; Owner: -
--

CREATE FUNCTION labbg.labbg_get_files_list(p_asset_type_id numeric[], p_pagenumber numeric, p_itemnumber numeric, OUT p_count numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_fromrownumber numeric;
    v_torownumber numeric;
begin

  
	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber := (p_pagenumber * p_itemnumber);
    
	select count(1) into p_count
										from labbg.labbg_image 
										where asset_type_id = any (p_asset_type_id);
	
    select ('{"data":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb into p_json
    from (
			select image_id as id ,image_path  as file_path ,
                                          image_file_name as file_name ,
										asset_type_id,
										row_number() over(order by created_date desc) slno
										from labbg.labbg_image 
										where asset_type_id = any (p_asset_type_id)
										order by created_date desc																	
	     )row
	where slno between v_fromrownumber and v_torownumber;
   
   if p_count = 0 then
    	p_json := ('{"data":["data not available "]}')::jsonb;
    end if;
end;

$$;


--
