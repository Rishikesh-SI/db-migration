-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_db_backup()
-- Type: FUNCTION

-- Name: labrs_db_backup(); Type: FUNCTION; Schema: labrs_2602; Owner: -
--

CREATE FUNCTION labrs_2602.labrs_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labrs';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labrs_article as select * from labrs.labrs_article';
    execute 'create table '||v_backupschemaname||'.labrs_article_asset_map as select * from labrs.labrs_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labrs_video as select * from labrs.labrs_video';
    execute 'create table '||v_backupschemaname||'.labrs_album as select * from labrs.labrs_album';
    execute 'create table '||v_backupschemaname||'.labrs_album_asset_map as select * from labrs.labrs_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labrs_image as select * from labrs.labrs_image';
    execute 'create table '||v_backupschemaname||'.labrs_author_action as select * from labrs.labrs_author_action';
    execute 'create table '||v_backupschemaname||'.labrs_user as select * from labrs.labrs_user';
    execute 'create table '||v_backupschemaname||'.labrs_seo_data as select * from labrs.labrs_seo_data';
    execute 'create table '||v_backupschemaname||'.labrs_topic as select * from labrs.labrs_topic';
    execute 'create table '||v_backupschemaname||'.labrs_topic_asset_map as select * from labrs.labrs_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labrs_poll as select * from labrs.labrs_poll';
    execute 'create table '||v_backupschemaname||'.labrs_poll_option as select * from labrs.labrs_poll_option';
    execute 'create table '||v_backupschemaname||'.labrs_poll_response as select * from labrs.labrs_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
