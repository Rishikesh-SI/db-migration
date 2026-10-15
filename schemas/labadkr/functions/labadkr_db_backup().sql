-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_db_backup()
-- Type: FUNCTION

-- Name: labadkr_db_backup(); Type: FUNCTION; Schema: labadkr; Owner: -
--

CREATE FUNCTION labadkr.labadkr_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labadkr';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labadkr_article as select * from labadkr.labadkr_article';
    execute 'create table '||v_backupschemaname||'.labadkr_article_asset_map as select * from labadkr.labadkr_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labadkr_video as select * from labadkr.labadkr_video';
    execute 'create table '||v_backupschemaname||'.labadkr_album as select * from labadkr.labadkr_album';
    execute 'create table '||v_backupschemaname||'.labadkr_album_asset_map as select * from labadkr.labadkr_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labadkr_image as select * from labadkr.labadkr_image';
    execute 'create table '||v_backupschemaname||'.labadkr_author_action as select * from labadkr.labadkr_author_action';
    execute 'create table '||v_backupschemaname||'.labadkr_user as select * from labadkr.labadkr_user';
    execute 'create table '||v_backupschemaname||'.labadkr_seo_data as select * from labadkr.labadkr_seo_data';
    execute 'create table '||v_backupschemaname||'.labadkr_topic as select * from labadkr.labadkr_topic';
    execute 'create table '||v_backupschemaname||'.labadkr_topic_asset_map as select * from labadkr.labadkr_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labadkr_poll as select * from labadkr.labadkr_poll';
    execute 'create table '||v_backupschemaname||'.labadkr_poll_option as select * from labadkr.labadkr_poll_option';
    execute 'create table '||v_backupschemaname||'.labadkr_poll_response as select * from labadkr.labadkr_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
