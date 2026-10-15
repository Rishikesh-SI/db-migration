-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_db_backup()
-- Type: FUNCTION

-- Name: labiis_db_backup(); Type: FUNCTION; Schema: labiis; Owner: -
--

CREATE FUNCTION labiis.labiis_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labiis';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labiis_article as select * from labiis.labiis_article';
    execute 'create table '||v_backupschemaname||'.labiis_article_asset_map as select * from labiis.labiis_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labiis_video as select * from labiis.labiis_video';
    execute 'create table '||v_backupschemaname||'.labiis_album as select * from labiis.labiis_album';
    execute 'create table '||v_backupschemaname||'.labiis_album_asset_map as select * from labiis.labiis_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labiis_image as select * from labiis.labiis_image';
    execute 'create table '||v_backupschemaname||'.labiis_author_action as select * from labiis.labiis_author_action';
    execute 'create table '||v_backupschemaname||'.labiis_user as select * from labiis.labiis_user';
    execute 'create table '||v_backupschemaname||'.labiis_seo_data as select * from labiis.labiis_seo_data';
    execute 'create table '||v_backupschemaname||'.labiis_topic as select * from labiis.labiis_topic';
    execute 'create table '||v_backupschemaname||'.labiis_topic_asset_map as select * from labiis.labiis_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labiis_poll as select * from labiis.labiis_poll';
    execute 'create table '||v_backupschemaname||'.labiis_poll_option as select * from labiis.labiis_poll_option';
    execute 'create table '||v_backupschemaname||'.labiis_poll_response as select * from labiis.labiis_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
