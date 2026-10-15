-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_db_backup()
-- Type: FUNCTION

-- Name: labrg_db_backup(); Type: FUNCTION; Schema: labrg; Owner: -
--

CREATE FUNCTION labrg.labrg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labrg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labrg_article as select * from labrg.labrg_article';
    execute 'create table '||v_backupschemaname||'.labrg_article_asset_map as select * from labrg.labrg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labrg_video as select * from labrg.labrg_video';
    execute 'create table '||v_backupschemaname||'.labrg_album as select * from labrg.labrg_album';
    execute 'create table '||v_backupschemaname||'.labrg_album_asset_map as select * from labrg.labrg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labrg_image as select * from labrg.labrg_image';
    execute 'create table '||v_backupschemaname||'.labrg_author_action as select * from labrg.labrg_author_action';
    execute 'create table '||v_backupschemaname||'.labrg_user as select * from labrg.labrg_user';
    execute 'create table '||v_backupschemaname||'.labrg_seo_data as select * from labrg.labrg_seo_data';
    execute 'create table '||v_backupschemaname||'.labrg_topic as select * from labrg.labrg_topic';
    execute 'create table '||v_backupschemaname||'.labrg_topic_asset_map as select * from labrg.labrg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labrg_poll as select * from labrg.labrg_poll';
    execute 'create table '||v_backupschemaname||'.labrg_poll_option as select * from labrg.labrg_poll_option';
    execute 'create table '||v_backupschemaname||'.labrg_poll_response as select * from labrg.labrg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
