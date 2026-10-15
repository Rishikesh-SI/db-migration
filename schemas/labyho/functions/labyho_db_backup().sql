-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_db_backup()
-- Type: FUNCTION

-- Name: labyho_db_backup(); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labyho';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labyho_article as select * from labyho.labyho_article';
    execute 'create table '||v_backupschemaname||'.labyho_article_asset_map as select * from labyho.labyho_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labyho_video as select * from labyho.labyho_video';
    execute 'create table '||v_backupschemaname||'.labyho_album as select * from labyho.labyho_album';
    execute 'create table '||v_backupschemaname||'.labyho_album_asset_map as select * from labyho.labyho_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labyho_image as select * from labyho.labyho_image';
    execute 'create table '||v_backupschemaname||'.labyho_author_action as select * from labyho.labyho_author_action';
    execute 'create table '||v_backupschemaname||'.labyho_user as select * from labyho.labyho_user';
    execute 'create table '||v_backupschemaname||'.labyho_seo_data as select * from labyho.labyho_seo_data';
    execute 'create table '||v_backupschemaname||'.labyho_topic as select * from labyho.labyho_topic';
    execute 'create table '||v_backupschemaname||'.labyho_topic_asset_map as select * from labyho.labyho_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labyho_poll as select * from labyho.labyho_poll';
    execute 'create table '||v_backupschemaname||'.labyho_poll_option as select * from labyho.labyho_poll_option';
    execute 'create table '||v_backupschemaname||'.labyho_poll_response as select * from labyho.labyho_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
