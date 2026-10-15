-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_db_backup()
-- Type: FUNCTION

-- Name: labdms_db_backup(); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labdms';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labdms_article as select * from labdms.labdms_article';
    execute 'create table '||v_backupschemaname||'.labdms_article_asset_map as select * from labdms.labdms_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labdms_video as select * from labdms.labdms_video';
    execute 'create table '||v_backupschemaname||'.labdms_album as select * from labdms.labdms_album';
    execute 'create table '||v_backupschemaname||'.labdms_album_asset_map as select * from labdms.labdms_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labdms_image as select * from labdms.labdms_image';
    execute 'create table '||v_backupschemaname||'.labdms_author_action as select * from labdms.labdms_author_action';
    execute 'create table '||v_backupschemaname||'.labdms_user as select * from labdms.labdms_user';
    execute 'create table '||v_backupschemaname||'.labdms_seo_data as select * from labdms.labdms_seo_data';
    execute 'create table '||v_backupschemaname||'.labdms_topic as select * from labdms.labdms_topic';
    execute 'create table '||v_backupschemaname||'.labdms_topic_asset_map as select * from labdms.labdms_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labdms_poll as select * from labdms.labdms_poll';
    execute 'create table '||v_backupschemaname||'.labdms_poll_option as select * from labdms.labdms_poll_option';
    execute 'create table '||v_backupschemaname||'.labdms_poll_response as select * from labdms.labdms_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
