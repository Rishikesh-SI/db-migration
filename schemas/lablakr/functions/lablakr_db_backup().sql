-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_db_backup()
-- Type: FUNCTION

-- Name: lablakr_db_backup(); Type: FUNCTION; Schema: lablakr; Owner: -
--

CREATE FUNCTION lablakr.lablakr_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'lablakr';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.lablakr_article as select * from lablakr.lablakr_article';
    execute 'create table '||v_backupschemaname||'.lablakr_article_asset_map as select * from lablakr.lablakr_article_asset_map';
    execute 'create table '||v_backupschemaname||'.lablakr_video as select * from lablakr.lablakr_video';
    execute 'create table '||v_backupschemaname||'.lablakr_album as select * from lablakr.lablakr_album';
    execute 'create table '||v_backupschemaname||'.lablakr_album_asset_map as select * from lablakr.lablakr_album_asset_map';
    execute 'create table '||v_backupschemaname||'.lablakr_image as select * from lablakr.lablakr_image';
    execute 'create table '||v_backupschemaname||'.lablakr_author_action as select * from lablakr.lablakr_author_action';
    execute 'create table '||v_backupschemaname||'.lablakr_user as select * from lablakr.lablakr_user';
    execute 'create table '||v_backupschemaname||'.lablakr_seo_data as select * from lablakr.lablakr_seo_data';
    execute 'create table '||v_backupschemaname||'.lablakr_topic as select * from lablakr.lablakr_topic';
    execute 'create table '||v_backupschemaname||'.lablakr_topic_asset_map as select * from lablakr.lablakr_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.lablakr_poll as select * from lablakr.lablakr_poll';
    execute 'create table '||v_backupschemaname||'.lablakr_poll_option as select * from lablakr.lablakr_poll_option';
    execute 'create table '||v_backupschemaname||'.lablakr_poll_response as select * from lablakr.lablakr_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
