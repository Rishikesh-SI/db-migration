-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_club_listing_r(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labkc_v1_get_club_listing_r(numeric, numeric, numeric); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_club_listing_r(p_status numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_clubjson jsonb, OUT p_clubcount numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
declare
    p_schema_prefix text :='labkc_v1';
	/*
	p_status numeric:=1;
	p_authorid numeric:=null;
	p_pagenumber numeric:=1;
	p_itemnumber numeric:=10;
	p_searchkeyword character varying :='sa';
	p_entityrolemapid numeric[]:=array[7925];
	p_from_date timestamp without time zone:=null;
	p_to_date timestamp without time zone:=null;
	p_createdby numeric:=null;
	p_content_source_id numeric :=null;
    p_articlejson jsonb;
    p_articlecount numeric;
	*/
	v_fromrownumber numeric;
    v_torownumber numeric;

	
begin

		v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    	v_torownumber   := (p_pagenumber * p_itemnumber);
		
	  
	  select cnt,'{"data":'||json_agg(tab3)||'}' into p_clubcount,p_clubjson from (
	  select count(1) over() as cnt,*  from (														
	  select 
	  datajson->'data'->>'club_name' as club_name,
	  status,
	  a.created_date::timestamp,
	  b.updated_date::timestamp,
	  custom_id,
	remark,	 
		  b.country_code,
	  datajson->'data'->>'club_description' as club_description,
		(datajson->'data'->>'user_info')::jsonb as userdata,  
	  row_number() over(order by a.updated_date desc) slno	  
	  from labkc_v1.labkc_v1_custom_web_json a
		join labkc_v1.labkc_v1_web_user b on a.user_guid=b.user_guid  
	  where status=p_status
		)tab
	  where slno between v_fromrownumber and v_torownumber
      )TAB3
	  group by cnt;

	
	if p_clubcount is null then 
	p_clubjson :='{ "items": []}';
	p_clubcount:=0;
	end if;
	--raise notice '% check count',p_articlecount;
	-- raise notice '% json ',p_articlejson;
end;
$_$;


--
