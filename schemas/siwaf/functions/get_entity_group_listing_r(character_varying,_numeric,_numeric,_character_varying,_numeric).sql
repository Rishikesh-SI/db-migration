-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entity_group_listing_r(character varying, numeric, numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: _get_entity_group_listing_r(character varying, numeric, numeric, character varying, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entity_group_listing_r(p_schema_prefix character varying, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_is_active numeric, OUT p_entitygroupcount numeric, OUT p_entitygroupjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	 v_fromrownumber numeric;
     v_torownumber numeric;
     v_search_keyword varchar(4000) := upper(p_searchkeyword);
     v_search_query varchar(4000) := ' ';   
begin
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		 v_torownumber   := (p_pagenumber * p_itemnumber);
		 if v_search_keyword is not null then
			v_search_query:=' and upper(a.group_name) like ''%'||upper(v_search_keyword)||'%'' ';
		 end if;
		 
		 
		 execute  'select cnt, ''{"items":[''||string_agg(row_to_json(row)::text,'','')||'']}''
				  from (
				  select  a.*,a.update_date as updated_date,
				  row_number() over (order by a.update_date desc ) as rno,
				  count(1) over() as cnt
				  from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group a
				  where a.is_deleted=0 and a.is_active=1
				  '||v_search_query||' )row
				  where rno between  '|| v_fromrownumber||' and '||v_torownumber||'
				  group by cnt'    
				  into p_entitygroupcount,p_entitygroupjson;
     
	 
	 /*select count(1) into p_entitygroupcount from labstmp.labstmp_entity_group;
	 p_entitygroupjson := (SELECT JSON_AGG(src) FROM (SELECT * FROM labstmp.labstmp_entity_group order by   updated_date ) src)::jsonb;
     */
end;

 

$$;


--
