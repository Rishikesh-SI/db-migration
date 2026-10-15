-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_db_backup()
-- Type: FUNCTION

-- Name: tmmimg_upd_db_backup(); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'tmmimg_upd';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_article as select * from tmmimg_upd.tmmimg_upd_article';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_article_asset_map as select * from tmmimg_upd.tmmimg_upd_article_asset_map';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_video as select * from tmmimg_upd.tmmimg_upd_video';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_album as select * from tmmimg_upd.tmmimg_upd_album';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_album_asset_map as select * from tmmimg_upd.tmmimg_upd_album_asset_map';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_image as select * from tmmimg_upd.tmmimg_upd_image';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_author_action as select * from tmmimg_upd.tmmimg_upd_author_action';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_user as select * from tmmimg_upd.tmmimg_upd_user';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_seo_data as select * from tmmimg_upd.tmmimg_upd_seo_data';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_topic as select * from tmmimg_upd.tmmimg_upd_topic';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_topic_asset_map as select * from tmmimg_upd.tmmimg_upd_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_poll as select * from tmmimg_upd.tmmimg_upd_poll';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_poll_option as select * from tmmimg_upd.tmmimg_upd_poll_option';
    execute 'create table '||v_backupschemaname||'.tmmimg_upd_poll_response as select * from tmmimg_upd.tmmimg_upd_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
