-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_get_asset_listing_r(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_get_asset_listing_r(jsonb); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_get_asset_listing_r(p_user_json jsonb, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
    v_createdbyquery varchar(50) := ' ';
    v_searchkeyword varchar(4000);
    v_searchdraftquery varchar(200) := ' ';
    v_searchassetquery varchar(200) := ' ';
	v_entitysearchquery varchar(4000) := ' ';
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
    v_asset_type_id character varying;
    v_sysdate timestamp;
    v_ent_count numeric;
	v_ent_count1 numeric;
    v_language_id numeric;
    v_language_mast_id numeric;
	v_anyentityrolemapidquery varchar(4000) := ' ';
	v_excentityrolemapidquery varchar(4000):=' ';
    v_any_ent_count numeric;
    v_entityrole_mapid character varying;
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
	v_limit smallint; 
	v_offset smallint;
	v_pagenumber numeric;
	v_itemnumber numeric;
	v_page1_size numeric;
	v_exclude_ent_id character varying;
	v_any_entityrole_mapid character varying;
	v_entityrole_mapid_array  numeric[];
	v_any_entityrole_mapid_array  numeric[];
	v_asset_type_id_array  numeric[];
	v_exclude_ent_id_array  numeric[];
	v_asset_id character varying;
	v_entityrole_mapid_1 numeric;
	v_is_detail numeric;
	v_user_guid character varying;
	v_tagged_entity numeric[];
	i numeric;
	v_web_listing_json jsonb;
	v_web_listing_json_arry jsonb;
	begin
	
	select p_user_json->>'pgnum',
		   p_user_json->>'inum',
		   p_user_json->>'pgsize',
		   p_user_json->>'entities',
		   p_user_json->>'otherent',
		   p_user_json->>'asset_type_id',
		   p_user_json->>'asset_id',
		   p_user_json->>'search',
		   p_user_json->>'exclent',
		   p_user_json->>'is_detail',
		   p_user_json->>'user_guid'
		   into v_pagenumber,
				v_itemnumber,
				v_page1_size,
				v_entityrole_mapid,
				v_any_entityrole_mapid,
				v_asset_type_id,
				v_asset_id,
				v_searchkeyword,
				v_exclude_ent_id,
				v_is_detail,
				v_user_guid;
				
	v_entityrole_mapid_array := string_to_array(v_entityrole_mapid,',')::numeric[];
	v_any_entityrole_mapid_array := string_to_array(v_any_entityrole_mapid,',')::numeric[];
	v_asset_type_id_array := string_to_array(v_asset_type_id,',')::numeric[];
	v_exclude_ent_id_array := string_to_array(v_exclude_ent_id,',')::numeric[];	
	

	if v_asset_id is not null and v_asset_type_id = '4' then 
	
		select web_listing_json into v_web_listing_json from labkc_v1.labkc_v1_asset_list where asset_type_id = '4' and asset_id = v_asset_id::numeric;
		
	end if;
	
	if v_asset_type_id != '' then
		
			 select entity_role_map_id
			 into v_entityrole_mapid_1
			 from labkc_v1.labkc_v1_entity_role_map
			 where entity_role_id = (select entity_role_id
			 from labkc_v1.labkc_v1_asset_type
			 where asset_type_id = v_asset_type_id::numeric)
			 and source_object_id = v_asset_id;
			 
		if  v_entityrole_mapid_1 is not null then
			 
		v_entityrole_mapid_array := array_append (v_entityrole_mapid_array, v_entityrole_mapid_1);	 
			
		end if;
		end if;
	
if ((v_asset_id is null or v_asset_id = '') and (v_asset_type_id is null or v_asset_type_id = '') )
 or v_entityrole_mapid_1 is not null or v_asset_type_id::numeric = 4  then	
 
	raise notice 'v_exclude_ent_id_array %',v_exclude_ent_id_array;
	
	 select tagged_entity from labkc_v1.labkc_v1_asset_list 
	 where asset_list_id in (select asset_list_id from labkc_v1.labkc_v1_asset_view_trac
							where user_guid=v_user_guid
							order by viewed_date desc limit 1)
	into v_tagged_entity;

	if v_any_entityrole_mapid_array is not null then
		foreach i in array v_any_entityrole_mapid_array
		loop
			v_tagged_entity := array_append(v_tagged_entity,i);
		end loop;
		
	end if;	
	
-- 		if v_entityrole_mapid_array is not null then

-- 		foreach i in array v_entityrole_mapid_array
-- 		loop
-- 			v_tagged_entity := array_append(v_tagged_entity,i);
-- 		end loop;
		
-- 	end if;	
	
	 v_tagged_entity:=uniq(sort(v_tagged_entity::int[]))::numeric[];
		raise notice 'v_tagged_entity %',v_tagged_entity;
 

--	if v_entityrole_mapid_1 is not null then

	
	v_limit:= case v_pagenumber when 1 then v_page1_size else v_itemnumber end;
	v_offset:= case v_pagenumber when 1 then 0 else (v_page1_size + (((v_pagenumber - 1) * v_itemnumber) - v_itemnumber)) end;
	
	
	select array_length(v_any_entityrole_mapid_array,1) into v_any_ent_count;
	select array_length(v_exclude_ent_id_array,1) into v_exc_ent_count;

     v_sysdate:= current_timestamp at time zone 'utc';
     

    
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
	
	raise notice 'v_is_detail %',v_is_detail;
	
    if v_is_detail='1' then
	
	execute 'select ''{"items":[''||string_agg(web_detail_jsn::text,'','')||'']}'' 
			from (select 
					asset_list_id,web_detail_jsn
    from   labkc_v1.labkc_v1_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
	and web_detail_jsn is not null
    and    sl.asset_type_id=ANY(array[2]) 
     '||v_excentityrolemapidquery||' '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery||              
                   '
	and tagged_entity::integer[] @> $2
	order by sl.published_date desc
	limit 1
    )tab 
	
    '
    into   p_assetjson
    using  v_asset_type_id_array,v_tagged_entity::int[] ,	v_exclude_ent_id_array::int[] ,v_any_entityrole_mapid_array::int[], v_limit,v_offset;
   
	
	else
    execute 'select json_agg(web_listing_json) from (select asset_list_id,web_listing_json
    from   labkc_v1.labkc_v1_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
	and web_listing_json is not null
    and    sl.asset_type_id in (1,2,4,5,29) 
     '||v_excentityrolemapidquery||' '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery||              
                   '
	and tagged_entity::integer[] @> $2
	order by sl.published_date desc
	limit $5
	offset $6
    )x
	
    '
    into   p_assetjson
    using  v_asset_type_id_array,v_entityrole_mapid_array::int[] ,	v_exclude_ent_id_array::int[] ,v_any_entityrole_mapid_array::int[], v_limit,v_offset;
 
 	if v_web_listing_json is not null then
 
		select (v_web_listing_json::jsonb || p_assetjson) into p_assetjson;
	
	end if;
	
	select '{"items":' || string_agg(p_assetjson::text,'') || '}' into p_assetjson;
	
	raise notice 'v_entityrole_mapid_array %',v_entityrole_mapid_array;
	
--     execute 'select ''{"items":[''||string_agg(web_listing_json::text,'','')||'']}'' 
-- 			from (select  '''||v_web_listing_json||''' as web_listing_json,
-- 					asset_list_id,web_listing_json
--     from   labkc_v1.labkc_v1_asset_list sl
--     where  sl.is_active=1
--     and    sl.is_deleted=0
--     and    sl.is_published=1
--     and    sl.published_date<='''||v_sysdate||'''
-- 	and web_listing_json is not null
--     and    sl.asset_type_id in (1,2,4,5,29) 
--      '||v_excentityrolemapidquery||' '
--      ||v_anyentityrolemapidquery||  ' '
--      ||v_entitysearchquery||              
--                    '
-- 	and tagged_entity::integer[] @> $2
-- 	order by sl.published_date desc
-- 	limit $5
-- 	offset $6
--     )tab 
	
--     '
--     into   p_assetjson
--     using  v_asset_type_id_array,v_entityrole_mapid_array::int[] ,	v_exclude_ent_id_array::int[] ,v_any_entityrole_mapid_array::int[], v_limit,v_offset;
   
   execute 'select count(1)
    from   labkc_v1.labkc_v1_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
	and web_listing_json is not null
    and    sl.asset_type_id in (1,2,4,5,29) 
     '||v_excentityrolemapidquery||' '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery||              
                   '
	and tagged_entity::integer[] @> $2
	'
	into p_assetcount
	using   v_asset_type_id_array,v_entityrole_mapid_array::int[] ,	v_exclude_ent_id_array::int[] ,v_any_entityrole_mapid_array::int[], v_limit,v_offset;
   
		 
 if p_assetjson is null then 
 p_assetjson:='{"items":null}';
 
 end if;
 
 v_pagination:='{"total":'||p_assetcount||',
 				 "current_page":'||coalesce(v_pagenumber,0)||'	
				 }';

 -- p_assetjson:=	jsonb_set(p_assetjson,'{pagination}',v_pagination,true);
   
   
   end if;
--	end if;
end if; --
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';
		  */
 
end;
$_$;


--
