-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_db_backup()
-- Type: FUNCTION

-- Name: labbr_db_backup(); Type: FUNCTION; Schema: labbr; Owner: -
--

CREATE FUNCTION labbr.labbr_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labbr';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labbr_article as select * from labbr.labbr_article';
    execute 'create table '||v_backupschemaname||'.labbr_article_asset_map as select * from labbr.labbr_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labbr_video as select * from labbr.labbr_video';
    execute 'create table '||v_backupschemaname||'.labbr_album as select * from labbr.labbr_album';
    execute 'create table '||v_backupschemaname||'.labbr_album_asset_map as select * from labbr.labbr_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labbr_image as select * from labbr.labbr_image';
    execute 'create table '||v_backupschemaname||'.labbr_author_action as select * from labbr.labbr_author_action';
    execute 'create table '||v_backupschemaname||'.labbr_user as select * from labbr.labbr_user';
    execute 'create table '||v_backupschemaname||'.labbr_seo_data as select * from labbr.labbr_seo_data';
    execute 'create table '||v_backupschemaname||'.labbr_topic as select * from labbr.labbr_topic';
    execute 'create table '||v_backupschemaname||'.labbr_topic_asset_map as select * from labbr.labbr_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labbr_poll as select * from labbr.labbr_poll';
    execute 'create table '||v_backupschemaname||'.labbr_poll_option as select * from labbr.labbr_poll_option';
    execute 'create table '||v_backupschemaname||'.labbr_poll_response as select * from labbr.labbr_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
