-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_db_backup()
-- Type: FUNCTION

-- Name: lablsg_db_backup(); Type: FUNCTION; Schema: lablsg; Owner: -
--

CREATE FUNCTION lablsg.lablsg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'lablsg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.lablsg_article as select * from lablsg.lablsg_article';
    execute 'create table '||v_backupschemaname||'.lablsg_article_asset_map as select * from lablsg.lablsg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.lablsg_video as select * from lablsg.lablsg_video';
    execute 'create table '||v_backupschemaname||'.lablsg_album as select * from lablsg.lablsg_album';
    execute 'create table '||v_backupschemaname||'.lablsg_album_asset_map as select * from lablsg.lablsg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.lablsg_image as select * from lablsg.lablsg_image';
    execute 'create table '||v_backupschemaname||'.lablsg_author_action as select * from lablsg.lablsg_author_action';
    execute 'create table '||v_backupschemaname||'.lablsg_user as select * from lablsg.lablsg_user';
    execute 'create table '||v_backupschemaname||'.lablsg_seo_data as select * from lablsg.lablsg_seo_data';
    execute 'create table '||v_backupschemaname||'.lablsg_topic as select * from lablsg.lablsg_topic';
    execute 'create table '||v_backupschemaname||'.lablsg_topic_asset_map as select * from lablsg.lablsg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.lablsg_poll as select * from lablsg.lablsg_poll';
    execute 'create table '||v_backupschemaname||'.lablsg_poll_option as select * from lablsg.lablsg_poll_option';
    execute 'create table '||v_backupschemaname||'.lablsg_poll_response as select * from lablsg.lablsg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
