-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_db_backup()
-- Type: FUNCTION

-- Name: labhsl_db_backup(); Type: FUNCTION; Schema: labhsl; Owner: -
--

CREATE FUNCTION labhsl.labhsl_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labhsl';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labhsl_article as select * from labhsl.labhsl_article';
    execute 'create table '||v_backupschemaname||'.labhsl_article_asset_map as select * from labhsl.labhsl_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labhsl_video as select * from labhsl.labhsl_video';
    execute 'create table '||v_backupschemaname||'.labhsl_album as select * from labhsl.labhsl_album';
    execute 'create table '||v_backupschemaname||'.labhsl_album_asset_map as select * from labhsl.labhsl_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labhsl_image as select * from labhsl.labhsl_image';
    execute 'create table '||v_backupschemaname||'.labhsl_author_action as select * from labhsl.labhsl_author_action';
    execute 'create table '||v_backupschemaname||'.labhsl_user as select * from labhsl.labhsl_user';
    execute 'create table '||v_backupschemaname||'.labhsl_seo_data as select * from labhsl.labhsl_seo_data';
    execute 'create table '||v_backupschemaname||'.labhsl_topic as select * from labhsl.labhsl_topic';
    execute 'create table '||v_backupschemaname||'.labhsl_topic_asset_map as select * from labhsl.labhsl_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labhsl_poll as select * from labhsl.labhsl_poll';
    execute 'create table '||v_backupschemaname||'.labhsl_poll_option as select * from labhsl.labhsl_poll_option';
    execute 'create table '||v_backupschemaname||'.labhsl_poll_response as select * from labhsl.labhsl_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
