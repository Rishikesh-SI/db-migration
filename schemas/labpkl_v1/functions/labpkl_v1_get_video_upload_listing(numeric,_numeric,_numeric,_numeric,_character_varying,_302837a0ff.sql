-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_get_video_upload_listing(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone, numeric, numeric)
-- Type: FUNCTION

-- Name: labpkl_v1_get_video_upload_listing(numeric, numeric, numeric, numeric, character varying, numeric[], timestamp without time zone, timestamp without time zone, numeric, numeric); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_get_video_upload_listing(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_entityrolemapid numeric[], p_from_date timestamp without time zone, p_to_date timestamp without time zone, p_createdby numeric, p_content_source_id numeric, OUT p_videocount numeric, OUT p_videojson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_fromrownumber         numeric;
    v_torownumber           numeric;    
    
begin
	
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);
	
	raise notice '%',v_torownumber;
	
	select count(*) into p_videocount from labpkl_v1.labpkl_v1_video_upload
	where is_active = p_status ;
	
	select '{"data":['||string_agg(video_json::text,',')||']}'  into p_videojson from
	(select video_json->'data' as video_json ,row_number() over (order by updated_date desc) slno
	from labpkl_v1.labpkl_v1_video_upload
	where is_active = p_status) tab
	where slno between v_fromrownumber and v_torownumber ; 
	
	
	
    
   
    
 /*exception
	
     when others then
      	p_articlecount := -1;
          p_articlejson  := '{"items":[]}';*/
     
end;

 
$$;


--
