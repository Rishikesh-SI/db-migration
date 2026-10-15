-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_asset_listing_by_cat_r_testbkp(jsonb, numeric)
-- Type: FUNCTION

-- Name: labwis_get_asset_listing_by_cat_r_testbkp(jsonb, numeric); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_asset_listing_by_cat_r_testbkp(p_in_json jsonb, p_item_number numeric, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
declare
	 v_createdbyquery varchar(50) := ' ';

    v_searchkeyword varchar(4000);
    v_entitysearchquery varchar(4000) := ' ';
    v_playerentitysearchquery varchar(4000) := ' ';
	v_seriesentitysearchquery varchar(4000) := ' ';
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
	 v_entity_id text;
     v_page_number numeric;
	 v_ent_array int[];
	 v_cat_json jsonb;
	 v_is_all numeric;
	 v_tot_cnt numeric;
	 v_pagination jsonb;
	 v_limit smallint ;
	v_offset smallint ;
begin
    v_sysdate:= current_timestamp at time zone 'utc';
   
/*
{
    "search_text": "sachin",
    "entity_id": 4,
    "page_number": 1
  }
  */
  select p_in_json->>'search_text',
  		 p_in_json->>'entity_id',
		 p_in_json->>'page_number',
		 p_in_json->>'is_all'
into v_search_text,
	 v_entity_id,
     v_page_number,
	 v_is_all;
	 
	 v_offset := ((v_page_number - 1) * p_item_number);
     v_limit := p_item_number;
	-- raise notice '% % %',v_limit,v_offset,v_page_number;
--select 1/0;

if v_entity_id = '1' then 
	v_asset_type_id = 1;
elsif v_entity_id = '3' then
	v_asset_type_id=4;
elsif v_entity_id = '2' then
	v_asset_type_id = 2;
end if;

	 select string_to_array(v_entity_id,'~^~') into v_ent_array;
	 
	 select 	array_append(v_ent_array, 4) into v_ent_array;
	 
    if v_search_text is not null then
    			-- v_searchkeyword := replace(v_searchkeyword,'''','''''');
				select regexp_replace(v_search_text, '[^\w]+',' ') into v_searchkeyword;
				raise notice 'v_searchkeyword12345 %',v_searchkeyword;

          --v_searchkeyword:=  regexp_replace(v_search_text, '([''!$()*+.:<=>?[\\\]^{|}-])', '\\\1', 'g');        

raise notice 'v_searchkeyword %',v_searchkeyword;
        		 v_searchkeyword:=replace(v_searchkeyword,'''','''''');

                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||''')
											or    (full_text_vec @@@ to_tsquery( '''||v_searchkeyword||''') and sl.asset_type_id=1)
										)';

										-- or    (to_tsvector( sl.web_detail_jsn->''data''->>''full_text'') @@@ to_tsquery( '''||v_searchkeyword||''') and sl.asset_type_id=1
										-- )
										
				v_playerentitysearchquery:= 'and ( to_tsvector(entity_name) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                         
										)';
				v_seriesentitysearchquery:= 'and ( to_tsvector(entity_name) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                         										)';
				
     end if;
raise notice 'ent % ',v_entitysearchquery;
raise notice 'v_playerentitysearchquery %',v_playerentitysearchquery;
--select 1/0;
if v_is_all=0 then 

if  v_entity_id::int = 6 then

				execute '
				select (''{"items":''||jsonb_agg(row)::text||''}'')::jsonb,total_cnt  from (
				select jsonb_agg(tab1) as asset_data,
				count(1) as  cnt_cat,
				tab1.cnt as total_cnt from 
				(select tab.*,count(tab.*) over() as cnt from (select
				a.entity_master_id as asset_id, 
				34::numeric as asset_type_id,
				entity_name as asset_title,
				canonical_url::character varying as title_alias,
				1 as author_id,
				null as short_desc,
				6::numeric as primary_entity_role_map_id,
				6::numeric as secondary_entity_role_map_id,
				0 as total_assets,
				a.player_image_path as image_file_name,
				a.player_image_path as image_path,
				b.source_object_id,
				null as duration,
				(current_timestamp)::timestamp as updated_date,
				(current_timestamp)::timestamp as published_date,
				null as asset_guid,
				0::numeric as show_copyright,
				0::numeric as order_number,
				null as display_name,
				null as user_name,
				null as full_name,
				''Series'' primary_entity_name,
				''Series'' secondary_entity_name
				 from labwis.labwis_entity_master a
				  join labwis.labwis_entity_role_map b on a.entity_master_id=b.entity_master_id
				  where entity_role_id in (6) and a.is_active = 1 and a.is_deleted=0
				 ' ||v_playerentitysearchquery||'
				limit '|| v_limit||' offset '|| v_offset||')tab
				)tab1
group by tab1.cnt
) row  group by total_cnt'
into v_json,v_tot_cnt;

