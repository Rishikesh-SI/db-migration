-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_author_detail_r(numeric, numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labwis_get_author_detail_r(numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_author_detail_r(p_author_id numeric, p_page_number numeric, p_item_number numeric, p_page1_size numeric, p_asset_type_id numeric, OUT p_authorjson jsonb, OUT p_authorcount jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
    v_limit smallint := case p_page_number when 1 then p_page1_size else p_item_number end;
	v_offset smallint := case p_page_number when 1 then 0 else (p_page1_size + (((p_page_number - 1) * p_item_number) - p_item_number)) end;
	v_asset_type_id numeric;
	v_author_id numeric;
begin
	   v_asset_type_id = p_asset_type_id;
 	   v_author_id = p_author_id;
	   
    execute 'with cte as
			(select u.full_name,u.profile_picture_url as profile_image , designation,
												u.bio,u.socialdata as social_media_link,user_id from labwis.labwis_user u where user_id = $2)
			select json_agg(q) from(select a.content_list,cte.* from (select json_agg(x)  as content_list  from (select sl.asset_list_id, sl.asset_id, sl.asset_type_id, sl.asset_title, sl.title_alias, author_id, short_desc, tags,
												primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, duration,
												sl.show_in_web, sl.show_in_mobile, sl.show_in_app, sl.published_version_number, sl.is_trashed, sl.created_date, sl.updated_date,
												sl.created_by, sl.updated_by, sl.is_active, sl.is_deleted, sl.is_published, sl.published_date, asset_guid,
												sl.show_copyright, sl.order_number 
							from labwis.labwis_asset_list sl
							join labwis.labwis_user u
							on u.user_id = sl.author_id
							where  sl.is_active=1
                             and    sl.is_deleted=0
                             and    sl.is_published=1
                            and    sl.asset_type_id = $1
							and 	author_id = $2
							)x)a,cte)q
							limit $3
							offset $4'
            into p_authorjson
            using v_asset_type_id,v_author_id,v_limit,v_offset;
			
			
			execute 'select count(1)
                             from   labwis.labwis_asset_list sl
                             join labwis.labwis_user u
                             on     u.user_id = sl.author_id                             
                             where  sl.is_active=1
                             and    sl.is_deleted=0
                             and    sl.is_published=1
                            and    sl.asset_type_id = $1
							and 	author_id = $2'
			into p_authorcount
			using v_asset_type_id,v_author_id;
    
end;

 

$_$;


--
