-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_db_backup()
-- Type: FUNCTION

-- Name: labkxip_db_backup(); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labkxip';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labkxip_article as select * from labkxip.labkxip_article';
    execute 'create table '||v_backupschemaname||'.labkxip_article_asset_map as select * from labkxip.labkxip_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labkxip_video as select * from labkxip.labkxip_video';
    execute 'create table '||v_backupschemaname||'.labkxip_album as select * from labkxip.labkxip_album';
    execute 'create table '||v_backupschemaname||'.labkxip_album_asset_map as select * from labkxip.labkxip_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labkxip_image as select * from labkxip.labkxip_image';
    execute 'create table '||v_backupschemaname||'.labkxip_author_action as select * from labkxip.labkxip_author_action';
    execute 'create table '||v_backupschemaname||'.labkxip_user as select * from labkxip.labkxip_user';
    execute 'create table '||v_backupschemaname||'.labkxip_seo_data as select * from labkxip.labkxip_seo_data';
    execute 'create table '||v_backupschemaname||'.labkxip_topic as select * from labkxip.labkxip_topic';
    execute 'create table '||v_backupschemaname||'.labkxip_topic_asset_map as select * from labkxip.labkxip_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labkxip_poll as select * from labkxip.labkxip_poll';
    execute 'create table '||v_backupschemaname||'.labkxip_poll_option as select * from labkxip.labkxip_poll_option';
    execute 'create table '||v_backupschemaname||'.labkxip_poll_response as select * from labkxip.labkxip_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
