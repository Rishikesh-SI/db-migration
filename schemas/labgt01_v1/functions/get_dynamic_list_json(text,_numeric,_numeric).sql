-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: _get_dynamic_list_json(text, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_dynamic_list_json(text, numeric, numeric); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1._get_dynamic_list_json(p_schema_prefix text, p_asset_type_id numeric, p_asset_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
v_name_json jsonb;
v_name character varying;
i jsonb;
v_name1 text;
p_json1 jsonb[];
p_json2 jsonb;
begin 
p_schema_prefix:='labgt01_v1';
execute '
select row_to_json(row) as web_list from (
select distinct 
asset_list_id,
asset_id,
asset_type_id, 
asset_title,
title_alias, 
author_id,
short_desc,
tags,
primary_entity_role_map_id, 
secondary_entity_role_map_id,
total_assets,
image_file_name, 
image_path,
duration, 
published_version_number,
sl.created_date, 
sl.updated_date, 
sl.created_by, 
sl.updated_by,
published_date,
(select p_canonical_url from labgt01_v1.labgt01_v1_get_canonical_url_r(sl.primary_entity_role_map_id)) as pri_ent_url,
u.display_name display_name,
u.user_name user_name,
(select p_canonical_url from labgt01_v1.labgt01_v1_get_canonical_url_r(sl.secondary_entity_role_map_id)) as sec_ent_url,
u.full_name full_name,
(SELECT p_entity_name from labgt01_v1.labgt01_v1_get_entity_name_by_lang(language_id,sl.primary_entity_role_map_id)) as primary_entity_name,
(SELECT p_entity_display_name from labgt01_v1.labgt01_v1_get_entity_name_by_lang(language_id,sl.primary_entity_role_map_id)) as pri_ent_disp_name,
(SELECT p_entity_name from labgt01_v1.labgt01_v1_get_entity_name_by_lang(language_id,sl.secondary_entity_role_map_id)) as secondary_entity_name,
(SELECT p_entity_display_name from labgt01_v1.labgt01_v1_get_entity_name_by_lang(language_id,sl.secondary_entity_role_map_id)) as sec_ent_disp_name
from labgt01_v1.labgt01_v1_asset_list sl
left join labgt01_v1.labgt01_v1_user u
on u.user_id = author_id
where sl.asset_type_id=$1 
 and sl.is_published=1
 and sl.is_trashed=0
 and sl.is_active=1
 and sl.is_deleted=0
 and sl.asset_id=$2
	)row
'
into p_json
using p_asset_type_id,p_asset_id
;

select json_agg(x) from
(select field_name
 from labgt01_v1.labgt01_v1_content_type_fields 
 where content_type_id=p_asset_type_id 
 and show_in_listing_json = 'true'
)x
into v_name_json;

raise notice 'v_name_json %',v_name_json;

 for i in (select * from jsonb_array_elements(v_name_json))
 loop
 	select i->>'field_name'
	 into  v_name ;
	 
	 
	 if exists(select i->>'field_name' in (SELECT jsonb_object_keys(web_detail_jsn->'data'->'dynamic_form_data')
 						   FROM labgt01_v1.labgt01_v1_asset_list
 						   where asset_id=p_asset_id and asset_Type_id=p_asset_type_id)) then
						   
		-- raise notice 'v_name %',v_name;
		 
		 select web_detail_jsn->'data'->'dynamic_form_data'->>v_name 
		 FROM labgt01_v1.labgt01_v1_asset_list
 		 where asset_id=p_asset_id and asset_Type_id=p_asset_type_id
		 into v_name1;
		 
		 
		 
-- 	if exists(select (web_detail_jsn->'data'->'dynamic_form_data'->>v_name)::jsonb->>'scr_word' 
-- 		 FROM labgt01_v1.labgt01_v1_asset_list
--  		 where asset_id=p_asset_id and asset_Type_id=p_asset_type_id) is not null then	 
-- 		 raise notice 'v_name1 %',v_name1;
-- 		 raise notice '1';
		 
-- 		 select v_name1::jsonb - 'scr_word' into v_name1::text;
		 
-- 	end if;	 
		 
		 
		--p_json:= jsonb_set(p_json,'{name}',v_name,true);
 		
		
	if 	v_name = 'additional_info' then
	
		--raise notice 'v_name1 %',v_name1;
		
		p_json :=  jsonb_set(p_json, '{additional_info}',to_jsonb( coalesce(v_name1::jsonb,'{}')));
	--	p_json := jsonb_set(p_json, ARRAY[v_name]::text[], coalesce(v_name1::jsonb, '{}'::jsonb), true);
	else
	
		p_json :=  to_jsonb(jsonb_set(p_json, ('{"'||v_name||'"}')::text[], (to_jsonb(v_name1))::jsonb, true));
		
	end if;
-- 		p_json2:= (jsonb_set(p_json2,('{"'||v_name||'"}')::text,v_name,true));
--	end if;	
	
	end if;
	
 end loop;

end ;
$_$;


--
