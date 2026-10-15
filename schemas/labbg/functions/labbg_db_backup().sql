-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_db_backup()
-- Type: FUNCTION

-- Name: labbg_db_backup(); Type: FUNCTION; Schema: labbg; Owner: -
--

CREATE FUNCTION labbg.labbg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labbg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labbg_article as select * from labbg.labbg_article';
    execute 'create table '||v_backupschemaname||'.labbg_article_asset_map as select * from labbg.labbg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labbg_video as select * from labbg.labbg_video';
    execute 'create table '||v_backupschemaname||'.labbg_album as select * from labbg.labbg_album';
    execute 'create table '||v_backupschemaname||'.labbg_album_asset_map as select * from labbg.labbg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labbg_image as select * from labbg.labbg_image';
    execute 'create table '||v_backupschemaname||'.labbg_author_action as select * from labbg.labbg_author_action';
    execute 'create table '||v_backupschemaname||'.labbg_user as select * from labbg.labbg_user';
    execute 'create table '||v_backupschemaname||'.labbg_seo_data as select * from labbg.labbg_seo_data';
    execute 'create table '||v_backupschemaname||'.labbg_topic as select * from labbg.labbg_topic';
    execute 'create table '||v_backupschemaname||'.labbg_topic_asset_map as select * from labbg.labbg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labbg_poll as select * from labbg.labbg_poll';
    execute 'create table '||v_backupschemaname||'.labbg_poll_option as select * from labbg.labbg_poll_option';
    execute 'create table '||v_backupschemaname||'.labbg_poll_response as select * from labbg.labbg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
