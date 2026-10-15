-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_gallery_listing_web_r(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_gallery_listing_web_r(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_gallery_listing_web_r(p_input jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	/* input json
	{"pgnum":"1","inum":"10"}
	*/
	
	v_pagenumber numeric;
	v_itemnumber numeric;
	v_fromrownumber numeric;
    v_torownumber numeric;
	   
begin
     
	 select p_input->>'pgnum',
			p_input->>'inum'			
	into 	v_pagenumber,
			v_itemnumber ;
			
	v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
  	v_torownumber   := (v_pagenumber * v_itemnumber);		
	
	select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
	from(select comment,gallery_id,rn from 
		 (select comment,gallery_id,row_number() over(order by is_fav_comment desc,updated_date desc) rn 
		  from  labrr.labrr_gallery where optype = 2 and status = 1)b
		 where rn between v_fromrownumber and v_torownumber)row
	into p_data	;
   
end;
$$;


--
