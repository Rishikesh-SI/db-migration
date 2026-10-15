-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: _get_web_list_json(text, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_web_list_json(text, numeric, numeric); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1._get_web_list_json(p_schema_prefix text, p_asset_type_id numeric, p_asset_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

begin 
p_schema_prefix:='labkkr_v1';
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
total_assets,
image_file_name, 
image_path,
duration, 
published_version_number,
web_detail_jsn->''data''->''focus_by_keywords'' as focus_by_keywords,
sl.created_date, 
sl.updated_date, 
sl.created_by, 
sl.updated_by,
published_date,
(select p_canonical_url from labkkr_v1.labkkr_v1_get_canonical_url_r(sl.primary_entity_role_map_id)) as pri_ent_url,
u.display_name display_name,
u.user_name user_name,
(select p_canonical_url from labkkr_v1.labkkr_v1_get_canonical_url_r(sl.secondary_entity_role_map_id)) as sec_ent_url,
u.full_name full_name,
(SELECT p_entity_name from labkkr_v1.labkkr_v1_get_entity_name_by_lang(language_id,sl.primary_entity_role_map_id)) as primary_entity_name,
(SELECT p_entity_display_name from labkkr_v1.labkkr_v1_get_entity_name_by_lang(language_id,sl.primary_entity_role_map_id)) as pri_ent_disp_name,
(SELECT p_entity_name from labkkr_v1.labkkr_v1_get_entity_name_by_lang(language_id,sl.secondary_entity_role_map_id)) as secondary_entity_name,
(SELECT p_entity_display_name from labkkr_v1.labkkr_v1_get_entity_name_by_lang(language_id,sl.secondary_entity_role_map_id)) as sec_ent_disp_name
from labkkr_v1.labkkr_v1_asset_list sl
left join labkkr_v1.labkkr_v1_user u
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
end ;
$_$;


--
