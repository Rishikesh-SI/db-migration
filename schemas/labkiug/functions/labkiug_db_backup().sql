-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiug
-- Object: labkiug_db_backup()
-- Type: FUNCTION

-- Name: labkiug_db_backup(); Type: FUNCTION; Schema: labkiug; Owner: -
--

CREATE FUNCTION labkiug.labkiug_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labkiug';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labkiug_article as select * from labkiug.labkiug_article';
    execute 'create table '||v_backupschemaname||'.labkiug_article_asset_map as select * from labkiug.labkiug_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labkiug_video as select * from labkiug.labkiug_video';
    execute 'create table '||v_backupschemaname||'.labkiug_album as select * from labkiug.labkiug_album';
    execute 'create table '||v_backupschemaname||'.labkiug_album_asset_map as select * from labkiug.labkiug_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labkiug_image as select * from labkiug.labkiug_image';
    execute 'create table '||v_backupschemaname||'.labkiug_author_action as select * from labkiug.labkiug_author_action';
    execute 'create table '||v_backupschemaname||'.labkiug_user as select * from labkiug.labkiug_user';
    execute 'create table '||v_backupschemaname||'.labkiug_seo_data as select * from labkiug.labkiug_seo_data';
    execute 'create table '||v_backupschemaname||'.labkiug_topic as select * from labkiug.labkiug_topic';
    execute 'create table '||v_backupschemaname||'.labkiug_topic_asset_map as select * from labkiug.labkiug_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labkiug_poll as select * from labkiug.labkiug_poll';
    execute 'create table '||v_backupschemaname||'.labkiug_poll_option as select * from labkiug.labkiug_poll_option';
    execute 'create table '||v_backupschemaname||'.labkiug_poll_response as select * from labkiug.labkiug_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