elsif  v_entity_id::int = 19 then

				execute '
				select (''{"items":''||jsonb_agg(row)::text||''}'')::jsonb,total_cnt  from (
				select jsonb_agg(tab1) as asset_data,
				count(1) as  cnt_cat,
				tab1.cnt as total_cnt from 
				(select tab.*,count(tab.*) over() as cnt from (select
				a.entity_master_id as asset_id, 
				19::numeric as asset_type_id,
				entity_name as asset_title,
				canonical_url::character varying as title_alias,
				1 as author_id,
				null as short_desc,
				19::numeric as primary_entity_role_map_id,
				19::numeric as secondary_entity_role_map_id,
				0 as total_assets,
				null as image_file_name,
				a.player_image_path as image_path,
				b.source_object_id,
				null as duration,
				(current_timestamp)::timestamp as updated_date,
				(current_timestamp)::timestamp as published_date,
				null as asset_guid,
				0::numeric as show_copyright,
				0::numeric as order_number,
				null as display_name,
				null as user_name,
				null as full_name,
				''Players'' primary_entity_name,
				''Players'' secondary_entity_name
				 from labwis.labwis_entity_master a
				  join labwis.labwis_entity_role_map b on a.entity_master_id=b.entity_master_id
				  where entity_role_id in (102) and a.is_active = 1 and a.is_deleted=0
				 ' ||v_playerentitysearchquery||'
				limit '|| v_limit||' offset '|| v_offset||')tab
				)tab1
group by tab1.cnt
) row  group by total_cnt'
into v_json,v_tot_cnt;

elsif  v_entity_id::int = 18 then

				execute '
				select (''{"items":''||jsonb_agg(row)::text||''}'')::jsonb,total_cnt  from (
				select jsonb_agg(tab1) as asset_data,
				count(1) as  cnt_cat,
				tab1.cnt as total_cnt from 
				(select tab.*,count(tab.*) over() as cnt from (select
				a.entity_master_id as asset_id, 
				18::numeric as asset_type_id,
				entity_name as asset_title,
				canonical_url::character varying as title_alias,
				1 as author_id,
				null as short_desc,
				18::numeric as primary_entity_role_map_id,
				18::numeric as secondary_entity_role_map_id,
				0 as total_assets,
				a.player_image_path as image_file_name,
				a.player_image_path as image_path,
				b.source_object_id,
				null as duration,
				(current_timestamp)::timestamp as updated_date,
				(current_timestamp)::timestamp as published_date,
				null as asset_guid,
				0::numeric as show_copyright,
				0::numeric as order_number,
				null as display_name,
				null as user_name,
				null as full_name,
				''Teams'' primary_entity_name,
				''Teams'' secondary_entity_name
				 from labwis.labwis_entity_master a
				  join labwis.labwis_entity_role_map b on a.entity_master_id=b.entity_master_id
				  where entity_role_id in (3) and a.is_active = 1 and a.is_deleted=0
				 ' ||v_playerentitysearchquery||'
				limit '|| v_limit||' offset '|| v_offset||')tab
				)tab1
group by tab1.cnt
) row  group by total_cnt'
into v_json,v_tot_cnt;

else
execute '
select (''{"items":''||jsonb_agg(row)::text||''}'')::jsonb,total_cnt  from (
select 
secondary_entity_name as name,json_agg(tab order by published_date desc) as asset_data,
count(1) as  cnt_cat,
cnt as total_cnt   from (
select  
count(1) over() as cnt,
asset_id, 
asset_type_id, 
asset_title, 
title_alias, 
author_id,
short_desc,
primary_entity_role_map_id,
secondary_entity_role_map_id,
total_assets,
image_file_name, 
image_path, 
duration, sl.updated_date,
published_date, asset_guid, 
show_copyright, order_number ,
labwis.labwis_get_user_display_name(sl.author_id) display_name,
(select user_name from labwis.labwis_user where user_id=sl.author_id) as user_name,
(select full_name from labwis.labwis_user where user_id=sl.author_id) as full_name,
(SELECT p_entity_name from labwis.labwis_get_entity_name_by_lang(language_id,secondary_entity_role_map_id)) as secondary_entity_name,
(SELECT p_entity_name from labwis.labwis_get_entity_name_by_lang(language_id,primary_entity_role_map_id)) as primary_entity_name
from labwis.labwis_asset_list sl
where  sl.is_active=1
and    sl.is_deleted=0
and    sl.is_published=1
and    sl.published_date<='''||v_sysdate||'''
and    sl.tagged_entity @> $1
and    sl.asset_type_id = '||v_asset_type_id||'
'||v_entitysearchquery||'	
order by sl.published_date desc
limit '|| v_limit||' offset '|| v_offset||'
)tab
group by secondary_entity_name,cnt
) row group by total_cnt' into v_json,v_tot_cnt
using v_ent_array;

