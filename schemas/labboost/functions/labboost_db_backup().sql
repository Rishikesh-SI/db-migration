-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_db_backup()
-- Type: FUNCTION

-- Name: labboost_db_backup(); Type: FUNCTION; Schema: labboost; Owner: -
--

CREATE FUNCTION labboost.labboost_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labboost';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labboost_article as select * from labboost.labboost_article';
    execute 'create table '||v_backupschemaname||'.labboost_article_asset_map as select * from labboost.labboost_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labboost_video as select * from labboost.labboost_video';
    execute 'create table '||v_backupschemaname||'.labboost_album as select * from labboost.labboost_album';
    execute 'create table '||v_backupschemaname||'.labboost_album_asset_map as select * from labboost.labboost_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labboost_image as select * from labboost.labboost_image';
    execute 'create table '||v_backupschemaname||'.labboost_author_action as select * from labboost.labboost_author_action';
    execute 'create table '||v_backupschemaname||'.labboost_user as select * from labboost.labboost_user';
    execute 'create table '||v_backupschemaname||'.labboost_seo_data as select * from labboost.labboost_seo_data';
    execute 'create table '||v_backupschemaname||'.labboost_topic as select * from labboost.labboost_topic';
    execute 'create table '||v_backupschemaname||'.labboost_topic_asset_map as select * from labboost.labboost_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labboost_poll as select * from labboost.labboost_poll';
    execute 'create table '||v_backupschemaname||'.labboost_poll_option as select * from labboost.labboost_poll_option';
    execute 'create table '||v_backupschemaname||'.labboost_poll_response as select * from labboost.labboost_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
