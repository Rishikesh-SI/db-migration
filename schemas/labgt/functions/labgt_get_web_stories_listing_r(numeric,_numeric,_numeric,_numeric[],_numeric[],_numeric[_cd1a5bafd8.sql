-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_web_stories_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[])
-- Type: FUNCTION

-- Name: labgt_get_web_stories_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[]); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_web_stories_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_exclude_ent_id numeric[], OUT p_wscount numeric, OUT p_wsjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare
	/*
	p_pagenumber numeric:=1;
	p_itemnumber numeric:=2;
	p_page1_size numeric:=2;
	p_entityrole_mapid numeric[]:=array[5,3];
	p_any_entityrole_mapid numeric[]:=null;
	p_asset_type_id numeric[]:=null;
	p_searchkeyword character varying:=null;
	p_wscount numeric;
	p_wsjson jsonb;
	*/
    v_createdbyquery varchar(50) := ' ';
    
    v_searchkeyword varchar(4000) := p_searchkeyword;
    v_entitysearchquery varchar(4000) := ' ';
     
    v_searchdraftquery varchar(200) := ' ';
    v_searchassetquery varchar(200) := ' ';
	  v_drafassetcount numeric := 0;
    v_assetdraftidarr numeric[];
    v_assetdraftid numeric;
    v_titlealias json;
    v_entityjson json;
    v_entity json;
    v_entitymasterid numeric;
    v_priority numeric;
    v_assetcount numeric := 0;
	  v_fromrownumber numeric;
    v_torownumber numeric;
    v_count numeric;
    v_assetjsonarr jsonb[];
    v_assetjson jsonb;
    v_json text := '{"items":[';
    v_asset_count numeric:=0;
    v_asset_type_id numeric:=2;
    v_sysdate timestamp;
    v_ent_count numeric;
	v_ent_count1 numeric;
    v_language_id numeric;
    v_language_mast_id numeric;
    
    v_anyentityrolemapidquery varchar(4000) := ' ';
	v_excentityrolemapidquery varchar(4000):=' ';
    v_any_ent_count numeric;
    v_entityrole_mapid numeric[];
    v_arr_asset_list_id numeric[];
    v_str_arr_asset_list_id varchar(1000000);
    
    v_str_entityrole_mapid varchar(1000000);
    v_allentityjson jsonb ; 
	v_season_json jsonb;
	v_cat_json jsonb;
	v_str text;
	v_ent_name text;
	v_role_id numeric;
	v_exc_ent_count numeric;
	v_pagination jsonb;
	v_limit smallint := case p_pagenumber when 1 then p_page1_size else p_itemnumber end;
	v_offset smallint := case p_pagenumber when 1 then 0 else (p_page1_size + (((p_pagenumber - 1) * p_itemnumber) - p_itemnumber)) end;
	
	v_author_query varchar(200) := ' ';
	v_author_id numeric;
	
begin

select array_length(p_any_entityrole_mapid,1) into v_any_ent_count;
select array_length(p_exclude_ent_id,1) into v_exc_ent_count;
/*-- new changes done by rakesh bhatkar
 add username and full_name
 date :-15112017 
-- end--
*/
--raise notice '% %',v_limit,v_offset;
--select 1/0;
     v_sysdate:= current_timestamp at time zone 'utc';
     
	/* 
     if p_page1_size is null 
     then 
              v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
              v_torownumber   := (p_pagenumber * p_itemnumber);
      else 
          if (p_pagenumber=1) then 
          v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          else 
          v_fromrownumber := p_page1_size + ( (( (p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
           end if;
   v_torownumber   := p_page1_size + ( (p_pagenumber-1) * p_itemnumber);
end if;

    */
    --v_str_entityrole_mapid:= '{'||array_to_string(p_entityrole_mapid,',')||'}';
    
    if v_searchkeyword is not null then
	
				if POSITION('author_id:' IN v_searchkeyword) > 0 THEN
				
				v_author_id:= regexp_replace(v_searchkeyword, '[^0-9]', '', 'g')::numeric;
				
				v_author_query:= 'and (sl.author_id=$7)';
				/*
				or exists(select 1 
									from labgt.labgt_author_action where asset_id=sl.asset_id
									and asset_type_id=$1 and action_id = 4 and 
									author_id=$7)
				*/
				else
     	
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
                end if;
     end if;
     
    if v_any_ent_count > 0 then
    	
     v_anyentityrolemapidquery := ' and tagged_entity && $4';
     
    end if;
	
	if v_exc_ent_count > 0 then 
	
	v_excentityrolemapidquery := ' and not tagged_entity && $3';
	
	end if;
	
	raise notice '% %',v_excentityrolemapidquery,v_any_ent_count;
	--select 1/0;
	raise notice 'p_entityrole_mapid::int[] %',p_entityrole_mapid::int[];
    raise notice 'v_limit %',v_limit;
    raise notice 'v_offset %',v_offset;
     
    execute 'select ''{"items":[''||string_agg(web_listing_json::text,'','')||'']}'' 
			from (select 
					asset_list_id, web_listing_json,focus_by_keywords
    from   labgt.labgt_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
	and web_listing_json is not null
    and    sl.asset_type_id in (142) 
     '||v_excentityrolemapidquery||' '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery|| ' '
	 ||v_author_query||
	 '
	and tagged_entity::int[] @> $2
	order by sl.updated_date desc
	limit $5
	offset $6
    )tab 
	
    '
    into   p_wsjson
    using  p_asset_type_id,p_entityrole_mapid::int[] ,	p_exclude_ent_id::int[] ,p_any_entityrole_mapid::int[], v_limit,v_offset,v_author_id;
   

execute 'select count(1)
    from   labgt.labgt_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
	and web_listing_json is not null
    and    sl.asset_type_id in (142) 
     '||v_excentityrolemapidquery||' '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery|| ' '
	 ||v_author_query||
	 '
	and tagged_entity::int[] @> $2
	'
	into p_wscount
	using   p_asset_type_id,p_entityrole_mapid::int[] ,	p_exclude_ent_id::int[] ,p_any_entityrole_mapid::int[], v_limit,v_offset,v_author_id;
   
		 
 if p_wsjson is null then 
 p_wsjson:='{"items":null}';
 --raise notice '%',p_wscount;
 --select 1/0;
 end if;
 
 v_pagination:='{"total":'||p_wscount||',
 				 "current_page":'||coalesce(p_pagenumber,0)||'	
				 }';

  p_wsjson:=	jsonb_set(p_wsjson,'{pagination}',v_pagination,true);
 
/*exception
	when others then
     	p_wscount := -1;
          p_wsjson := '{"items":[{"error":"no record"}]}';
		  */
 
end;
$_$;


--
