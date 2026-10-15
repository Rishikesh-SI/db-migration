-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: _get_web_list_json(text, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_web_list_json(text, numeric, numeric); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1._get_web_list_json(p_schema_prefix text, p_asset_type_id numeric, p_asset_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

begin 
p_schema_prefix:='labgt01_v1';
execute '
select row_to_json(row) as web_list from (
select 
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
jsonb_array_length((web_detail_jsn->''data''->>''slides'')::jsonb) as total_assets,
image_file_name, 
image_path,
duration, 
published_version_number,
(select web_detail_jsn->''data''->''slides''->(jsonb_array_length((web_detail_jsn->''data''->>''slides'')::jsonb)-1)->''data''->>''webstory_slide_id'') as last_story_slide,

sl.created_date, 
sl.updated_date, 
sl.created_by, 
sl.updated_by,
published_date,
(select p_canonical_url from labgt01_v1.labgt01_v1_get_canonical_url_r(sl.primary_entity_role_map_id)) as pri_canonical_url,
u.display_name display_name,
u.user_name user_name,
(select p_canonical_url from labgt01_v1.labgt01_v1_get_canonical_url_r(sl.secondary_entity_role_map_id)) as sec_canonical_url,
u.full_name full_name,
(SELECT p_entity_name from labgt01_v1.labgt01_v1_get_entity_name_by_lang(language_id,sl.primary_entity_role_map_id)) as primary_entity_name,
(SELECT p_entity_display_name from labgt01_v1.labgt01_v1_get_entity_name_by_lang(language_id,sl.primary_entity_role_map_id)) as pri_ent_disp_name,
(SELECT p_entity_name from labgt01_v1.labgt01_v1_get_entity_name_by_lang(language_id,sl.secondary_entity_role_map_id)) as secondary_entity_name,
(SELECT p_entity_display_name from labgt01_v1.labgt01_v1_get_entity_name_by_lang(language_id,sl.secondary_entity_role_map_id)) as sec_ent_disp_name,
b.entity_url as pri_ent_url,d.entity_url_type as pri_entity_url_type,
b1.entity_url as sec_ent_url,d1.entity_url_type as sec_entity_url_type
from labgt01_v1.labgt01_v1_asset_list sl
left join labgt01_v1.labgt01_v1_user u
on u.user_id = author_id
left join labgt01_v1.labgt01_v1_entity_role_map a on sl.primary_entity_role_map_id = a.entity_role_map_id  
left join labgt01_v1.labgt01_v1_entity_master b on a.entity_master_id = b.entity_master_id
left join labgt01_v1.labgt01_v1_entity_role c on a.entity_role_id = c.entity_role_id
left join labgt01_v1.labgt01_v1_entity_type d on c.entity_type_id = d.entity_type_id

left join labgt01_v1.labgt01_v1_entity_role_map a1 on sl.secondary_entity_role_map_id = a1.entity_role_map_id  
left join labgt01_v1.labgt01_v1_entity_master b1 on a1.entity_master_id = b1.entity_master_id
left join labgt01_v1.labgt01_v1_entity_role c1 on a1.entity_role_id = c1.entity_role_id
left join labgt01_v1.labgt01_v1_entity_type d1 on c1.entity_type_id = d1.entity_type_id
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
end ;
$_$;


--
