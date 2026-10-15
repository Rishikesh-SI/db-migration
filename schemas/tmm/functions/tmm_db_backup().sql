-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_db_backup()
-- Type: FUNCTION

-- Name: tmm_db_backup(); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'tmm';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.tmm_article as select * from tmm.tmm_article';
    execute 'create table '||v_backupschemaname||'.tmm_article_asset_map as select * from tmm.tmm_article_asset_map';
    execute 'create table '||v_backupschemaname||'.tmm_video as select * from tmm.tmm_video';
    execute 'create table '||v_backupschemaname||'.tmm_album as select * from tmm.tmm_album';
    execute 'create table '||v_backupschemaname||'.tmm_album_asset_map as select * from tmm.tmm_album_asset_map';
    execute 'create table '||v_backupschemaname||'.tmm_image as select * from tmm.tmm_image';
    execute 'create table '||v_backupschemaname||'.tmm_author_action as select * from tmm.tmm_author_action';
    execute 'create table '||v_backupschemaname||'.tmm_user as select * from tmm.tmm_user';
    execute 'create table '||v_backupschemaname||'.tmm_seo_data as select * from tmm.tmm_seo_data';
    execute 'create table '||v_backupschemaname||'.tmm_topic as select * from tmm.tmm_topic';
    execute 'create table '||v_backupschemaname||'.tmm_topic_asset_map as select * from tmm.tmm_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.tmm_poll as select * from tmm.tmm_poll';
    execute 'create table '||v_backupschemaname||'.tmm_poll_option as select * from tmm.tmm_poll_option';
    execute 'create table '||v_backupschemaname||'.tmm_poll_response as select * from tmm.tmm_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
