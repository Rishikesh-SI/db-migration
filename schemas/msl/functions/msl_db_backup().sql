-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_db_backup()
-- Type: FUNCTION

-- Name: msl_db_backup(); Type: FUNCTION; Schema: msl; Owner: -
--

CREATE FUNCTION msl.msl_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'msl';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.msl_article as select * from msl.msl_article';
    execute 'create table '||v_backupschemaname||'.msl_article_asset_map as select * from msl.msl_article_asset_map';
    execute 'create table '||v_backupschemaname||'.msl_video as select * from msl.msl_video';
    execute 'create table '||v_backupschemaname||'.msl_album as select * from msl.msl_album';
    execute 'create table '||v_backupschemaname||'.msl_album_asset_map as select * from msl.msl_album_asset_map';
    execute 'create table '||v_backupschemaname||'.msl_image as select * from msl.msl_image';
    execute 'create table '||v_backupschemaname||'.msl_author_action as select * from msl.msl_author_action';
    execute 'create table '||v_backupschemaname||'.msl_user as select * from msl.msl_user';
    execute 'create table '||v_backupschemaname||'.msl_seo_data as select * from msl.msl_seo_data';
    execute 'create table '||v_backupschemaname||'.msl_topic as select * from msl.msl_topic';
    execute 'create table '||v_backupschemaname||'.msl_topic_asset_map as select * from msl.msl_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.msl_poll as select * from msl.msl_poll';
    execute 'create table '||v_backupschemaname||'.msl_poll_option as select * from msl.msl_poll_option';
    execute 'create table '||v_backupschemaname||'.msl_poll_response as select * from msl.msl_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
