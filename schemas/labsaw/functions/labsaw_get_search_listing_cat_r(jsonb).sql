-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_search_listing_cat_r(jsonb)
-- Type: FUNCTION

-- Name: labsaw_get_search_listing_cat_r(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_search_listing_cat_r(p_in_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
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
	 v_length numeric;
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
		 p_in_json->>'page_number'
into v_search_text,
	 v_entity_id,
     v_page_number;
	 
	

	 select string_to_array(v_entity_id,'~^~') into v_ent_array;
	 select string_to_array(v_entity_id,'~^~') into v_ent_array;
	 
	 select 	array_append(v_ent_array, 4) into v_ent_array;
	 
	 select array_length(v_ent_array,1) into v_length;
	-- raise notice '% %',v_ent_array ,v_length;
	 --select 1/0;
	 
     v_fromrownumber := (v_page_number * 20 - (20 - 1));
  	 v_torownumber   := (v_page_number * 20);

    if v_search_text is not null then
    			-- v_searchkeyword := replace(v_searchkeyword,'''','''''');

                v_searchkeyword:=  regexp_replace(v_search_text, '([''!$()*+.:<=>?[\\\]^{|}-])', '\\\1', 'g');        

        		 v_searchkeyword:=replace(v_searchkeyword,'''','''''');

                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';

				
     end if;

raise notice 'ent %  serch name%',v_ent_array,v_entitysearchquery;
--select 1/0;
if v_length >1 then 
execute '
select (''{"data":''||string_agg(to_jsonb(row)::text,'''' )||''}'')::jsonb from (
select 
secondary_entity_name,json_agg(tab order by rno) as asset_data,
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
rank()over ( order by sl.published_date desc) as rno,
labsaw.labsaw_get_user_display_name(sl.author_id) display_name,
(select user_name from labsaw.labsaw_user where user_id=sl.author_id) as user_name,
(select full_name from labsaw.labsaw_user where user_id=sl.author_id) as full_name,
(SELECT p_entity_name from labsaw.labsaw_get_entity_name_by_lang(language_id,secondary_entity_role_map_id)) as secondary_entity_name,
(SELECT p_entity_name from labsaw.labsaw_get_entity_name_by_lang(language_id,primary_entity_role_map_id)) as primary_entity_name
from labsaw.labsaw_asset_list sl
where  sl.is_active=1
and    sl.is_deleted=0
and    sl.is_published=1
and    sl.published_date<='''||v_sysdate||'''
and    sl.tagged_entity @> $1
and    sl.asset_type_id in (1,2,4,5,14,29)
'||v_entitysearchquery||'	

)tab
where rno between '||v_fromrownumber||' and '||v_torownumber||'
group by secondary_entity_name,cnt
) row' into v_json
using v_ent_array;
else 
v_json :='{}';
end if;
execute 'select jsonb_agg(row) from (with tab(cnt, entid) as
(
select count(1) cnt, sl.secondary_entity_role_map_id as entid
from   labsaw.labsaw_asset_list sl
where    sl.secondary_entity_role_map_id in (select entity_role_map_id
                                   from   labsaw.labsaw_entity_role_map
                                   where  entity_role_id in(select entity_role_id
                                                            from labsaw.labsaw_entity_category
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
join labsaw.labsaw_entity_role_map erm
on erm.entity_role_map_id = t.entid
join labsaw.labsaw_entity_master em
on em.entity_master_id = erm.entity_master_id
			   )  row'
	into v_cat_json;
raise notice '%',v_cat_json;
	--select 1/0;
v_json:=jsonb_set(v_json::jsonb,'{cat_data}',coalesce(v_cat_json::jsonb,'[]'), true);
	
p_out_json:=v_json;

end;
$_$;


--
