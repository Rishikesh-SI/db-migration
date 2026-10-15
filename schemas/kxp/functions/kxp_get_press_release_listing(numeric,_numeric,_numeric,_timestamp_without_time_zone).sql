-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_get_press_release_listing(numeric, numeric, numeric, timestamp without time zone)
-- Type: FUNCTION

-- Name: kxp_get_press_release_listing(numeric, numeric, numeric, timestamp without time zone); Type: FUNCTION; Schema: kxp; Owner: -
--

CREATE FUNCTION kxp.kxp_get_press_release_listing(p_status numeric, p_pagenumber numeric, p_itemnumber numeric, p_pressreleasedate timestamp without time zone, OUT p_preesreleasecount numeric, OUT p_preesreleasejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	  v_title						kxp.kxp_press_release.title%type;   
	  
      v_fromrownumber			numeric;
      v_torownumber				numeric;
      v_json			 varchar(4000) := '{"data":';
      v_date 				date[];
         
begin
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
   select count(1) into p_preesreleasecount 
   from kxp.kxp_press_release R
   where R.is_published = p_status;  
   
   if p_pressreleasedate is null then 
   	
  
    select array_agg(published_date::date)
    into v_date
    from  
    (select  published_date 
   	from kxp.kxp_press_release R
    group by published_date
   	order by published_date desc    
   	-- limit 10
     )A ;
     
   else 
   
   select array_agg(published_date::date) 
   into v_date
    from  
    (select   published_date 
   	 from kxp.kxp_press_release R
     where  published_date::date < p_pressreleasedate::date
     group by published_date
   	 order by published_date desc    
   	 limit 10
    )A ;
   
   end if ;
   
   select array_to_json(array_agg(A)) 
   into p_preesreleasejson
   from 
	( 	select row_number()over( order by R.published_date desc) slno,  
     	R.* ,  (select array_to_json(array_agg(B))
                from   (  select M.* 
                        	, pdf_name language_name,  pdf_display_name language_display_name   
                          from kxp.kxp_press_release_asset_map M
                           join kxp.kxp_pdf_master P 
                        on M.language_id = P.pdf_master_id
                        where M.press_release_id = R.press_release_id
                       )B
   				)asset_map
    	from kxp.kxp_press_release R
     	where R.is_published = p_status
     	and exists (select 1 from unnest(v_date) dt
                    where dt.dt = R.published_date::date)
     ) A
     where slno between v_fromrownumber and v_torownumber ;
   
   p_preesreleasejson := v_json || p_preesreleasejson ||'}';  

end;

$$;


--
