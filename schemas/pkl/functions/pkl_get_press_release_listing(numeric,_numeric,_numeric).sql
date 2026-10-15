-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_get_press_release_listing(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: pkl_get_press_release_listing(numeric, numeric, numeric); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.pkl_get_press_release_listing(p_status numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_preesreleasecount numeric, OUT p_preesreleasejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	  v_title						pkl.pkl_press_release.title%type;   
	  
      v_fromrownumber			numeric;
      v_torownumber				numeric;
      v_json			 varchar(4000) := '{"data":';
         
begin
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
   select count(1) into p_preesreleasecount 
   from pkl.pkl_press_release R
   where R.is_published = p_status;  
   
   select array_to_json(array_agg(A)) 
   into p_preesreleasejson
   from 
	( 	select row_number()over( order by R.published_date desc) slno,  
     	R.* ,  (select array_to_json(array_agg(B))
                from   (  select M.* 
                        	, pdf_name language_name,  pdf_display_name language_display_name   
                          from pkl.pkl_press_release_asset_map M
                           join pkl.pkl_pdf_master P 
                        on M.language_id = P.pdf_master_id
                        where M.press_release_id = R.press_release_id
                       )B
   				)asset_map
    	from pkl.pkl_press_release R
     	where R.is_published = p_status
     ) A
     where slno between v_fromrownumber and v_torownumber ;
   
   p_preesreleasejson := v_json || p_preesreleasejson ||'}';  

end;

$$;


--
