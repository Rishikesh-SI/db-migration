-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_db_backup()
-- Type: FUNCTION

-- Name: labetpl_db_backup(); Type: FUNCTION; Schema: labetpl; Owner: -
--

CREATE FUNCTION labetpl.labetpl_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labetpl';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labetpl_article as select * from labetpl.labetpl_article';
    execute 'create table '||v_backupschemaname||'.labetpl_article_asset_map as select * from labetpl.labetpl_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labetpl_video as select * from labetpl.labetpl_video';
    execute 'create table '||v_backupschemaname||'.labetpl_album as select * from labetpl.labetpl_album';
    execute 'create table '||v_backupschemaname||'.labetpl_album_asset_map as select * from labetpl.labetpl_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labetpl_image as select * from labetpl.labetpl_image';
    execute 'create table '||v_backupschemaname||'.labetpl_author_action as select * from labetpl.labetpl_author_action';
    execute 'create table '||v_backupschemaname||'.labetpl_user as select * from labetpl.labetpl_user';
    execute 'create table '||v_backupschemaname||'.labetpl_seo_data as select * from labetpl.labetpl_seo_data';
    execute 'create table '||v_backupschemaname||'.labetpl_topic as select * from labetpl.labetpl_topic';
    execute 'create table '||v_backupschemaname||'.labetpl_topic_asset_map as select * from labetpl.labetpl_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labetpl_poll as select * from labetpl.labetpl_poll';
    execute 'create table '||v_backupschemaname||'.labetpl_poll_option as select * from labetpl.labetpl_poll_option';
    execute 'create table '||v_backupschemaname||'.labetpl_poll_response as select * from labetpl.labetpl_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
