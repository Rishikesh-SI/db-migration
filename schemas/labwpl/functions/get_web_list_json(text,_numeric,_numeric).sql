-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: _get_web_list_json(text, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_web_list_json(text, numeric, numeric); Type: FUNCTION; Schema: labwpl; Owner: -
--

CREATE FUNCTION labwpl._get_web_list_json(p_schema_prefix text, p_asset_type_id numeric, p_asset_id numeric, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

begin 
p_schema_prefix:='labwpl';
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
(select video_url from labwpl.labwpl_video where video_id=$2) as video_url,
image_path,
duration, 
published_version_number,
sl.created_date, 
sl.updated_date, 
sl.created_by, 
sl.updated_by,
sl.tagged_entity,
published_date,
(select source_object_id from (select array_agg(erm.source_object_id) as source_object_id
        from unnest(sl.tagged_entity) as te(entity_role_map_id)
        join labwpl.labwpl_entity_role_map erm on erm.entity_role_map_id = te.entity_role_map_id and entity_role_id in (62))a) as player_source_object_id,

		
		
(select p_canonical_url from labwpl.labwpl_get_canonical_url_r(sl.primary_entity_role_map_id)) as pri_ent_url,
u.display_name display_name,
u.user_name user_name,
(select p_canonical_url from labwpl.labwpl_get_canonical_url_r(sl.secondary_entity_role_map_id)) as sec_ent_url,
u.full_name full_name,
(SELECT p_entity_name from labwpl.labwpl_get_entity_name_by_lang(language_id,sl.primary_entity_role_map_id)) as primary_entity_name,
(SELECT p_entity_display_name from labwpl.labwpl_get_entity_name_by_lang(language_id,sl.primary_entity_role_map_id)) as pri_ent_disp_name,
(SELECT p_entity_name from labwpl.labwpl_get_entity_name_by_lang(language_id,sl.secondary_entity_role_map_id)) as secondary_entity_name,
(SELECT p_entity_display_name from labwpl.labwpl_get_entity_name_by_lang(language_id,sl.secondary_entity_role_map_id)) as sec_ent_disp_name

		
from labwpl.labwpl_asset_list sl
left join labwpl.labwpl_user u
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
