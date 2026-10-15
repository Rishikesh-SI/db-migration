-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_db_backup()
-- Type: FUNCTION

-- Name: labjdtest_db_backup(); Type: FUNCTION; Schema: labjdtest; Owner: -
--

CREATE FUNCTION labjdtest.labjdtest_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labJDTEST';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labJDTEST_article as select * from labJDTEST.labJDTEST_article';
    execute 'create table '||v_backupschemaname||'.labJDTEST_article_asset_map as select * from labJDTEST.labJDTEST_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labJDTEST_video as select * from labJDTEST.labJDTEST_video';
    execute 'create table '||v_backupschemaname||'.labJDTEST_album as select * from labJDTEST.labJDTEST_album';
    execute 'create table '||v_backupschemaname||'.labJDTEST_album_asset_map as select * from labJDTEST.labJDTEST_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labJDTEST_image as select * from labJDTEST.labJDTEST_image';
    execute 'create table '||v_backupschemaname||'.labJDTEST_author_action as select * from labJDTEST.labJDTEST_author_action';
    execute 'create table '||v_backupschemaname||'.labJDTEST_user as select * from labJDTEST.labJDTEST_user';
    execute 'create table '||v_backupschemaname||'.labJDTEST_seo_data as select * from labJDTEST.labJDTEST_seo_data';
    execute 'create table '||v_backupschemaname||'.labJDTEST_topic as select * from labJDTEST.labJDTEST_topic';
    execute 'create table '||v_backupschemaname||'.labJDTEST_topic_asset_map as select * from labJDTEST.labJDTEST_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labJDTEST_poll as select * from labJDTEST.labJDTEST_poll';
    execute 'create table '||v_backupschemaname||'.labJDTEST_poll_option as select * from labJDTEST.labJDTEST_poll_option';
    execute 'create table '||v_backupschemaname||'.labJDTEST_poll_response as select * from labJDTEST.labJDTEST_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
