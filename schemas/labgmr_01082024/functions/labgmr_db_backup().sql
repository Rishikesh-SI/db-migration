-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_db_backup()
-- Type: FUNCTION

-- Name: labgmr_db_backup(); Type: FUNCTION; Schema: labgmr_01082024; Owner: -
--

CREATE FUNCTION labgmr_01082024.labgmr_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labgmr';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labgmr_article as select * from labgmr.labgmr_article';
    execute 'create table '||v_backupschemaname||'.labgmr_article_asset_map as select * from labgmr.labgmr_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labgmr_video as select * from labgmr.labgmr_video';
    execute 'create table '||v_backupschemaname||'.labgmr_album as select * from labgmr.labgmr_album';
    execute 'create table '||v_backupschemaname||'.labgmr_album_asset_map as select * from labgmr.labgmr_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labgmr_image as select * from labgmr.labgmr_image';
    execute 'create table '||v_backupschemaname||'.labgmr_author_action as select * from labgmr.labgmr_author_action';
    execute 'create table '||v_backupschemaname||'.labgmr_user as select * from labgmr.labgmr_user';
    execute 'create table '||v_backupschemaname||'.labgmr_seo_data as select * from labgmr.labgmr_seo_data';
    execute 'create table '||v_backupschemaname||'.labgmr_topic as select * from labgmr.labgmr_topic';
    execute 'create table '||v_backupschemaname||'.labgmr_topic_asset_map as select * from labgmr.labgmr_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labgmr_poll as select * from labgmr.labgmr_poll';
    execute 'create table '||v_backupschemaname||'.labgmr_poll_option as select * from labgmr.labgmr_poll_option';
    execute 'create table '||v_backupschemaname||'.labgmr_poll_response as select * from labgmr.labgmr_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
