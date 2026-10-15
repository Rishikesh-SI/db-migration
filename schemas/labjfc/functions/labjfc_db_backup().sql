-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_db_backup()
-- Type: FUNCTION

-- Name: labjfc_db_backup(); Type: FUNCTION; Schema: labjfc; Owner: -
--

CREATE FUNCTION labjfc.labjfc_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labjfc';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labjfc_article as select * from labjfc.labjfc_article';
    execute 'create table '||v_backupschemaname||'.labjfc_article_asset_map as select * from labjfc.labjfc_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labjfc_video as select * from labjfc.labjfc_video';
    execute 'create table '||v_backupschemaname||'.labjfc_album as select * from labjfc.labjfc_album';
    execute 'create table '||v_backupschemaname||'.labjfc_album_asset_map as select * from labjfc.labjfc_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labjfc_image as select * from labjfc.labjfc_image';
    execute 'create table '||v_backupschemaname||'.labjfc_author_action as select * from labjfc.labjfc_author_action';
    execute 'create table '||v_backupschemaname||'.labjfc_user as select * from labjfc.labjfc_user';
    execute 'create table '||v_backupschemaname||'.labjfc_seo_data as select * from labjfc.labjfc_seo_data';
    execute 'create table '||v_backupschemaname||'.labjfc_topic as select * from labjfc.labjfc_topic';
    execute 'create table '||v_backupschemaname||'.labjfc_topic_asset_map as select * from labjfc.labjfc_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labjfc_poll as select * from labjfc.labjfc_poll';
    execute 'create table '||v_backupschemaname||'.labjfc_poll_option as select * from labjfc.labjfc_poll_option';
    execute 'create table '||v_backupschemaname||'.labjfc_poll_response as select * from labjfc.labjfc_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
