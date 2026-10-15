-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_display_report(numeric, numeric, date, date)
-- Type: FUNCTION

-- Name: labpkl_v1_display_report(numeric, numeric, date, date); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_display_report(p_pagenumber numeric, p_itemnumber numeric, p_start_date_time date, p_end_date_time date, OUT p_count numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_start_date_time date;
	v_end_date_time date;
	v_datequery    varchar(200) := ' ';
begin

    -- page_falg =4 means careers
	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber := (p_pagenumber * p_itemnumber);
	
	v_start_date_time := p_start_date_time;
	v_end_date_time := p_end_date_time;
	
	if v_start_date_time is not null and v_end_date_time is not null then
		v_datequery := 'and (created_date + ''5.5 hours''::interval)::date between '''||v_start_date_time||''' and '''|| v_end_date_time||'''' ;
	end if;
	
    execute 'select count(1) from labpkl_v1.labpkl_v1_client_web_cust_model  
	where lower(module_name) = lower(''Join The Community'') '||v_datequery
	into p_count;
	
	execute'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb 
    from (select client_mod_json->''data'' user_data,row_number() over(order by (created_date,custom_module_id) desc) slno
          from labpkl_v1.labpkl_v1_client_web_cust_model 
		  where lower(module_name) = lower(''Join The Community'')'||v_datequery||'
		   )row
		   where slno between '|| v_fromrownumber ||'and '||v_torownumber 
		into p_json ;  
		   
    if p_count = 0 then
    	p_json := ('{"data":["data not available "]}')::jsonb;
    end if;
	
end;

$$;


--
