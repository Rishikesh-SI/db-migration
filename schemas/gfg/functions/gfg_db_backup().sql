-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: gfg_db_backup()
-- Type: FUNCTION

-- Name: gfg_db_backup(); Type: FUNCTION; Schema: gfg; Owner: -
--

CREATE FUNCTION gfg.gfg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'gfg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.gfg_article as select * from gfg.gfg_article';
    execute 'create table '||v_backupschemaname||'.gfg_article_asset_map as select * from gfg.gfg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.gfg_video as select * from gfg.gfg_video';
    execute 'create table '||v_backupschemaname||'.gfg_album as select * from gfg.gfg_album';
    execute 'create table '||v_backupschemaname||'.gfg_album_asset_map as select * from gfg.gfg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.gfg_image as select * from gfg.gfg_image';
    execute 'create table '||v_backupschemaname||'.gfg_author_action as select * from gfg.gfg_author_action';
    execute 'create table '||v_backupschemaname||'.gfg_user as select * from gfg.gfg_user';
    execute 'create table '||v_backupschemaname||'.gfg_seo_data as select * from gfg.gfg_seo_data';
    execute 'create table '||v_backupschemaname||'.gfg_topic as select * from gfg.gfg_topic';
    execute 'create table '||v_backupschemaname||'.gfg_topic_asset_map as select * from gfg.gfg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.gfg_poll as select * from gfg.gfg_poll';
    execute 'create table '||v_backupschemaname||'.gfg_poll_option as select * from gfg.gfg_poll_option';
    execute 'create table '||v_backupschemaname||'.gfg_poll_response as select * from gfg.gfg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
