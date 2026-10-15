-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_db_backup()
-- Type: FUNCTION

-- Name: upstox_db_backup(); Type: FUNCTION; Schema: upstox; Owner: -
--

CREATE FUNCTION upstox.upstox_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'upstox';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.upstox_article as select * from upstox.upstox_article';
    execute 'create table '||v_backupschemaname||'.upstox_article_asset_map as select * from upstox.upstox_article_asset_map';
    execute 'create table '||v_backupschemaname||'.upstox_video as select * from upstox.upstox_video';
    execute 'create table '||v_backupschemaname||'.upstox_album as select * from upstox.upstox_album';
    execute 'create table '||v_backupschemaname||'.upstox_album_asset_map as select * from upstox.upstox_album_asset_map';
    execute 'create table '||v_backupschemaname||'.upstox_image as select * from upstox.upstox_image';
    execute 'create table '||v_backupschemaname||'.upstox_author_action as select * from upstox.upstox_author_action';
    execute 'create table '||v_backupschemaname||'.upstox_user as select * from upstox.upstox_user';
    execute 'create table '||v_backupschemaname||'.upstox_seo_data as select * from upstox.upstox_seo_data';
    execute 'create table '||v_backupschemaname||'.upstox_topic as select * from upstox.upstox_topic';
    execute 'create table '||v_backupschemaname||'.upstox_topic_asset_map as select * from upstox.upstox_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.upstox_poll as select * from upstox.upstox_poll';
    execute 'create table '||v_backupschemaname||'.upstox_poll_option as select * from upstox.upstox_poll_option';
    execute 'create table '||v_backupschemaname||'.upstox_poll_response as select * from upstox.upstox_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
