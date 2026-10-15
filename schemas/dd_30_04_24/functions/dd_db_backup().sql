-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_db_backup()
-- Type: FUNCTION

-- Name: dd_db_backup(); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_sourceschemaname varchar(20) := 'dd';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.dd_article as select * from dd.dd_article';
    execute 'create table '||v_backupschemaname||'.dd_article_asset_map as select * from dd.dd_article_asset_map';
    execute 'create table '||v_backupschemaname||'.dd_video as select * from dd.dd_video';
    execute 'create table '||v_backupschemaname||'.dd_album as select * from dd.dd_album';
    execute 'create table '||v_backupschemaname||'.dd_album_asset_map as select * from dd.dd_album_asset_map';
    execute 'create table '||v_backupschemaname||'.dd_image as select * from dd.dd_image';
    execute 'create table '||v_backupschemaname||'.dd_author_action as select * from dd.dd_author_action';
    execute 'create table '||v_backupschemaname||'.dd_user as select * from dd.dd_user';
    execute 'create table '||v_backupschemaname||'.dd_seo_data as select * from dd.dd_seo_data';
    execute 'create table '||v_backupschemaname||'.dd_topic as select * from dd.dd_topic';
    execute 'create table '||v_backupschemaname||'.dd_topic_asset_map as select * from dd.dd_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.dd_poll as select * from dd.dd_poll';
    execute 'create table '||v_backupschemaname||'.dd_poll_option as select * from dd.dd_poll_option';
    execute 'create table '||v_backupschemaname||'.dd_poll_response as select * from dd.dd_poll_response';
    
    p_result := 1;
    
end;

$$;


--
