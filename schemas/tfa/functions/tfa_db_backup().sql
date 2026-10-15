-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_db_backup()
-- Type: FUNCTION

-- Name: tfa_db_backup(); Type: FUNCTION; Schema: tfa; Owner: -
--

CREATE FUNCTION tfa.tfa_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'tfa';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.tfa_article as select * from tfa.tfa_article';
    execute 'create table '||v_backupschemaname||'.tfa_article_asset_map as select * from tfa.tfa_article_asset_map';
    execute 'create table '||v_backupschemaname||'.tfa_video as select * from tfa.tfa_video';
    execute 'create table '||v_backupschemaname||'.tfa_album as select * from tfa.tfa_album';
    execute 'create table '||v_backupschemaname||'.tfa_album_asset_map as select * from tfa.tfa_album_asset_map';
    execute 'create table '||v_backupschemaname||'.tfa_image as select * from tfa.tfa_image';
    execute 'create table '||v_backupschemaname||'.tfa_author_action as select * from tfa.tfa_author_action';
    execute 'create table '||v_backupschemaname||'.tfa_user as select * from tfa.tfa_user';
    execute 'create table '||v_backupschemaname||'.tfa_seo_data as select * from tfa.tfa_seo_data';
    execute 'create table '||v_backupschemaname||'.tfa_topic as select * from tfa.tfa_topic';
    execute 'create table '||v_backupschemaname||'.tfa_topic_asset_map as select * from tfa.tfa_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.tfa_poll as select * from tfa.tfa_poll';
    execute 'create table '||v_backupschemaname||'.tfa_poll_option as select * from tfa.tfa_poll_option';
    execute 'create table '||v_backupschemaname||'.tfa_poll_response as select * from tfa.tfa_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
