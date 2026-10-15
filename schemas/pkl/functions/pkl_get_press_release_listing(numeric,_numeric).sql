-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_get_press_release_listing(numeric, numeric)
-- Type: FUNCTION

-- Name: pkl_get_press_release_listing(numeric, numeric); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.pkl_get_press_release_listing(p_pagenumber numeric, p_itemnumber numeric, OUT p_preesreleasecount numeric, OUT p_preesreleasejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	  v_title						pkl.pkl_press_release.title%type;   
	  
      v_fromrownumber			numeric;
      v_torownumber				numeric;
      
         
begin
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     
   select count(1) into p_preesreleasecount 
   from pkl.pkl_press_release R;  
   
   select array_to_json(array_agg(A)) 
   into p_preesreleasejson
   from 
	( 	select row_number()over( order by R.published_date desc) slno,  
     	R.* ,  (select array_to_json(array_agg(B))
                from   (  select *  
                          from pkl.pkl_press_release_asset_map M
                        where M.press_release_id = R.press_release_id
                       )B
   				)asset_map
    	from pkl.pkl_press_release R
     ) A
     where slno between v_fromrownumber and v_torownumber ;
  
end;

 

$$;


--
