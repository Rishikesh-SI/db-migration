-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_db_backup()
-- Type: FUNCTION

-- Name: dhm_db_backup(); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'dhm';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.dhm_article as select * from dhm.dhm_article';
    execute 'create table '||v_backupschemaname||'.dhm_article_asset_map as select * from dhm.dhm_article_asset_map';
    execute 'create table '||v_backupschemaname||'.dhm_video as select * from dhm.dhm_video';
    execute 'create table '||v_backupschemaname||'.dhm_album as select * from dhm.dhm_album';
    execute 'create table '||v_backupschemaname||'.dhm_album_asset_map as select * from dhm.dhm_album_asset_map';
    execute 'create table '||v_backupschemaname||'.dhm_image as select * from dhm.dhm_image';
    execute 'create table '||v_backupschemaname||'.dhm_author_action as select * from dhm.dhm_author_action';
    execute 'create table '||v_backupschemaname||'.dhm_user as select * from dhm.dhm_user';
    execute 'create table '||v_backupschemaname||'.dhm_seo_data as select * from dhm.dhm_seo_data';
    execute 'create table '||v_backupschemaname||'.dhm_topic as select * from dhm.dhm_topic';
    execute 'create table '||v_backupschemaname||'.dhm_topic_asset_map as select * from dhm.dhm_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.dhm_poll as select * from dhm.dhm_poll';
    execute 'create table '||v_backupschemaname||'.dhm_poll_option as select * from dhm.dhm_poll_option';
    execute 'create table '||v_backupschemaname||'.dhm_poll_response as select * from dhm.dhm_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
