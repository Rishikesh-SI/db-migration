-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_db_backup()
-- Type: FUNCTION

-- Name: labgrl_db_backup(); Type: FUNCTION; Schema: labgrl; Owner: -
--

CREATE FUNCTION labgrl.labgrl_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labgrl';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labgrl_article as select * from labgrl.labgrl_article';
    execute 'create table '||v_backupschemaname||'.labgrl_article_asset_map as select * from labgrl.labgrl_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labgrl_video as select * from labgrl.labgrl_video';
    execute 'create table '||v_backupschemaname||'.labgrl_album as select * from labgrl.labgrl_album';
    execute 'create table '||v_backupschemaname||'.labgrl_album_asset_map as select * from labgrl.labgrl_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labgrl_image as select * from labgrl.labgrl_image';
    execute 'create table '||v_backupschemaname||'.labgrl_author_action as select * from labgrl.labgrl_author_action';
    execute 'create table '||v_backupschemaname||'.labgrl_user as select * from labgrl.labgrl_user';
    execute 'create table '||v_backupschemaname||'.labgrl_seo_data as select * from labgrl.labgrl_seo_data';
    execute 'create table '||v_backupschemaname||'.labgrl_topic as select * from labgrl.labgrl_topic';
    execute 'create table '||v_backupschemaname||'.labgrl_topic_asset_map as select * from labgrl.labgrl_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labgrl_poll as select * from labgrl.labgrl_poll';
    execute 'create table '||v_backupschemaname||'.labgrl_poll_option as select * from labgrl.labgrl_poll_option';
    execute 'create table '||v_backupschemaname||'.labgrl_poll_response as select * from labgrl.labgrl_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
