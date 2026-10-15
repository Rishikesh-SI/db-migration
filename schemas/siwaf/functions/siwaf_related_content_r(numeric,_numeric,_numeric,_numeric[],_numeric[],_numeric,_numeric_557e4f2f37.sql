-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_related_content_r(numeric, numeric, numeric, numeric[], numeric[], numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: siwaf_related_content_r(numeric, numeric, numeric, numeric[], numeric[], numeric, numeric, character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf.siwaf_related_content_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_id numeric, p_asset_type_id numeric, p_schema_prefix character varying, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_entityrole_mapid numeric[] := p_entityrole_mapid;
	v_entity_count numeric;
	v_any_entity_count numeric;
	v_language_erm_id numeric;
	v_language_em_id numeric;
	v_random_erm_id numeric;
	v_random_query text := ' ';
	v_entity_role_map_id_str text;
	v_search_keyword text := '';
	v_entity_search_query text := ' ';
	v_any_entity_role_map_id_query text := ' ';
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_arr_asset_list_id numeric[];
	v_asset_count numeric;
	v_asset_list_id_str text;
	v_sysdate timestamp:= current_timestamp at time zone 'utc';
	v_asset_qur text := ' ';
begin
	
	-- set enable_seqscan = off;
     
	 
	/*if p_pagenumber is not null and p_itemnumber is not null then
		if p_page1_size is null then
			v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
			v_torownumber := (p_pagenumber * p_itemnumber);
		else
			if p_pagenumber = 1 then
				v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          	else
          		v_fromrownumber := p_page1_size + ((((p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
          	end if;
   			v_torownumber := p_page1_size + ((p_pagenumber-1) * p_itemnumber);
		end if;
	end if; */
	
	if  p_asset_type_id = 4 then
		
		v_asset_qur = ' and sl.asset_type_id in (4) ';
		
	elseif	 p_asset_type_id = 1 then
		
		v_asset_qur = ' and sl.asset_type_id in (1,5) ';
		
	else	
		
		v_asset_qur = ' and sl.asset_type_id in (1,2,4)';
		
	end if;
	
	

	
	execute 'select  ''[''||string_agg(web_listing_json::text,'','')||'']'' 
	            from (select web_listing_json
    			from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list sl
    			where  sl.is_active=1
    			and    sl.is_deleted=0
    			and    sl.is_published=1 
				and    sl.asset_id <>  ' || p_asset_id 
				||  v_asset_qur || '   			 
				and tagged_entity && $1
    			order by sl.published_date desc
				limit '||p_itemnumber|| '
                       )tab

    '
    into   p_assetjson
    using  p_entityrole_mapid::numeric[] ;
   
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';
  */  
  
  p_assetcount := 3;
end;
$_$;


--
