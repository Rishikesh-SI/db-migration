-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: elms
-- Object: elms_db_backup()
-- Type: FUNCTION

-- Name: elms_db_backup(); Type: FUNCTION; Schema: elms; Owner: -
--

CREATE FUNCTION elms.elms_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'elms';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.elms_article as select * from elms.elms_article';
    execute 'create table '||v_backupschemaname||'.elms_article_asset_map as select * from elms.elms_article_asset_map';
    execute 'create table '||v_backupschemaname||'.elms_video as select * from elms.elms_video';
    execute 'create table '||v_backupschemaname||'.elms_album as select * from elms.elms_album';
    execute 'create table '||v_backupschemaname||'.elms_album_asset_map as select * from elms.elms_album_asset_map';
    execute 'create table '||v_backupschemaname||'.elms_image as select * from elms.elms_image';
    execute 'create table '||v_backupschemaname||'.elms_author_action as select * from elms.elms_author_action';
    execute 'create table '||v_backupschemaname||'.elms_user as select * from elms.elms_user';
    execute 'create table '||v_backupschemaname||'.elms_seo_data as select * from elms.elms_seo_data';
    execute 'create table '||v_backupschemaname||'.elms_topic as select * from elms.elms_topic';
    execute 'create table '||v_backupschemaname||'.elms_topic_asset_map as select * from elms.elms_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.elms_poll as select * from elms.elms_poll';
    execute 'create table '||v_backupschemaname||'.elms_poll_option as select * from elms.elms_poll_option';
    execute 'create table '||v_backupschemaname||'.elms_poll_response as select * from elms.elms_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
