-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: labeisl_delete_asset(numeric, numeric)
-- Type: FUNCTION

-- Name: labeisl_delete_asset(numeric, numeric); Type: FUNCTION; Schema: labeisl; Owner: -
--

CREATE FUNCTION labeisl.labeisl_delete_asset(p_asset_id numeric, p_asset_type_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare

begin 

if p_asset_type_id=1 then 
  
update labeisl.labeisl_article
set 
   is_deleted=1,
   is_trashed=1,
   is_published=0
where article_id=p_asset_id ;

elsif p_asset_type_id=2 then 

  update labeisl.labeisl_album
set 
   is_deleted=1,
   is_trashed=1,
   is_published=0
where album_id=p_asset_id ;

elsif p_asset_type_id=4 then 

  update labeisl.labeisl_video
set 
   is_deleted=1,
   is_trashed=1,
   is_published=0
where video_id=p_asset_id ;

end if;

update labeisl.labeisl_asset_list
set 
   is_deleted=1,
   is_trashed=1,
   is_published=0
where asset_id=p_asset_id 
and asset_type_id=p_asset_type_id;

p_result:=1;

end

 $$;


--
