-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_db_backup()
-- Type: FUNCTION

-- Name: labman_db_backup(); Type: FUNCTION; Schema: labman; Owner: -
--

CREATE FUNCTION labman.labman_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labman';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labman_article as select * from labman.labman_article';
    execute 'create table '||v_backupschemaname||'.labman_article_asset_map as select * from labman.labman_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labman_video as select * from labman.labman_video';
    execute 'create table '||v_backupschemaname||'.labman_album as select * from labman.labman_album';
    execute 'create table '||v_backupschemaname||'.labman_album_asset_map as select * from labman.labman_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labman_image as select * from labman.labman_image';
    execute 'create table '||v_backupschemaname||'.labman_author_action as select * from labman.labman_author_action';
    execute 'create table '||v_backupschemaname||'.labman_user as select * from labman.labman_user';
    execute 'create table '||v_backupschemaname||'.labman_seo_data as select * from labman.labman_seo_data';
    execute 'create table '||v_backupschemaname||'.labman_topic as select * from labman.labman_topic';
    execute 'create table '||v_backupschemaname||'.labman_topic_asset_map as select * from labman.labman_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labman_poll as select * from labman.labman_poll';
    execute 'create table '||v_backupschemaname||'.labman_poll_option as select * from labman.labman_poll_option';
    execute 'create table '||v_backupschemaname||'.labman_poll_response as select * from labman.labman_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
