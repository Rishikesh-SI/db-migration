-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_press_release_listing(numeric, numeric, numeric, timestamp without time zone)
-- Type: FUNCTION

-- Name: zeven_get_press_release_listing(numeric, numeric, numeric, timestamp without time zone); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_press_release_listing(p_status numeric, p_pagenumber numeric, p_itemnumber numeric, p_pressreleasedate timestamp without time zone, OUT p_preesreleasecount numeric, OUT p_preesreleasejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_fromrownumber			numeric;
	v_torownumber				numeric;
    v_publisheddate timestamp := p_pressreleasedate - INTERVAL '1 day';
	v_json			 varchar(4000) := '{"data":';
	
begin
	
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);
    
   	select count(1) into p_preesreleasecount 
   	from zeven.zeven_press_release R
   	where R.is_published = p_status
   	and published_date <= coalesce(v_publisheddate,published_date);
   	
   	select array_to_json(array_agg(A)) 
   	into p_preesreleasejson
   from 
	( 	select row_number()over(order by R.created_date desc) slno,  
     	R.* ,  (select array_to_json(array_agg(B))
                from   (  select M.* 
                        	, P.pdf_name language_name,  P.pdf_display_name language_display_name   
                          from zeven.zeven_press_release_asset_map M
                           join zeven.zeven_pdf_master P 
                        on M.language_id = P.pdf_master_id
                        where M.press_release_id = R.press_release_id
                       )B
   				)asset_map
    	from zeven.zeven_press_release R
     	where R.is_published = p_status
     	and published_date <= coalesce(v_publisheddate,published_date)
     ) A
     where slno between v_fromrownumber and v_torownumber ;
   
   	p_preesreleasejson := v_json || p_preesreleasejson ||'}';  

end;

$$;


--
