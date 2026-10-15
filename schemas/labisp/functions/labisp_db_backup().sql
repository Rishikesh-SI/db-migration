-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_db_backup()
-- Type: FUNCTION

-- Name: labisp_db_backup(); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labisp';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labisp_article as select * from labisp.labisp_article';
    execute 'create table '||v_backupschemaname||'.labisp_article_asset_map as select * from labisp.labisp_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labisp_video as select * from labisp.labisp_video';
    execute 'create table '||v_backupschemaname||'.labisp_album as select * from labisp.labisp_album';
    execute 'create table '||v_backupschemaname||'.labisp_album_asset_map as select * from labisp.labisp_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labisp_image as select * from labisp.labisp_image';
    execute 'create table '||v_backupschemaname||'.labisp_author_action as select * from labisp.labisp_author_action';
    execute 'create table '||v_backupschemaname||'.labisp_user as select * from labisp.labisp_user';
    execute 'create table '||v_backupschemaname||'.labisp_seo_data as select * from labisp.labisp_seo_data';
    execute 'create table '||v_backupschemaname||'.labisp_topic as select * from labisp.labisp_topic';
    execute 'create table '||v_backupschemaname||'.labisp_topic_asset_map as select * from labisp.labisp_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labisp_poll as select * from labisp.labisp_poll';
    execute 'create table '||v_backupschemaname||'.labisp_poll_option as select * from labisp.labisp_poll_option';
    execute 'create table '||v_backupschemaname||'.labisp_poll_response as select * from labisp.labisp_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
