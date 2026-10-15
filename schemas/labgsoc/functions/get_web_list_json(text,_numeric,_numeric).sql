-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: _get_web_list_json(text, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_web_list_json(text, numeric, numeric); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc._get_web_list_json(p_schema_prefix text, p_asset_type_id numeric, p_asset_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

begin 
p_schema_prefix:='labgsoc';
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
case when asset_type_id = 39 then

jsonb_array_length(web_detail_jsn->''data''->''contest_questions'') 
else total_assets 
end
as total_assets,

image_file_name, 
image_path,
duration, 
published_version_number,
sl.created_date, 
sl.updated_date, 
sl.created_by, 
sl.updated_by,
published_date,
(select p_canonical_url from labgsoc.labgsoc_get_canonical_url_r(sl.primary_entity_role_map_id)) as pri_ent_url,
(select p_canonical_url from labgsoc.labgsoc_get_canonical_url_r(sl.primary_entity_role_map_id)) as pri_canonical_url,
u.display_name display_name,
u.user_name user_name,
(select p_canonical_url from labgsoc.labgsoc_get_canonical_url_r(sl.secondary_entity_role_map_id)) as sec_ent_url,
(select p_canonical_url from labgsoc.labgsoc_get_canonical_url_r(sl.secondary_entity_role_map_id)) as sec_canonical_url,
u.full_name full_name,
(SELECT p_entity_name from labgsoc.labgsoc_get_entity_name_by_lang(language_id,sl.primary_entity_role_map_id)) as primary_entity_name,
(SELECT p_entity_display_name from labgsoc.labgsoc_get_entity_name_by_lang(language_id,sl.primary_entity_role_map_id)) as pri_ent_disp_name,
(SELECT p_entity_name from labgsoc.labgsoc_get_entity_name_by_lang(language_id,sl.secondary_entity_role_map_id)) as secondary_entity_name,
(SELECT p_entity_display_name from labgsoc.labgsoc_get_entity_name_by_lang(language_id,sl.secondary_entity_role_map_id)) as sec_ent_disp_name
from labgsoc.labgsoc_asset_list sl
left join labgsoc.labgsoc_user u
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
