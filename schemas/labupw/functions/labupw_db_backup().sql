-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_db_backup()
-- Type: FUNCTION

-- Name: labupw_db_backup(); Type: FUNCTION; Schema: labupw; Owner: -
--

CREATE FUNCTION labupw.labupw_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labupw';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labupw_article as select * from labupw.labupw_article';
    execute 'create table '||v_backupschemaname||'.labupw_article_asset_map as select * from labupw.labupw_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labupw_video as select * from labupw.labupw_video';
    execute 'create table '||v_backupschemaname||'.labupw_album as select * from labupw.labupw_album';
    execute 'create table '||v_backupschemaname||'.labupw_album_asset_map as select * from labupw.labupw_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labupw_image as select * from labupw.labupw_image';
    execute 'create table '||v_backupschemaname||'.labupw_author_action as select * from labupw.labupw_author_action';
    execute 'create table '||v_backupschemaname||'.labupw_user as select * from labupw.labupw_user';
    execute 'create table '||v_backupschemaname||'.labupw_seo_data as select * from labupw.labupw_seo_data';
    execute 'create table '||v_backupschemaname||'.labupw_topic as select * from labupw.labupw_topic';
    execute 'create table '||v_backupschemaname||'.labupw_topic_asset_map as select * from labupw.labupw_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labupw_poll as select * from labupw.labupw_poll';
    execute 'create table '||v_backupschemaname||'.labupw_poll_option as select * from labupw.labupw_poll_option';
    execute 'create table '||v_backupschemaname||'.labupw_poll_response as select * from labupw.labupw_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
