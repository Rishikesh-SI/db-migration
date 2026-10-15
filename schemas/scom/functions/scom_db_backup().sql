-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_db_backup()
-- Type: FUNCTION

-- Name: scom_db_backup(); Type: FUNCTION; Schema: scom; Owner: -
--

CREATE FUNCTION scom.scom_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'scom';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.scom_article as select * from scom.scom_article';
    execute 'create table '||v_backupschemaname||'.scom_article_asset_map as select * from scom.scom_article_asset_map';
    execute 'create table '||v_backupschemaname||'.scom_video as select * from scom.scom_video';
    execute 'create table '||v_backupschemaname||'.scom_album as select * from scom.scom_album';
    execute 'create table '||v_backupschemaname||'.scom_album_asset_map as select * from scom.scom_album_asset_map';
    execute 'create table '||v_backupschemaname||'.scom_image as select * from scom.scom_image';
    execute 'create table '||v_backupschemaname||'.scom_author_action as select * from scom.scom_author_action';
    execute 'create table '||v_backupschemaname||'.scom_user as select * from scom.scom_user';
    execute 'create table '||v_backupschemaname||'.scom_seo_data as select * from scom.scom_seo_data';
    execute 'create table '||v_backupschemaname||'.scom_topic as select * from scom.scom_topic';
    execute 'create table '||v_backupschemaname||'.scom_topic_asset_map as select * from scom.scom_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.scom_poll as select * from scom.scom_poll';
    execute 'create table '||v_backupschemaname||'.scom_poll_option as select * from scom.scom_poll_option';
    execute 'create table '||v_backupschemaname||'.scom_poll_response as select * from scom.scom_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
