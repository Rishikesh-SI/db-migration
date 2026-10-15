-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_db_backup()
-- Type: FUNCTION

-- Name: rfg_db_backup(); Type: FUNCTION; Schema: rfg; Owner: -
--

CREATE FUNCTION rfg.rfg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'rfg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.rfg_article as select * from rfg.rfg_article';
    execute 'create table '||v_backupschemaname||'.rfg_article_asset_map as select * from rfg.rfg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.rfg_video as select * from rfg.rfg_video';
    execute 'create table '||v_backupschemaname||'.rfg_album as select * from rfg.rfg_album';
    execute 'create table '||v_backupschemaname||'.rfg_album_asset_map as select * from rfg.rfg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.rfg_image as select * from rfg.rfg_image';
    execute 'create table '||v_backupschemaname||'.rfg_author_action as select * from rfg.rfg_author_action';
    execute 'create table '||v_backupschemaname||'.rfg_user as select * from rfg.rfg_user';
    execute 'create table '||v_backupschemaname||'.rfg_seo_data as select * from rfg.rfg_seo_data';
    execute 'create table '||v_backupschemaname||'.rfg_topic as select * from rfg.rfg_topic';
    execute 'create table '||v_backupschemaname||'.rfg_topic_asset_map as select * from rfg.rfg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.rfg_poll as select * from rfg.rfg_poll';
    execute 'create table '||v_backupschemaname||'.rfg_poll_option as select * from rfg.rfg_poll_option';
    execute 'create table '||v_backupschemaname||'.rfg_poll_response as select * from rfg.rfg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
