-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_db_backup()
-- Type: FUNCTION

-- Name: upy_db_backup(); Type: FUNCTION; Schema: upy; Owner: -
--

CREATE FUNCTION upy.upy_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'upy';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.upy_article as select * from upy.upy_article';
    execute 'create table '||v_backupschemaname||'.upy_article_asset_map as select * from upy.upy_article_asset_map';
    execute 'create table '||v_backupschemaname||'.upy_video as select * from upy.upy_video';
    execute 'create table '||v_backupschemaname||'.upy_album as select * from upy.upy_album';
    execute 'create table '||v_backupschemaname||'.upy_album_asset_map as select * from upy.upy_album_asset_map';
    execute 'create table '||v_backupschemaname||'.upy_image as select * from upy.upy_image';
    execute 'create table '||v_backupschemaname||'.upy_author_action as select * from upy.upy_author_action';
    execute 'create table '||v_backupschemaname||'.upy_user as select * from upy.upy_user';
    execute 'create table '||v_backupschemaname||'.upy_seo_data as select * from upy.upy_seo_data';
    execute 'create table '||v_backupschemaname||'.upy_topic as select * from upy.upy_topic';
    execute 'create table '||v_backupschemaname||'.upy_topic_asset_map as select * from upy.upy_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.upy_poll as select * from upy.upy_poll';
    execute 'create table '||v_backupschemaname||'.upy_poll_option as select * from upy.upy_poll_option';
    execute 'create table '||v_backupschemaname||'.upy_poll_response as select * from upy.upy_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
