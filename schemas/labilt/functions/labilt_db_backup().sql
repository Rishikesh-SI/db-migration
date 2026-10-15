-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_db_backup()
-- Type: FUNCTION

-- Name: labilt_db_backup(); Type: FUNCTION; Schema: labilt; Owner: -
--

CREATE FUNCTION labilt.labilt_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labilt';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labilt_article as select * from labilt.labilt_article';
    execute 'create table '||v_backupschemaname||'.labilt_article_asset_map as select * from labilt.labilt_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labilt_video as select * from labilt.labilt_video';
    execute 'create table '||v_backupschemaname||'.labilt_album as select * from labilt.labilt_album';
    execute 'create table '||v_backupschemaname||'.labilt_album_asset_map as select * from labilt.labilt_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labilt_image as select * from labilt.labilt_image';
    execute 'create table '||v_backupschemaname||'.labilt_author_action as select * from labilt.labilt_author_action';
    execute 'create table '||v_backupschemaname||'.labilt_user as select * from labilt.labilt_user';
    execute 'create table '||v_backupschemaname||'.labilt_seo_data as select * from labilt.labilt_seo_data';
    execute 'create table '||v_backupschemaname||'.labilt_topic as select * from labilt.labilt_topic';
    execute 'create table '||v_backupschemaname||'.labilt_topic_asset_map as select * from labilt.labilt_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labilt_poll as select * from labilt.labilt_poll';
    execute 'create table '||v_backupschemaname||'.labilt_poll_option as select * from labilt.labilt_poll_option';
    execute 'create table '||v_backupschemaname||'.labilt_poll_response as select * from labilt.labilt_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
