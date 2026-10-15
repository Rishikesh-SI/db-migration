-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_db_backup()
-- Type: FUNCTION

-- Name: labfg_db_backup(); Type: FUNCTION; Schema: labfg; Owner: -
--

CREATE FUNCTION labfg.labfg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labfg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labfg_article as select * from labfg.labfg_article';
    execute 'create table '||v_backupschemaname||'.labfg_article_asset_map as select * from labfg.labfg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labfg_video as select * from labfg.labfg_video';
    execute 'create table '||v_backupschemaname||'.labfg_album as select * from labfg.labfg_album';
    execute 'create table '||v_backupschemaname||'.labfg_album_asset_map as select * from labfg.labfg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labfg_image as select * from labfg.labfg_image';
    execute 'create table '||v_backupschemaname||'.labfg_author_action as select * from labfg.labfg_author_action';
    execute 'create table '||v_backupschemaname||'.labfg_user as select * from labfg.labfg_user';
    execute 'create table '||v_backupschemaname||'.labfg_seo_data as select * from labfg.labfg_seo_data';
    execute 'create table '||v_backupschemaname||'.labfg_topic as select * from labfg.labfg_topic';
    execute 'create table '||v_backupschemaname||'.labfg_topic_asset_map as select * from labfg.labfg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labfg_poll as select * from labfg.labfg_poll';
    execute 'create table '||v_backupschemaname||'.labfg_poll_option as select * from labfg.labfg_poll_option';
    execute 'create table '||v_backupschemaname||'.labfg_poll_response as select * from labfg.labfg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
