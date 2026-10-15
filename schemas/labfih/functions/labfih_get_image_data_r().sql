-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_get_image_data_r()
-- Type: FUNCTION

-- Name: labfih_get_image_data_r(); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_get_image_data_r() RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
p_assetjson jsonb;

begin
select json_agg(row_to_json(a)) into p_assetjson from
(select image_id,
content_source_id,
image_caption,
image_meta,
image_desc,
image_path,
copyright_text,
image_file_name,
published_version_number,
created_date,
updated_date,
created_by,
updated_by,
is_active,
is_deleted,
is_published,
image_guid,
show_copyright,
content_source_link,
order_number,
title_alias,
asset_type_id
from(select
image_id,
content_source_id,
image_caption,
image_meta,
image_desc,
image_path,
copyright_text,
image_file_name,
published_version_number,
created_date,
updated_date,
created_by,
updated_by,
is_active,
is_deleted,
is_published,
image_guid,
show_copyright,
content_source_link,
order_number,
title_alias,
asset_type_id,row_number() over (order by image_id) as r from labfih.labfih_image where coalesce(is_displayed,0)=0)a
where r<=30)a;

/*
update labfih.labfih_image set is_displayed=null where image_id in(
select image_id from(
select image_id,row_number() over (order by image_id) as r from labfih.labfih_image where coalesce(is_displayed,0)=0)a
where r<=30);
*/

return(p_assetjson);
end;
$$;


--
