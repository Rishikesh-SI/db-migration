-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric, character varying, numeric[])
-- Type: FUNCTION

-- Name: lablsg_v1_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric, character varying, numeric[]); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_asset_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric, p_searchkeyword character varying, p_exclude_ent_id numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	/*
	1,--p_pagenumber numeric,
	40,--p_itemnumber numeric,
	20,--p_page1_size numeric,
	array[2,4],--p_entityrole_mapid numeric[],
	array[2,4],--p_any_entityrole_mapid numeric[],
	null,--p_asset_type_id numeric[],
	null,--p_searchkeyword character varying,
	null--p_exclude_ent_id numeric[]
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
    v_sysdate timestamp;
    v_ent_count numeric;
	v_ent_count1 numeric;
    v_language_id numeric;
    v_language_mast_id numeric;
    v_asset_type_filter text;
    v_anyentityrolemapidquery varchar(4000) := ' ';
	v_excentityrolemapidquery varchar(4000):=' ';
	v_mustentityrolemapidquery varchar(4000) := ' ';
    v_any_ent_count numeric;
    v_entityrole_mapid numeric[];
    v_arr_asset_list_id numeric[];
    v_str_arr_asset_list_id varchar(1000000);
    v_asset_type_id numeric:= p_asset_type_id;
    v_str_entityrole_mapid varchar(1000000);
    v_allentityjson jsonb ; 
	v_season_json jsonb;
	v_cat_json jsonb;
	v_str text;
	v_ent_name text;
	v_role_id numeric;
	v_exc_ent_count numeric;
	v_pagination jsonb;
	v_total_pages numeric;

	-- Robust pagination vars
	v_page numeric := greatest(coalesce(p_pagenumber, 1), 1);
	v_page1_size_eff numeric := coalesce(p_page1_size, coalesce(p_itemnumber, 20));
	v_itemnumber_eff numeric := coalesce(p_itemnumber, v_page1_size_eff);
	v_limit smallint := case when v_page = 1 then v_page1_size_eff else v_itemnumber_eff end;
	v_offset integer := case when v_page = 1 then 0 else v_page1_size_eff + (v_page - 2) * v_itemnumber_eff end;
begin

	select array_length(p_any_entityrole_mapid,1) into v_any_ent_count;
	select array_length(p_exclude_ent_id,1) into v_exc_ent_count;
	select array_length(p_entityrole_mapid,1) into v_ent_count;

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

	-- Optional must-have entity filter (only when provided)
	if v_ent_count > 0 then
		v_mustentityrolemapidquery := ' and tagged_entity @> $2';
	end if;
	
	if  v_asset_type_id is not null then 
		v_asset_type_filter := ' = $7';
	else
		v_asset_type_filter := ' in (1,2,4,5,29,142) ';    
    end if;

if v_asset_type_id::numeric = 142 then 

    execute 'select ''{"items":[''||string_agg(web_listing_json::text,'','')||'']}'' 
			from (select 
					asset_list_id,web_listing_json
    from   lablsg_v1.lablsg_v1_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
	and web_listing_json is not null
    and    sl.asset_type_id '||v_asset_type_filter||'
     '||v_excentityrolemapidquery||' 
     '||v_anyentityrolemapidquery||'
     '||v_entitysearchquery||'
     '||v_mustentityrolemapidquery||'
	order by sl.updated_date desc
	limit $5
	offset $6
    )tab 
	
    '
    into   p_assetjson
    using  p_asset_type_id,p_entityrole_mapid::int[] ,	p_exclude_ent_id::int[] ,p_any_entityrole_mapid::int[], v_limit,v_offset, v_asset_type_id::numeric;

else 

execute '
    select jsonb_build_object(
        ''items'', coalesce(json_agg(row_to_json(tab)), null)
    )
    from (
        select 
            asset_id, 
            asset_type_id, 
            asset_title, 
            title_alias, 
            created_date
        from lablsg_v1.lablsg_v1_asset_list sl
        where sl.is_active = 1
          and sl.is_deleted = 0
          and sl.is_published = 1
          and sl.published_date <= ''' || v_sysdate || '''
          and web_listing_json is not null
          and sl.asset_type_id '||v_asset_type_filter||'
          ' || v_excentityrolemapidquery || '
          ' || v_anyentityrolemapidquery || '
          ' || v_entitysearchquery || '
          ' || v_mustentityrolemapidquery || '
        order by sl.updated_date desc
        limit $5
        offset $6
    ) tab
'
into p_assetjson
using  p_asset_type_id, p_entityrole_mapid::int[], p_exclude_ent_id::int[], p_any_entityrole_mapid::int[], v_limit, v_offset, v_asset_type_id;

end if;

 
execute 'select count(1)
    from   lablsg_v1.lablsg_v1_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
	and web_listing_json is not null
    and    sl.asset_type_id '||v_asset_type_filter||'
     '||v_excentityrolemapidquery||' '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery||  ' '
     ||v_mustentityrolemapidquery||  '
	'
	into p_assetcount
	using   p_asset_type_id,p_entityrole_mapid::int[] ,	p_exclude_ent_id::int[] ,p_any_entityrole_mapid::int[], v_limit,v_offset,v_asset_type_id;
   
if p_assetjson is null then 
	p_assetjson:='{"items":null}';
end if;

-- Compute total_pages using page1_size and item_number logic
if p_assetcount is null then p_assetcount := 0; end if;

if p_assetcount = 0 then
	v_total_pages := 0;
else
	if p_assetcount <= v_page1_size_eff then
		v_total_pages := 1;
	else
		v_total_pages := 1 + ceil( (p_assetcount - v_page1_size_eff)::numeric / nullif(v_itemnumber_eff,0) );
	end if;
end if;

-- Keep only these pagination nodes
v_pagination := jsonb_build_object(
    'page',        coalesce(p_pagenumber, 1),
    'page_size',   coalesce(v_limit, 20),
    'total',       coalesce(p_assetcount, 0),
    'total_pages', v_total_pages
);

p_assetjson:=	jsonb_set(p_assetjson,'{pagination}',v_pagination,true);
 
exception
	when others then
     	p_assetcount := -1;
        p_assetjson := '{"items":[{"error":"no record"}]}';
end;
$_$;


--
