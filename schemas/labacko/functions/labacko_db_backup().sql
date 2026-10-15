-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_db_backup()
-- Type: FUNCTION

-- Name: labacko_db_backup(); Type: FUNCTION; Schema: labacko; Owner: -
--

CREATE FUNCTION labacko.labacko_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labacko';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labacko_article as select * from labacko.labacko_article';
    execute 'create table '||v_backupschemaname||'.labacko_article_asset_map as select * from labacko.labacko_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labacko_video as select * from labacko.labacko_video';
    execute 'create table '||v_backupschemaname||'.labacko_album as select * from labacko.labacko_album';
    execute 'create table '||v_backupschemaname||'.labacko_album_asset_map as select * from labacko.labacko_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labacko_image as select * from labacko.labacko_image';
    execute 'create table '||v_backupschemaname||'.labacko_author_action as select * from labacko.labacko_author_action';
    execute 'create table '||v_backupschemaname||'.labacko_user as select * from labacko.labacko_user';
    execute 'create table '||v_backupschemaname||'.labacko_seo_data as select * from labacko.labacko_seo_data';
    execute 'create table '||v_backupschemaname||'.labacko_topic as select * from labacko.labacko_topic';
    execute 'create table '||v_backupschemaname||'.labacko_topic_asset_map as select * from labacko.labacko_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labacko_poll as select * from labacko.labacko_poll';
    execute 'create table '||v_backupschemaname||'.labacko_poll_option as select * from labacko.labacko_poll_option';
    execute 'create table '||v_backupschemaname||'.labacko_poll_response as select * from labacko.labacko_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