end if;

else
--select 1/0;
raise notice '1';
raise notice 'v_ent_array %',v_ent_array;

execute 'select (''{"items":''||jsonb_agg(row)::text||''}'')::jsonb ,total_cnt from (
					select 
				''All'' as name,json_agg(tab) as asset_data,
				count(1) as  cnt_cat,
				count(cnt) as total_cnt from (
				select * from (
				select
				ROW_NUMBER() over(partition by asset_type_id order by published_date desc) as num,
				count(1) over() as cnt,
				asset_id, 
				asset_type_id, 
				asset_title, 
				title_alias, 
				author_id,
				short_desc,
				primary_entity_role_map_id,
				secondary_entity_role_map_id,
				total_assets,
				image_file_name, 
				image_path, 
				null as source_object_id,
				duration, sl.updated_date,
				published_date, asset_guid, 
				show_copyright, order_number ,
				-- rank()over (  order by sl.published_date desc) as rno,
				labwis.labwis_get_user_display_name(sl.author_id) display_name,
				(select user_name from labwis.labwis_user where user_id=sl.author_id) as user_name,
				(select full_name from labwis.labwis_user where user_id=sl.author_id) as full_name,
				(SELECT p_entity_name from labwis.labwis_get_entity_name_by_lang(language_id,secondary_entity_role_map_id)) as secondary_entity_name,
				(SELECT p_entity_name from labwis.labwis_get_entity_name_by_lang(language_id,primary_entity_role_map_id)) as primary_entity_name
				from labwis.labwis_asset_list sl
				where  sl.is_active=1
				and    sl.is_deleted=0
				and    sl.is_published=1

				and    sl.tagged_entity @> $1
				and    sl.asset_type_id in (1,2,4,5,14,29,19,34)
				'||v_entitysearchquery||'
				order by sl.published_date desc)tab1
				where num<=3
				UNION all
				select * from(
				select 
				null::bigint,
				count(1) over() as cnt,
				a.entity_master_id as asset_id, 
				19::numeric as asset_type_id,
				entity_name as asset_title,
				canonical_url::character varying(4000) as title_alias,
				1,
				null as short_desc,
				102::numeric,
				102::numeric,
				0 as total_assets,
				null,
				a.player_image_path as image_path,
				b.source_object_id,
				null as duration,
				(current_timestamp)::timestamp as updated_date,
				(current_timestamp)::timestamp as published_date,
				null as asset_guid,
				0::numeric as show_copyright,
				0::numeric as order_number,
				null as display_name,
				null as user_name,
				null as full_name,
				''Players'' primary_entity_name,
				''Players'' secondary_entity_name
				 from labwis.labwis_entity_master a
				  join labwis.labwis_entity_role_map b on a.entity_master_id=b.entity_master_id
				  where entity_role_id in (102) and a.is_active = 1 and a.is_deleted=0
				 ' ||v_playerentitysearchquery||'
				limit '|| v_limit||' offset '|| v_offset||') tab2
				UNION all
				select * from(
				select 
				null::bigint,
				count(1) over() as cnt,
				a.entity_master_id as asset_id, 
				34::numeric as asset_type_id,
				entity_name as asset_title,
				canonical_url::character varying(4000) as title_alias,
				1,
				null as short_desc,
				6::numeric,
				6::numeric,
				0 as total_assets,
				null as image_file_name,
				null as image_path,
				b.source_object_id,
				null as duration,
				(current_timestamp)::timestamp as updated_date,
				(current_timestamp)::timestamp as published_date,
				null as asset_guid,
				0::numeric as show_copyright,
				0::numeric as order_number,
				null as display_name,
				null as user_name,
				null as full_name,
				''Series'' primary_entity_name,
				''Series'' secondary_entity_name
				 from labwis.labwis_entity_master a
				  join labwis.labwis_entity_role_map b on a.entity_master_id=b.entity_master_id
				  where entity_role_id in (6) and a.is_active = 1 and a.is_deleted=0
				 ' ||v_seriesentitysearchquery||'
				limit '|| v_limit||' offset '|| v_offset||') tab2
				UNION all
				select * from(
				select 
				null::bigint,
				count(1) over() as cnt,
				a.entity_master_id as asset_id, 
				18::numeric as asset_type_id,
				entity_name as asset_title,
				canonical_url::character varying(4000) as title_alias,
				1,
				null as short_desc,
				3::numeric,
				3::numeric,
				0 as total_assets,
				null as image_file_name,
				null as image_path,
				b.source_object_id,
				null as duration,
				(current_timestamp)::timestamp as updated_date,
				(current_timestamp)::timestamp as published_date,
				null as asset_guid,
				0::numeric as show_copyright,
				0::numeric as order_number,
				null as display_name,
				null as user_name,
				null as full_name,
				''Teams'' primary_entity_name,
				''Teams'' secondary_entity_name
				 from labwis.labwis_entity_master a
				  join labwis.labwis_entity_role_map b on a.entity_master_id=b.entity_master_id
				  where entity_role_id in (3) and a.is_active = 1 and a.is_deleted=0
				 ' ||v_seriesentitysearchquery||'
				limit '|| v_limit||' offset '|| v_offset||') tab3
				
)tab

