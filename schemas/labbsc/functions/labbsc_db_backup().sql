-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_db_backup()
-- Type: FUNCTION

-- Name: labbsc_db_backup(); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labbsc';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labbsc_article as select * from labbsc.labbsc_article';
    execute 'create table '||v_backupschemaname||'.labbsc_article_asset_map as select * from labbsc.labbsc_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labbsc_video as select * from labbsc.labbsc_video';
    execute 'create table '||v_backupschemaname||'.labbsc_album as select * from labbsc.labbsc_album';
    execute 'create table '||v_backupschemaname||'.labbsc_album_asset_map as select * from labbsc.labbsc_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labbsc_image as select * from labbsc.labbsc_image';
    execute 'create table '||v_backupschemaname||'.labbsc_author_action as select * from labbsc.labbsc_author_action';
    execute 'create table '||v_backupschemaname||'.labbsc_user as select * from labbsc.labbsc_user';
    execute 'create table '||v_backupschemaname||'.labbsc_seo_data as select * from labbsc.labbsc_seo_data';
    execute 'create table '||v_backupschemaname||'.labbsc_topic as select * from labbsc.labbsc_topic';
    execute 'create table '||v_backupschemaname||'.labbsc_topic_asset_map as select * from labbsc.labbsc_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labbsc_poll as select * from labbsc.labbsc_poll';
    execute 'create table '||v_backupschemaname||'.labbsc_poll_option as select * from labbsc.labbsc_poll_option';
    execute 'create table '||v_backupschemaname||'.labbsc_poll_response as select * from labbsc.labbsc_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
