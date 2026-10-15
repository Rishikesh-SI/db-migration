-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_db_backup()
-- Type: FUNCTION

-- Name: labtcs_db_backup(); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labtcs';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labtcs_article as select * from labtcs.labtcs_article';
    execute 'create table '||v_backupschemaname||'.labtcs_article_asset_map as select * from labtcs.labtcs_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labtcs_video as select * from labtcs.labtcs_video';
    execute 'create table '||v_backupschemaname||'.labtcs_album as select * from labtcs.labtcs_album';
    execute 'create table '||v_backupschemaname||'.labtcs_album_asset_map as select * from labtcs.labtcs_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labtcs_image as select * from labtcs.labtcs_image';
    execute 'create table '||v_backupschemaname||'.labtcs_author_action as select * from labtcs.labtcs_author_action';
    execute 'create table '||v_backupschemaname||'.labtcs_user as select * from labtcs.labtcs_user';
    execute 'create table '||v_backupschemaname||'.labtcs_seo_data as select * from labtcs.labtcs_seo_data';
    execute 'create table '||v_backupschemaname||'.labtcs_topic as select * from labtcs.labtcs_topic';
    execute 'create table '||v_backupschemaname||'.labtcs_topic_asset_map as select * from labtcs.labtcs_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labtcs_poll as select * from labtcs.labtcs_poll';
    execute 'create table '||v_backupschemaname||'.labtcs_poll_option as select * from labtcs.labtcs_poll_option';
    execute 'create table '||v_backupschemaname||'.labtcs_poll_response as select * from labtcs.labtcs_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
