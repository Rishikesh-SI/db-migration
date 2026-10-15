-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_delete_asset(numeric, numeric)
-- Type: FUNCTION

-- Name: labw88_delete_asset(numeric, numeric); Type: FUNCTION; Schema: labw88; Owner: -
--

CREATE FUNCTION labw88.labw88_delete_asset(p_asset_id numeric, p_asset_type_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare

begin 

if p_asset_type_id=1 then 
  
update labw88.labw88_article
set 
   is_deleted=1,
   is_trashed=1,
   is_published=0
where article_id=p_asset_id ;

elsif p_asset_type_id=2 then 

  update labw88.labw88_album
set 
   is_deleted=1,
   is_trashed=1,
   is_published=0
where album_id=p_asset_id ;

elsif p_asset_type_id=4 then 

  update labw88.labw88_video
set 
   is_deleted=1,
   is_trashed=1,
   is_published=0
where video_id=p_asset_id ;

end if;

update labw88.labw88_asset_list
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
