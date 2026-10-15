-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: labkiyg_db_backup()
-- Type: FUNCTION

-- Name: labkiyg_db_backup(); Type: FUNCTION; Schema: labkiyg; Owner: -
--

CREATE FUNCTION labkiyg.labkiyg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labkiyg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labkiyg_article as select * from labkiyg.labkiyg_article';
    execute 'create table '||v_backupschemaname||'.labkiyg_article_asset_map as select * from labkiyg.labkiyg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labkiyg_video as select * from labkiyg.labkiyg_video';
    execute 'create table '||v_backupschemaname||'.labkiyg_album as select * from labkiyg.labkiyg_album';
    execute 'create table '||v_backupschemaname||'.labkiyg_album_asset_map as select * from labkiyg.labkiyg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labkiyg_image as select * from labkiyg.labkiyg_image';
    execute 'create table '||v_backupschemaname||'.labkiyg_author_action as select * from labkiyg.labkiyg_author_action';
    execute 'create table '||v_backupschemaname||'.labkiyg_user as select * from labkiyg.labkiyg_user';
    execute 'create table '||v_backupschemaname||'.labkiyg_seo_data as select * from labkiyg.labkiyg_seo_data';
    execute 'create table '||v_backupschemaname||'.labkiyg_topic as select * from labkiyg.labkiyg_topic';
    execute 'create table '||v_backupschemaname||'.labkiyg_topic_asset_map as select * from labkiyg.labkiyg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labkiyg_poll as select * from labkiyg.labkiyg_poll';
    execute 'create table '||v_backupschemaname||'.labkiyg_poll_option as select * from labkiyg.labkiyg_poll_option';
    execute 'create table '||v_backupschemaname||'.labkiyg_poll_response as select * from labkiyg.labkiyg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
