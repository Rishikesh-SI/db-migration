-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_press_realease_listing_r(numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labmi_get_press_realease_listing_r(numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_press_realease_listing_r(p_language_id numeric, p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, OUT p_result numeric, OUT p_press_release_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_fromrownumber numeric;
    v_torownumber numeric;
    v_press_release_id_arr numeric[];
    v_press_release_count numeric;
    
begin
	
    if p_page1_size is null then
    	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
        v_torownumber := (p_pagenumber * p_itemnumber);
	else
    	if p_pagenumber = 1 then
        	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		else
        	v_fromrownumber := p_page1_size + ((((p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
		end if;
   		v_torownumber := p_page1_size + ((p_pagenumber - 1) * p_itemnumber);
	end if;
    
    select array(select press_release_id
                 from
                 (
                     select press_release_id,row_number() over(order by published_date desc) slno
                     from labmi.labmi_press_release_master
                     where status = 1 and is_trashed = 0
                 )a
                 where slno between v_fromrownumber and v_torownumber)
	into v_press_release_id_arr;
    
    select coalesce(array_length(v_press_release_id_arr, 1),0) into v_press_release_count;
        
    select ('{"items":['||string_agg(row_to_json(row)::text,',')||'],"count":'||v_press_release_count||'}')::jsonb
	from(
        select prmap.press_release_id,prmap.title,prmap.short_title,prmap.description,prmap.lang_id,prmap.lang_name,prmaster.zip_id,prmaster.zip_name,
        		prmaster.zip_path,prmaster.zip_size,prmaster.published_date,
         prmaster.updated_date,prmaster.guid,
        		prmaster.press_release_json->'data'->'image' image,
        		(/*select array_to_json(array_agg(a))
                 from(select
                      			prmap1.attachments->>'file_id' file_id,prmap1.attachments->>'file_name' file_name,prmap1.attachments->>'file_path' file_path,
                      			prmap1.attachments->>'file_size' file_size,prmap1.attachments->>'asset_type_id' asset_type_id,
                  				prmap1.attachments->>'file_type' file_type
                      from labmi.labmi_press_release_map prmap1
                      where prmap1.press_release_id = prmap.press_release_id)a*/
                select array_to_json(array_agg(a))
                    from(select prmap1.lang_id,prmap1.lang_name,prmap1.attachments
                         from labmi.labmi_press_release_map prmap1
                         where prmap1.press_release_id = prmap.press_release_id)a)attachment
        from labmi.labmi_press_release_map prmap
        join labmi.labmi_press_release_master prmaster
        on prmaster.press_release_id = prmap.press_release_id
        where prmap.lang_id = p_language_id
        and prmaster.press_release_id in(select press_release_id from 
                                         unnest(v_press_release_id_arr) u(press_release_id))
         order by prmaster.published_date desc
    )row
    into p_press_release_json;
    
    select case v_press_release_count when 0 then 0 else 1 end into p_result;
    
end;

$$;


--
