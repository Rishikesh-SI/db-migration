-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_db_backup()
-- Type: FUNCTION

-- Name: labtri_db_backup(); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labtri';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labtri_article as select * from labtri.labtri_article';
    execute 'create table '||v_backupschemaname||'.labtri_article_asset_map as select * from labtri.labtri_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labtri_video as select * from labtri.labtri_video';
    execute 'create table '||v_backupschemaname||'.labtri_album as select * from labtri.labtri_album';
    execute 'create table '||v_backupschemaname||'.labtri_album_asset_map as select * from labtri.labtri_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labtri_image as select * from labtri.labtri_image';
    execute 'create table '||v_backupschemaname||'.labtri_author_action as select * from labtri.labtri_author_action';
    execute 'create table '||v_backupschemaname||'.labtri_user as select * from labtri.labtri_user';
    execute 'create table '||v_backupschemaname||'.labtri_seo_data as select * from labtri.labtri_seo_data';
    execute 'create table '||v_backupschemaname||'.labtri_topic as select * from labtri.labtri_topic';
    execute 'create table '||v_backupschemaname||'.labtri_topic_asset_map as select * from labtri.labtri_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labtri_poll as select * from labtri.labtri_poll';
    execute 'create table '||v_backupschemaname||'.labtri_poll_option as select * from labtri.labtri_poll_option';
    execute 'create table '||v_backupschemaname||'.labtri_poll_response as select * from labtri.labtri_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
