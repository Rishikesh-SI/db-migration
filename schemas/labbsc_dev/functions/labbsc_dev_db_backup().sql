-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_db_backup()
-- Type: FUNCTION

-- Name: labbsc_dev_db_backup(); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labbsc_dev';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labbsc_dev_article as select * from labbsc_dev.labbsc_dev_article';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_article_asset_map as select * from labbsc_dev.labbsc_dev_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_video as select * from labbsc_dev.labbsc_dev_video';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_album as select * from labbsc_dev.labbsc_dev_album';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_album_asset_map as select * from labbsc_dev.labbsc_dev_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_image as select * from labbsc_dev.labbsc_dev_image';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_author_action as select * from labbsc_dev.labbsc_dev_author_action';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_user as select * from labbsc_dev.labbsc_dev_user';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_seo_data as select * from labbsc_dev.labbsc_dev_seo_data';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_topic as select * from labbsc_dev.labbsc_dev_topic';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_topic_asset_map as select * from labbsc_dev.labbsc_dev_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_poll as select * from labbsc_dev.labbsc_dev_poll';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_poll_option as select * from labbsc_dev.labbsc_dev_poll_option';
    execute 'create table '||v_backupschemaname||'.labbsc_dev_poll_response as select * from labbsc_dev.labbsc_dev_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
