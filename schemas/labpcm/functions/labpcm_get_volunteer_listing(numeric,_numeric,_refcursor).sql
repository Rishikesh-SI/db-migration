-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_get_volunteer_listing(numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: labpcm_get_volunteer_listing(numeric, numeric, refcursor); Type: FUNCTION; Schema: labpcm; Owner: -
--

CREATE FUNCTION labpcm.labpcm_get_volunteer_listing(p_pagenumber numeric, p_itemnumber numeric, p_volunteer_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

 declare 
 
  
 v_fromrownumber numeric;
   v_torownumber numeric;
 
  begin
  	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
  
open p_volunteer_cur for
select * from ( select volunteer_detail_id,volunteer_guid,is_shortlisted ,data,
			 rank()over(order by COALESCE(is_shortlisted,0) desc,volunteer_detail_id desc) rnk
	 from labpcm.labpcm_volunteer_detail
			  where is_active=1
			  and is_deleted =0) as tb
			where 	rnk between v_fromrownumber and v_torownumber;									   
			 		   
													   
													   
													   
exception when others
then
 null;

  end;
  
   

$$;


--
