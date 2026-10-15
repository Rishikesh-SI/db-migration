-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_db_backup()
-- Type: FUNCTION

-- Name: labupstox_db_backup(); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labupstox';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labupstox_article as select * from labupstox.labupstox_article';
    execute 'create table '||v_backupschemaname||'.labupstox_article_asset_map as select * from labupstox.labupstox_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labupstox_video as select * from labupstox.labupstox_video';
    execute 'create table '||v_backupschemaname||'.labupstox_album as select * from labupstox.labupstox_album';
    execute 'create table '||v_backupschemaname||'.labupstox_album_asset_map as select * from labupstox.labupstox_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labupstox_image as select * from labupstox.labupstox_image';
    execute 'create table '||v_backupschemaname||'.labupstox_author_action as select * from labupstox.labupstox_author_action';
    execute 'create table '||v_backupschemaname||'.labupstox_user as select * from labupstox.labupstox_user';
    execute 'create table '||v_backupschemaname||'.labupstox_seo_data as select * from labupstox.labupstox_seo_data';
    execute 'create table '||v_backupschemaname||'.labupstox_topic as select * from labupstox.labupstox_topic';
    execute 'create table '||v_backupschemaname||'.labupstox_topic_asset_map as select * from labupstox.labupstox_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labupstox_poll as select * from labupstox.labupstox_poll';
    execute 'create table '||v_backupschemaname||'.labupstox_poll_option as select * from labupstox.labupstox_poll_option';
    execute 'create table '||v_backupschemaname||'.labupstox_poll_response as select * from labupstox.labupstox_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
