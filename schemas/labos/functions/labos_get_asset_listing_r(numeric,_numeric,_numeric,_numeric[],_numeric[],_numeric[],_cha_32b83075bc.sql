-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[], jsonb)
-- Type: FUNCTION

-- Name: labos_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[], jsonb); Type: FUNCTION; Schema: labos; Owner: -
--

CREATE FUNCTION labos.labos_get_asset_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_exclude_ent_id numeric[], p_exclude_data jsonb, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
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
	p_assetcount numeric;
	p_assetjson jsonb;
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
	v_json1 jsonb;
	v_asset_id numeric;
	v_asset_type_id1 numeric;
	v_data jsonb;
	v_article_array numeric[];
	v_album_array numeric[];
	v_video_array numeric[];
	v_article_qry text := ' ';
	v_album_qry text := ' ';
	v_video_qry text := ' ';
	v_exclude_data_qry text := ' ';
	
	
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
     	
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
                
     end if;
     
    if v_any_ent_count > 0 then
    	
     v_anyentityrolemapidquery := ' and tagged_entity && $4';
     
    end if;
	
	if v_exc_ent_count > 0 then 
	
	v_excentityrolemapidquery := ' and not tagged_entity && $3';
	
	end if;
	
	--raise notice '% %',v_anyentityrolemapidquery,p_entityrole_mapid;
	--select 1/0;
    
	
	if p_exclude_data is not null THEN
	
	-- select p_exclude_data->'data' into v_json1;
	
	v_json1 := p_exclude_data;
	
    for v_data in select * from jsonb_array_elements(v_json1)
    loop
	select v_data->>'asset_id',
			v_data->>'asset_type_id'
	into v_asset_id,
		 v_asset_type_id1;
		
	if v_asset_type_id1 = 1 then
	
		v_article_array := array_append(v_article_array,v_asset_id);
		
	elsif v_asset_type_id1 = 2 then
	
      v_album_array := array_append(v_album_array,v_asset_id);
	 
	elsif v_asset_type_id1 = 4 then
	
	  v_video_array := array_append(v_video_array,v_asset_id);
	
	end if;
	
end loop;

   if v_article_array is not null then
   		v_article_qry := '(asset_id not in (select * from unnest($7) as asset_id) and asset_type_id = 1)';
  		v_exclude_data_qry := 'and('|| v_article_qry ;
		
	else
	    
		v_exclude_data_qry := 'and((asset_type_id = 1)' ;
	
	end if;
	
	if v_album_array is not null then
	
	v_album_qry := '(asset_id not in (select * from unnest($8) as asset_id) and asset_type_id = 2)';
	
		if v_exclude_data_qry = ' ' then
		 v_exclude_data_qry := 'and('|| v_album_qry ;
		 else
		   v_exclude_data_qry := v_exclude_data_qry ||' or '|| v_album_qry ;
		 end if;
		 
	else
	    v_album_qry := '(asset_type_id = 2)';
		v_exclude_data_qry := v_exclude_data_qry ||' or '|| v_album_qry ;  
	
	end if;
	
	
	
	if v_video_array is not null then
	
	v_video_qry := '(asset_id not in (select * from unnest($9) as asset_id) and asset_type_id = 4)';
	
		if v_exclude_data_qry = ' ' then
		 v_exclude_data_qry := 'and('|| v_video_qry ;
		 else
           v_exclude_data_qry := v_exclude_data_qry ||' or '|| v_video_qry ;
		 
		 end if;
	else
	    v_video_qry := '(asset_type_id = 4)';
		v_exclude_data_qry := v_exclude_data_qry ||' or '|| v_video_qry ;  
	
	end if;
	
	v_exclude_data_qry := v_exclude_data_qry || ')';
	
	end if;
	
	
	
    execute 'select ''{"items":[''||string_agg(web_listing_json::text,'','')||'']}'' 
			from (select 
					asset_list_id,web_listing_json
    from   labos.labos_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
	and web_listing_json is not null
    and    sl.asset_type_id in (1,2,4,5,29) 
     '||v_excentityrolemapidquery||' '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery|| ' '
     ||v_exclude_data_qry||              
                   '
	and tagged_entity @> $2
	order by sl.published_date desc
	limit $5
	offset $6
    )tab 
	
    '
    into   p_assetjson
    using  p_asset_type_id,p_entityrole_mapid::int[] ,	p_exclude_ent_id::int[] ,p_any_entityrole_mapid::int[], v_limit,v_offset,v_article_array,v_album_array,v_video_array;
   
	 	-- raise notice 'p_entityrole_mapid %',p_entityrole_mapid;		

 
execute 'select count(1)
    from   labos.labos_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
	and web_listing_json is not null
    and    sl.asset_type_id in (1,2,4,5,29) 
     '||v_excentityrolemapidquery||' '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery||              
                   ' '
     ||v_exclude_data_qry||              
                   '
	and tagged_entity @> $2
	'
	into p_assetcount
	using   p_asset_type_id,p_entityrole_mapid::int[] ,	p_exclude_ent_id::int[] ,p_any_entityrole_mapid::int[], v_limit,v_offset,v_article_array,v_album_array,v_video_array;
   
		 
 if p_assetjson is null then 
 p_assetjson:='{"items":null}';
 --raise notice '%',p_assetcount;
 --select 1/0;
 end if;
 
 v_pagination:='{"total":'||p_assetcount||',
 				 "current_page":'||coalesce(p_pagenumber,0)||'	
				 }';

  p_assetjson:=	jsonb_set(p_assetjson,'{pagination}',v_pagination,true);
 
exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';
		  
 
end;
$_$;


--
