-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_del_entity_and_content(numeric)
-- Type: FUNCTION

-- Name: labwis_del_entity_and_content(numeric); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_del_entity_and_content(p_asset_type_id numeric, OUT p_data numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	v_entity_role_id numeric;
	v_asset_type_id numeric;
	v_entity_role_map_id numeric;
	v_entity_master_id numeric;
	i numeric;
	j numeric;
begin
/*
{"data":{"ref_ids":[124,100,200]}}
*/

	select p_asset_type_id into v_asset_type_id;
	
if v_asset_type_id in (1,2,4) then
		if (v_asset_type_id = 1) then
			delete from labwis.labwis_asset_draft
			where asset_id in (select article_id from labwis.labwis_article) and asset_type_id = 1;
			delete from labwis.labwis_asset_list
			where asset_id in (select article_id from labwis.labwis_article) and asset_type_id = 1;
			delete from labwis.labwis_asset_entity_map
			where asset_id in (select article_id from labwis.labwis_article) and asset_type_id = 1;
			delete from labwis.labwis_seo_data
			where asset_id in (select article_id from labwis.labwis_article) and asset_type_id = 1;
			delete from labwis.labwis_author_action
			where asset_id in (select article_id from labwis.labwis_article) and asset_type_id = 1;
			delete from labwis.labwis_article_asset_map;
			delete from labwis.labwis_article;

			p_data := 1;

		elsif(v_asset_type_id = 4) then
			delete from labwis.labwis_asset_draft
			where asset_id in (select video_id from labwis.labwis_video) and asset_type_id = 4;
			delete from labwis.labwis_asset_list
			where asset_id in (select video_id from labwis.labwis_video) and asset_type_id = 4;
			delete from labwis.labwis_asset_entity_map
			where asset_id in (select video_id from labwis.labwis_video) and asset_type_id = 4;
			delete from labwis.labwis_seo_data
			where asset_id in (select video_id from labwis.labwis_video) and asset_type_id = 4;
			delete from labwis.labwis_author_action
			where asset_id in (select video_id from labwis.labwis_video) and asset_type_id = 4;
			delete from labwis.labwis_video;

			p_data := 1;

		elsif (v_asset_type_id = 2) then
			delete from labwis.labwis_asset_draft
			where asset_id in (select album_id from labwis.labwis_album) and asset_type_id = 2;
			delete from labwis.labwis_asset_list
			where asset_id in (select album_id from labwis.labwis_album) and asset_type_id = 2;
			delete from labwis.labwis_asset_entity_map
			where asset_id in (select album_id from labwis.labwis_album) and asset_type_id = 2;
			delete from labwis.labwis_seo_data
			where asset_id in (select album_id from labwis.labwis_album) and asset_type_id = 2;
			delete from labwis.labwis_author_action
			where asset_id in (select album_id from labwis.labwis_album) and asset_type_id = 2;
			delete from labwis.labwis_album_asset_map;
			delete from labwis.labwis_album;

			p_data := 1;

		else 

			p_data := -1 ;
			
		end if;
		
	else 

		delete from labwis.labwis_entity_master
    	where entity_master_id in (
        select erm.entity_master_id
        from labwis.labwis_entity_role_map erm
        join labwis.labwis_asset_type at on erm.entity_role_id = at.entity_role_id
        where at.asset_type_id = v_asset_type_id
    );
	
	
		delete from labwis.labwis_entity_role_map
    	where entity_role_map_id in (
        select erm.entity_role_map_id
        from labwis.labwis_entity_role_map erm
        join labwis.labwis_asset_type at on erm.entity_role_id = at.entity_role_id
        where at.asset_type_id = v_asset_type_id
    );
		
		p_data := 2;
	
end if;

end;
$$;


--
