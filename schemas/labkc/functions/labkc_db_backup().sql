-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_db_backup()
-- Type: FUNCTION

-- Name: labkc_db_backup(); Type: FUNCTION; Schema: labkc; Owner: -
--

CREATE FUNCTION labkc.labkc_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labkc';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labkc_article as select * from labkc.labkc_article';
    execute 'create table '||v_backupschemaname||'.labkc_article_asset_map as select * from labkc.labkc_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labkc_video as select * from labkc.labkc_video';
    execute 'create table '||v_backupschemaname||'.labkc_album as select * from labkc.labkc_album';
    execute 'create table '||v_backupschemaname||'.labkc_album_asset_map as select * from labkc.labkc_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labkc_image as select * from labkc.labkc_image';
    execute 'create table '||v_backupschemaname||'.labkc_author_action as select * from labkc.labkc_author_action';
    execute 'create table '||v_backupschemaname||'.labkc_user as select * from labkc.labkc_user';
    execute 'create table '||v_backupschemaname||'.labkc_seo_data as select * from labkc.labkc_seo_data';
    execute 'create table '||v_backupschemaname||'.labkc_topic as select * from labkc.labkc_topic';
    execute 'create table '||v_backupschemaname||'.labkc_topic_asset_map as select * from labkc.labkc_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labkc_poll as select * from labkc.labkc_poll';
    execute 'create table '||v_backupschemaname||'.labkc_poll_option as select * from labkc.labkc_poll_option';
    execute 'create table '||v_backupschemaname||'.labkc_poll_response as select * from labkc.labkc_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
