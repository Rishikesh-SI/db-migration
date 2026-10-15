-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_db_backup()
-- Type: FUNCTION

-- Name: upp_db_backup(); Type: FUNCTION; Schema: upp; Owner: -
--

CREATE FUNCTION upp.upp_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'upp';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.upp_article as select * from upp.upp_article';
    execute 'create table '||v_backupschemaname||'.upp_article_asset_map as select * from upp.upp_article_asset_map';
    execute 'create table '||v_backupschemaname||'.upp_video as select * from upp.upp_video';
    execute 'create table '||v_backupschemaname||'.upp_album as select * from upp.upp_album';
    execute 'create table '||v_backupschemaname||'.upp_album_asset_map as select * from upp.upp_album_asset_map';
    execute 'create table '||v_backupschemaname||'.upp_image as select * from upp.upp_image';
    execute 'create table '||v_backupschemaname||'.upp_author_action as select * from upp.upp_author_action';
    execute 'create table '||v_backupschemaname||'.upp_user as select * from upp.upp_user';
    execute 'create table '||v_backupschemaname||'.upp_seo_data as select * from upp.upp_seo_data';
    execute 'create table '||v_backupschemaname||'.upp_topic as select * from upp.upp_topic';
    execute 'create table '||v_backupschemaname||'.upp_topic_asset_map as select * from upp.upp_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.upp_poll as select * from upp.upp_poll';
    execute 'create table '||v_backupschemaname||'.upp_poll_option as select * from upp.upp_poll_option';
    execute 'create table '||v_backupschemaname||'.upp_poll_response as select * from upp.upp_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
