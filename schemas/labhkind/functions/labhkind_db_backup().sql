-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_db_backup()
-- Type: FUNCTION

-- Name: labhkind_db_backup(); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labhkind';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labhkind_article as select * from labhkind.labhkind_article';
    execute 'create table '||v_backupschemaname||'.labhkind_article_asset_map as select * from labhkind.labhkind_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labhkind_video as select * from labhkind.labhkind_video';
    execute 'create table '||v_backupschemaname||'.labhkind_album as select * from labhkind.labhkind_album';
    execute 'create table '||v_backupschemaname||'.labhkind_album_asset_map as select * from labhkind.labhkind_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labhkind_image as select * from labhkind.labhkind_image';
    execute 'create table '||v_backupschemaname||'.labhkind_author_action as select * from labhkind.labhkind_author_action';
    execute 'create table '||v_backupschemaname||'.labhkind_user as select * from labhkind.labhkind_user';
    execute 'create table '||v_backupschemaname||'.labhkind_seo_data as select * from labhkind.labhkind_seo_data';
    execute 'create table '||v_backupschemaname||'.labhkind_topic as select * from labhkind.labhkind_topic';
    execute 'create table '||v_backupschemaname||'.labhkind_topic_asset_map as select * from labhkind.labhkind_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labhkind_poll as select * from labhkind.labhkind_poll';
    execute 'create table '||v_backupschemaname||'.labhkind_poll_option as select * from labhkind.labhkind_poll_option';
    execute 'create table '||v_backupschemaname||'.labhkind_poll_response as select * from labhkind.labhkind_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
