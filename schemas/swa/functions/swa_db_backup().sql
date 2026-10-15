-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_db_backup()
-- Type: FUNCTION

-- Name: swa_db_backup(); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_sourceschemaname varchar(20) := 'swa';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.swa_article as select * from swa.swa_article';
    execute 'create table '||v_backupschemaname||'.swa_article_asset_map as select * from swa.swa_article_asset_map';
    execute 'create table '||v_backupschemaname||'.swa_video as select * from swa.swa_video';
    execute 'create table '||v_backupschemaname||'.swa_album as select * from swa.swa_album';
    execute 'create table '||v_backupschemaname||'.swa_album_asset_map as select * from swa.swa_album_asset_map';
    execute 'create table '||v_backupschemaname||'.swa_image as select * from swa.swa_image';
    execute 'create table '||v_backupschemaname||'.swa_author_action as select * from swa.swa_author_action';
    execute 'create table '||v_backupschemaname||'.swa_user as select * from swa.swa_user';
    execute 'create table '||v_backupschemaname||'.swa_seo_data as select * from swa.swa_seo_data';
    execute 'create table '||v_backupschemaname||'.swa_topic as select * from swa.swa_topic';
    execute 'create table '||v_backupschemaname||'.swa_topic_asset_map as select * from swa.swa_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.swa_poll as select * from swa.swa_poll';
    execute 'create table '||v_backupschemaname||'.swa_poll_option as select * from swa.swa_poll_option';
    execute 'create table '||v_backupschemaname||'.swa_poll_response as select * from swa.swa_poll_response';
    
    p_result := 1;
    
end;

$$;


--
