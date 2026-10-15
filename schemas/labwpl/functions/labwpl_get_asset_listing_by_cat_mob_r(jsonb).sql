-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_get_asset_listing_by_cat_mob_r(jsonb)
-- Type: FUNCTION

-- Name: labwpl_get_asset_listing_by_cat_mob_r(jsonb); Type: FUNCTION; Schema: labwpl; Owner: -
--

CREATE FUNCTION labwpl.labwpl_get_asset_listing_by_cat_mob_r(p_in_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
declare
	 v_createdbyquery varchar(50) := ' ';

    v_searchkeyword varchar(4000);
    v_entitysearchquery varchar(4000) := ' ';
    v_playerentitysearchquery varchar(4000) := ' ';
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
    -- v_asset_type_id numeric:=2;
    v_sysdate timestamp;
    v_ent_count numeric;
    v_assettypeidcount numeric;
    v_assettypequery varchar(4000) := ' ';
    v_entityrolemapidquery varchar(4000) := ' ';
    v_qry_str varchar(100000);
	v_language_id numeric;
	v_lang_master_id numeric;
    v_cat_name varchar(20) := 'Category Type';
    p_lang_array numeric[];
    v_entityrolemapidquery1 text:= ' ';
    v_cat_array numeric[];
	
	v_search_text text;
	 v_entity_id varchar;
     v_page_number numeric;
	 v_ent_array int[];
	 v_cat_json jsonb;
	 v_is_all numeric;
	 v_tot_cnt numeric;
	 v_pagination jsonb;
	 v_limit smallint ;
	v_offset smallint ;
	v_asset_type_id varchar;
	v_asset_array numeric[];
	
	  v_player_entity_role_id numeric;
		  v_event_entity_role_id numeric;
		  v_entity_role_id numeric;
	v_entity_role_id_array numeric[];
	i numeric;
	a numeric;
begin
    v_sysdate:= current_timestamp at time zone 'utc';
   
/*
{
    "search_text": "sachin",
    "entity_id": 4,
    "page_number": 1,
	"item_number" : 1
	
  }
  */
  
  select p_in_json->>'search_text',
  		 p_in_json->>'entity_id',
		 p_in_json->>'page_number',
		 p_in_json->>'is_all',
		 p_in_json->>'item_number',
		 p_in_json->>'asset_type_id'
		 
into v_search_text,
	 v_entity_id,
     v_page_number,
	 v_is_all,
	 v_limit,
	 v_asset_type_id
	 ;
	 
	 if v_page_number is null then 
	 v_page_number:=1 ;
	 end if;
	 
	 v_offset := ((v_page_number - 1) * v_limit);
	 
     -- v_limit := p_item_number;
	 -- raise notice '% % %',v_limit,v_offset,v_page_number;
--select 1/0;
     
	 
    
	 select string_to_array(v_entity_id,',') into v_ent_array;
	 
	-- raise notice '%',v_ent_array;
	 if v_ent_array is null then
	  v_ent_array :=  array[4];
	 end if;

	if v_search_text = '' then
		v_search_text := null;
	end if;	

	raise notice 'v_search_text %',v_search_text;
	 
    if v_search_text is not null then
    			-- v_searchkeyword := replace(v_searchkeyword,'''','''''');

          v_searchkeyword:=  regexp_replace(v_search_text, '([''!$()*+.:<=>?[\\\]^{|}-])', '\\\1', 'g');        

        		 v_searchkeyword:=replace(v_searchkeyword,'''','''''');

                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
										
                v_playerentitysearchquery:='and ( to_tsvector(entity_name) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                         or to_tsvector(city) @@@ to_tsquery( '''||v_searchkeyword||''')
										)';
				
     end if;
	 	 raise notice 'v_entitysearchquery %',v_entitysearchquery;

	 raise notice 'v_playerentitysearchquery %',v_playerentitysearchquery;
	-- raise notice '%',v_offset;
-- raise notice 'ent %  serch name%',v_ent_array,v_entitysearchquery;
--select 1/0;

if v_is_all = 0 then 
execute '
select (''{"items":''||jsonb_agg(row)::text||''}'')::jsonb,total_cnt  from (
select 
secondary_entity_name as name,json_agg(tab order by published_date desc) as asset_data,
count(1) as  cnt_cat,
cnt as total_cnt   from (
select * from(select  
count(1) over() as cnt,
asset_id, 
asset_type_id, 
asset_title, 
title_alias, 
duration,
short_desc,
primary_entity_role_map_id,
secondary_entity_role_map_id,
image_file_name, 
image_path, 
null as source_object_id,
published_date::timestamp,
(SELECT p_entity_name from labwpl.labwpl_get_entity_name_by_lang(language_id,secondary_entity_role_map_id)) as secondary_entity_name,
(SELECT p_entity_name from labwpl.labwpl_get_entity_name_by_lang(language_id,primary_entity_role_map_id)) as primary_entity_name,
null as City,null as start_date,null as end_date,null as branding
from labwpl.labwpl_asset_list sl
where  sl.is_active=1
and    sl.is_deleted=0
and    sl.is_published=1
and    sl.published_date<='''||v_sysdate||'''
and    sl.tagged_entity @> $1
and    sl.asset_type_id in (1,2,4,5,14,29)
'||v_entitysearchquery||'	
order by sl.published_date desc
limit '|| v_limit||' offset '|| v_offset||') tab1

UNION all
select * from(select 
count(1) over() as cnt,
a.entity_master_id as asset_id, 
18::numeric as asset_type_id,
entity_name as asset_title,
canonical_url::character varying(4000) as title_alias,
null as duration,
null as short_desc,
3,
3,
null ,
a.player_image_path as image_path,
b.source_object_id,
(current_timestamp)::timestamp as published_date,
''Team'' primary_entity_name,
''Team'' secondary_entity_name,
city,
null,
null,
null
 from labwpl.labwpl_entity_master a
  join labwpl.labwpl_entity_role_map b on a.entity_master_id=b.entity_master_id
  where entity_role_id in (3)
 ' ||v_playerentitysearchquery||'
limit '|| v_limit||' offset '|| v_offset||') tab2

UNION all
select * from(select 
count(1) over() as cnt,
a.entity_master_id as asset_id, 
19::numeric as asset_type_id,
entity_name as asset_title,
canonical_url::character varying(4000) as title_alias,
null as duration,
null as short_desc,
62,
62,
null ,
a.player_image_path as image_path,
b.source_object_id,
(current_timestamp)::timestamp as published_date,
''Players'' primary_entity_name,
''Players'' secondary_entity_name,
city,
null,
null,
null
 from labwpl.labwpl_entity_master a
  join labwpl.labwpl_entity_role_map b on a.entity_master_id=b.entity_master_id
  where entity_role_id in (62)
 ' ||v_playerentitysearchquery||'
limit '|| v_limit||' offset '|| v_offset||') tab3

)tab
group by secondary_entity_name,cnt
) row group by total_cnt' into v_json,v_tot_cnt;
--using array[172]::integer[];
--using v_ent_array::integer[];

else
--raise notice 'adssa';
     if v_asset_type_id is null then

			execute 'select (''{"items":''||jsonb_agg(row)::text||''}'')::jsonb ,total_cnt from (
				select 
			''All'' as name,json_agg(tab) as asset_data,
			count(1) as  cnt_cat,
			count(cnt) as total_cnt   from (
			     select * from(select  
				count(1) over() as cnt,
				asset_id, 
				asset_type_id, 
				asset_title, 
				title_alias, 
				duration,
				short_desc,
				primary_entity_role_map_id,
				secondary_entity_role_map_id,
				image_file_name, 
				image_path, 
				null as source_object_id,
				published_date::timestamp,
				(SELECT p_entity_name from labwpl.labwpl_get_entity_name_by_lang(language_id,secondary_entity_role_map_id)) as secondary_entity_name,
				(SELECT p_entity_name from labwpl.labwpl_get_entity_name_by_lang(language_id,primary_entity_role_map_id)) as primary_entity_name,
				null as City,null as start_date,null as end_date,null as branding
				from labwpl.labwpl_asset_list sl
				where  sl.is_active=1
				and    sl.is_deleted=0
				and    sl.is_published=1
				and    sl.published_date<='''||v_sysdate||'''
				--and    sl.tagged_entity @> $1
				and    sl.asset_type_id in (1,2,4,5,14,29)
				'||v_entitysearchquery||'	
				order by sl.published_date desc
				limit '|| v_limit||' offset '|| v_offset||') tab1

				UNION all
				select * from(select 
				count(1) over() as cnt,
				a.entity_master_id as asset_id, 
				18::numeric as asset_type_id,
				entity_name as asset_title,
				canonical_url::character varying(4000) as title_alias,
				null as duration,
				null as short_desc,
				3,
				3,
				null ,
				a.player_image_path as image_path,
				b.source_object_id,
				(current_timestamp)::timestamp as published_date,
				''Team'' primary_entity_name,
				''Team'' secondary_entity_name,
				
				city,
				null,
				null,
				null
				 from labwpl.labwpl_entity_master a
				  join labwpl.labwpl_entity_role_map b on a.entity_master_id=b.entity_master_id
				  where entity_role_id in (3)
				 ' ||v_playerentitysearchquery||'
				limit '|| v_limit||' offset '|| v_offset||') tab2

				UNION all
				select * from(select 
				count(1) over() as cnt,
				a.entity_master_id as asset_id, 
				19::numeric as asset_type_id,
				entity_name as asset_title,
				canonical_url::character varying(4000) as title_alias,
				null as duration,
				null as short_desc,
				62,
				62,
				null ,
				a.player_image_path as image_path,
				b.source_object_id,
				(current_timestamp)::timestamp as published_date,
				''Players'' primary_entity_name,
				''Players'' secondary_entity_name,
				
				city,
				null,
				null,
				null
				 from labwpl.labwpl_entity_master a
				  join labwpl.labwpl_entity_role_map b on a.entity_master_id=b.entity_master_id
				  where entity_role_id in (62)
				 ' ||v_playerentitysearchquery||'
				limit '|| v_limit||' offset '|| v_offset||') tab3
			
			)tab

			--group by tab.cnt
			) row  group by total_cnt'
			into v_json,v_tot_cnt;
			--using array[172]::integer[];
			--using v_ent_array::integer[];
			
	else
		
		select string_to_array(v_asset_type_id,',') into v_asset_array;
		
		select count(1)
     	into   v_ent_count
     	from   unnest(v_asset_array)entity_id;
		
	  --  raise notice '% 1',v_ent_count;
		
			--select 1/0;
		
		if v_ent_count = 1 then
		
		foreach i in array(v_asset_array) loop
		
		select entity_role_id from labwpl.labwpl_asset_type
		where asset_type_id=i
		into a;
		
		v_entity_role_id_array:= array_append(v_entity_role_id_array,a);
		
		end loop;  
		
		else  
		  
		select array_agg(x) from
		  (select entity_role_id  from labwpl.labwpl_asset_type
		  where asset_type_id in (select * from unnest(v_asset_array)))x
		  into v_entity_role_id_array;
		  
		  
		end if;  
		
		  raise notice 'v_entity_role_id_array %',v_entity_role_id_array;
		
		execute 'select (''{"items":''||jsonb_agg(row)::text||''}'')::jsonb ,total_cnt from (
				select 
			''All'' as name,json_agg(tab) as asset_data,
			count(1) as  cnt_cat,
			count(cnt) as total_cnt   from (
				select * from(select 
				count(1) over() as cnt,
				a.entity_master_id as asset_id, 
				18::numeric as asset_type_id,
				entity_name as asset_title,
				canonical_url::character varying(4000) as title_alias,
				null as duration,
				null as short_desc,
				3 as primary_entity_role_map_id,
				3 as secondary_entity_role_map_id,
				null image_file_name,
				a.player_image_path as image_path,
				b.source_object_id,
				current_timestamp as published_date,
				''Team'' primary_entity_name,
				''Team'' secondary_entity_name,
				
				city,
				null as start_date,
				null as end_date,
				null as branding
				 from labwpl.labwpl_entity_master a
				  join labwpl.labwpl_entity_role_map b on a.entity_master_id=b.entity_master_id
				  where entity_role_id in (select * from unnest($3))
				 ' ||v_playerentitysearchquery||'
				limit '|| v_limit||' offset '|| v_offset||') tab2

				UNION all
				select * from(select 
				count(1) over() as cnt,
				a.entity_master_id as asset_id, 
				19::numeric as asset_type_id,
				entity_name as asset_title,
				canonical_url::character varying(4000) as title_alias,
				null as duration,
				null as short_desc,
				62,
				62,
				null ,
				a.player_image_path as image_path,
				b.source_object_id,
				current_timestamp as published_date,
				''Players'' primary_entity_name,
				''Players'' secondary_entity_name,
				
				city,
				null,
				null,
				null
				 from labwpl.labwpl_entity_master a
				  join labwpl.labwpl_entity_role_map b on a.entity_master_id=b.entity_master_id
				  where entity_role_id in (select * from unnest($3))
				 ' ||v_playerentitysearchquery||'
				limit '|| v_limit||' offset '|| v_offset||') tab3
			
			)tab

			--group by tab.cnt
			) row  group by total_cnt'
			into v_json,v_tot_cnt
			using v_event_entity_role_id,v_player_entity_role_id,v_entity_role_id_array;
	
			
	end if;		

--raise notice '%',v_limit;
--raise notice '%',v_offset;

end if;

execute 'select jsonb_agg(row) from (with tab(cnt, entid) as
(
select count(1) cnt, sl.secondary_entity_role_map_id as entid
from   labwpl.labwpl_asset_list sl
where    sl.secondary_entity_role_map_id in (select entity_role_map_id
                                   from   labwpl.labwpl_entity_role_map
                                   where  entity_role_id in(select entity_role_id
                                                            from labwpl.labwpl_entity_category
                                                            where category_name = ''Category Type'')
                                   and    is_active = 1
                                   and    priority > 0)
and  sl.is_active = 1
and    sl.is_deleted = 0
and    sl.is_published = 1
and    sl.published_date <= '''||v_sysdate||'''
and    sl.asset_type_id in (1,2,4,5,6,29) 
and    sl.tagged_entity @> $1
'||v_entitysearchquery
||'
group by sl.secondary_entity_role_map_id
	)select t.cnt, t.entid, coalesce(em.entity_display_name, em.entity_display_name)entity_name, 
em.entity_display_name entity_eng_name
from tab t
join labwpl.labwpl_entity_role_map erm
on erm.entity_role_map_id = t.entid
join labwpl.labwpl_entity_master em
on em.entity_master_id = erm.entity_master_id
union all 
select count(1) cnt , entity_role_id  entid,''Players'' as  entity_name ,''Players''  entity_eng_name
from labwpl.labwpl_entity_master a
join labwpl.labwpl_entity_role_map b on a.entity_master_id=b.entity_master_id
  where entity_role_id in (62)'
||v_playerentitysearchquery||'group by entity_role_id			
union all 
select count(1) cnt , entity_role_id  entid,''Series'' as  entity_name ,''Team''  entity_eng_name
from labwpl.labwpl_entity_master a
 join labwpl.labwpl_entity_role_map b on a.entity_master_id=b.entity_master_id
 where entity_role_id in (3)'
||v_playerentitysearchquery||'group by entity_role_id	
			   )  row'
	into v_cat_json
	--using array[172]::integer[];
	using v_ent_array::integer[];
	
 -- raise notice '%',v_cat_json;
	--select 1/0;
v_json:=jsonb_set(v_json::jsonb,'{cat_data}',coalesce(v_cat_json::jsonb,'[]'), true);
	
	select max(cnt) into v_tot_cnt from
	(select *
	from json_to_recordset(v_cat_json::json)
	as x("entid" int, "cnt" int))tab;	

v_pagination:='{"total":'||v_tot_cnt||',
 				 "current_page":'||coalesce(v_page_number,0)||'	
				 }';

 v_json:=	jsonb_set(v_json::jsonb,'{pagination}',v_pagination,true);		 
 	
p_out_json:=v_json;

end;
$_$;


--
