-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_db_backup()
-- Type: FUNCTION

-- Name: labsm_db_backup(); Type: FUNCTION; Schema: labsm; Owner: -
--

CREATE FUNCTION labsm.labsm_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labsm';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labsm_article as select * from labsm.labsm_article';
    execute 'create table '||v_backupschemaname||'.labsm_article_asset_map as select * from labsm.labsm_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labsm_video as select * from labsm.labsm_video';
    execute 'create table '||v_backupschemaname||'.labsm_album as select * from labsm.labsm_album';
    execute 'create table '||v_backupschemaname||'.labsm_album_asset_map as select * from labsm.labsm_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labsm_image as select * from labsm.labsm_image';
    execute 'create table '||v_backupschemaname||'.labsm_author_action as select * from labsm.labsm_author_action';
    execute 'create table '||v_backupschemaname||'.labsm_user as select * from labsm.labsm_user';
    execute 'create table '||v_backupschemaname||'.labsm_seo_data as select * from labsm.labsm_seo_data';
    execute 'create table '||v_backupschemaname||'.labsm_topic as select * from labsm.labsm_topic';
    execute 'create table '||v_backupschemaname||'.labsm_topic_asset_map as select * from labsm.labsm_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labsm_poll as select * from labsm.labsm_poll';
    execute 'create table '||v_backupschemaname||'.labsm_poll_option as select * from labsm.labsm_poll_option';
    execute 'create table '||v_backupschemaname||'.labsm_poll_response as select * from labsm.labsm_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
