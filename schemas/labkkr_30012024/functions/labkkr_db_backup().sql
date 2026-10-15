-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_db_backup()
-- Type: FUNCTION

-- Name: labkkr_db_backup(); Type: FUNCTION; Schema: labkkr_30012024; Owner: -
--

CREATE FUNCTION labkkr_30012024.labkkr_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labkkr';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labkkr_article as select * from labkkr.labkkr_article';
    execute 'create table '||v_backupschemaname||'.labkkr_article_asset_map as select * from labkkr.labkkr_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labkkr_video as select * from labkkr.labkkr_video';
    execute 'create table '||v_backupschemaname||'.labkkr_album as select * from labkkr.labkkr_album';
    execute 'create table '||v_backupschemaname||'.labkkr_album_asset_map as select * from labkkr.labkkr_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labkkr_image as select * from labkkr.labkkr_image';
    execute 'create table '||v_backupschemaname||'.labkkr_author_action as select * from labkkr.labkkr_author_action';
    execute 'create table '||v_backupschemaname||'.labkkr_user as select * from labkkr.labkkr_user';
    execute 'create table '||v_backupschemaname||'.labkkr_seo_data as select * from labkkr.labkkr_seo_data';
    execute 'create table '||v_backupschemaname||'.labkkr_topic as select * from labkkr.labkkr_topic';
    execute 'create table '||v_backupschemaname||'.labkkr_topic_asset_map as select * from labkkr.labkkr_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labkkr_poll as select * from labkkr.labkkr_poll';
    execute 'create table '||v_backupschemaname||'.labkkr_poll_option as select * from labkkr.labkkr_poll_option';
    execute 'create table '||v_backupschemaname||'.labkkr_poll_response as select * from labkkr.labkkr_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
