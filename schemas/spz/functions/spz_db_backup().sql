-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_db_backup()
-- Type: FUNCTION

-- Name: spz_db_backup(); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'spz';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.spz_article as select * from spz.spz_article';
    execute 'create table '||v_backupschemaname||'.spz_article_asset_map as select * from spz.spz_article_asset_map';
    execute 'create table '||v_backupschemaname||'.spz_video as select * from spz.spz_video';
    execute 'create table '||v_backupschemaname||'.spz_album as select * from spz.spz_album';
    execute 'create table '||v_backupschemaname||'.spz_album_asset_map as select * from spz.spz_album_asset_map';
    execute 'create table '||v_backupschemaname||'.spz_image as select * from spz.spz_image';
    execute 'create table '||v_backupschemaname||'.spz_author_action as select * from spz.spz_author_action';
    execute 'create table '||v_backupschemaname||'.spz_user as select * from spz.spz_user';
    execute 'create table '||v_backupschemaname||'.spz_seo_data as select * from spz.spz_seo_data';
    execute 'create table '||v_backupschemaname||'.spz_topic as select * from spz.spz_topic';
    execute 'create table '||v_backupschemaname||'.spz_topic_asset_map as select * from spz.spz_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.spz_poll as select * from spz.spz_poll';
    execute 'create table '||v_backupschemaname||'.spz_poll_option as select * from spz.spz_poll_option';
    execute 'create table '||v_backupschemaname||'.spz_poll_response as select * from spz.spz_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