--group by tab.cnt
) row group by total_cnt
'
into v_json,v_tot_cnt
using v_ent_array;

end if;

execute 'select jsonb_agg(row) from (with tab(cnt, entid) as
(
select count(1) cnt, sl.secondary_entity_role_map_id as entid
from   labwis.labwis_asset_list sl
where    sl.secondary_entity_role_map_id in (select entity_role_map_id
                                   from   labwis.labwis_entity_role_map
                                   where  entity_role_id in(select entity_role_id
                                                            from labwis.labwis_entity_category
                                                            where category_name = ''Category Type'')
                                   and    is_active = 1
                                   and    priority > 0)
and  sl.is_active = 1
and    sl.is_deleted = 0
and    sl.is_published = 1
and    sl.published_date <= '''||v_sysdate||'''
and    sl.asset_type_id in (1,2,4,5,6,29) 
and    sl.tagged_entity @> ''{4}''
'||v_entitysearchquery
||'
group by sl.secondary_entity_role_map_id
	)select t.cnt, t.entid, coalesce(em.entity_display_name, em.entity_display_name)entity_name, 
em.entity_display_name entity_eng_name
from tab t
join labwis.labwis_entity_role_map erm
on erm.entity_role_map_id = t.entid
join labwis.labwis_entity_master em
on em.entity_master_id = erm.entity_master_id
union all 
select count(1) cnt , entity_role_id  entid,''Players'' as  entity_name ,''Players''  entity_eng_name
from labwis.labwis_entity_master a
join labwis.labwis_entity_role_map b on a.entity_master_id=b.entity_master_id
  where entity_role_id in (102) and a.is_active = 1 and a.is_deleted=0'
||v_playerentitysearchquery||'group by entity_role_id
union all 
select count(1) cnt , entity_role_id  entid,''Series'' as  entity_name ,''Series''  entity_eng_name
from labwis.labwis_entity_master a
join labwis.labwis_entity_role_map b on a.entity_master_id=b.entity_master_id
  where entity_role_id in (6) and a.is_active = 1 and a.is_deleted=0'
||v_seriesentitysearchquery||'group by entity_role_id	
union all 
select count(1) cnt , entity_role_id  entid,''Teams'' as  entity_name ,''Teams''  entity_eng_name
from labwis.labwis_entity_master a
join labwis.labwis_entity_role_map b on a.entity_master_id=b.entity_master_id
  where entity_role_id in (3) and a.is_active = 1 and a.is_deleted=0'
||v_seriesentitysearchquery||'group by entity_role_id	
			   )  row'
	into v_cat_json;
--raise notice '%',v_cat_json;
	--select 1/0;
v_json:=jsonb_set(v_json::jsonb,'{cat_data}',coalesce(v_cat_json::jsonb,'[]'), true);

v_pagination:='{"total":'||v_tot_cnt||',
 				 "current_page":'||coalesce(v_page_number,0)||'	
				 }';

 v_json:=	jsonb_set(v_json::jsonb,'{pagination}',v_pagination,true);		 
 	
p_out_json:=v_json;

end;
$_$;


--
