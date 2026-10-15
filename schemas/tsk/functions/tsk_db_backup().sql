-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_db_backup()
-- Type: FUNCTION

-- Name: tsk_db_backup(); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'tsk';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.tsk_article as select * from tsk.tsk_article';
    execute 'create table '||v_backupschemaname||'.tsk_article_asset_map as select * from tsk.tsk_article_asset_map';
    execute 'create table '||v_backupschemaname||'.tsk_video as select * from tsk.tsk_video';
    execute 'create table '||v_backupschemaname||'.tsk_album as select * from tsk.tsk_album';
    execute 'create table '||v_backupschemaname||'.tsk_album_asset_map as select * from tsk.tsk_album_asset_map';
    execute 'create table '||v_backupschemaname||'.tsk_image as select * from tsk.tsk_image';
    execute 'create table '||v_backupschemaname||'.tsk_author_action as select * from tsk.tsk_author_action';
    execute 'create table '||v_backupschemaname||'.tsk_user as select * from tsk.tsk_user';
    execute 'create table '||v_backupschemaname||'.tsk_seo_data as select * from tsk.tsk_seo_data';
    execute 'create table '||v_backupschemaname||'.tsk_topic as select * from tsk.tsk_topic';
    execute 'create table '||v_backupschemaname||'.tsk_topic_asset_map as select * from tsk.tsk_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.tsk_poll as select * from tsk.tsk_poll';
    execute 'create table '||v_backupschemaname||'.tsk_poll_option as select * from tsk.tsk_poll_option';
    execute 'create table '||v_backupschemaname||'.tsk_poll_response as select * from tsk.tsk_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
