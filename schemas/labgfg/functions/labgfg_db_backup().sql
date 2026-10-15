-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_db_backup()
-- Type: FUNCTION

-- Name: labgfg_db_backup(); Type: FUNCTION; Schema: labgfg; Owner: -
--

CREATE FUNCTION labgfg.labgfg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labgfg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labgfg_article as select * from labgfg.labgfg_article';
    execute 'create table '||v_backupschemaname||'.labgfg_article_asset_map as select * from labgfg.labgfg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labgfg_video as select * from labgfg.labgfg_video';
    execute 'create table '||v_backupschemaname||'.labgfg_album as select * from labgfg.labgfg_album';
    execute 'create table '||v_backupschemaname||'.labgfg_album_asset_map as select * from labgfg.labgfg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labgfg_image as select * from labgfg.labgfg_image';
    execute 'create table '||v_backupschemaname||'.labgfg_author_action as select * from labgfg.labgfg_author_action';
    execute 'create table '||v_backupschemaname||'.labgfg_user as select * from labgfg.labgfg_user';
    execute 'create table '||v_backupschemaname||'.labgfg_seo_data as select * from labgfg.labgfg_seo_data';
    execute 'create table '||v_backupschemaname||'.labgfg_topic as select * from labgfg.labgfg_topic';
    execute 'create table '||v_backupschemaname||'.labgfg_topic_asset_map as select * from labgfg.labgfg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labgfg_poll as select * from labgfg.labgfg_poll';
    execute 'create table '||v_backupschemaname||'.labgfg_poll_option as select * from labgfg.labgfg_poll_option';
    execute 'create table '||v_backupschemaname||'.labgfg_poll_response as select * from labgfg.labgfg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
