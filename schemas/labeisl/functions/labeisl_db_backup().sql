-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: labeisl_db_backup()
-- Type: FUNCTION

-- Name: labeisl_db_backup(); Type: FUNCTION; Schema: labeisl; Owner: -
--

CREATE FUNCTION labeisl.labeisl_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labeisl';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labeisl_article as select * from labeisl.labeisl_article';
    execute 'create table '||v_backupschemaname||'.labeisl_article_asset_map as select * from labeisl.labeisl_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labeisl_video as select * from labeisl.labeisl_video';
    execute 'create table '||v_backupschemaname||'.labeisl_album as select * from labeisl.labeisl_album';
    execute 'create table '||v_backupschemaname||'.labeisl_album_asset_map as select * from labeisl.labeisl_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labeisl_image as select * from labeisl.labeisl_image';
    execute 'create table '||v_backupschemaname||'.labeisl_author_action as select * from labeisl.labeisl_author_action';
    execute 'create table '||v_backupschemaname||'.labeisl_user as select * from labeisl.labeisl_user';
    execute 'create table '||v_backupschemaname||'.labeisl_seo_data as select * from labeisl.labeisl_seo_data';
    execute 'create table '||v_backupschemaname||'.labeisl_topic as select * from labeisl.labeisl_topic';
    execute 'create table '||v_backupschemaname||'.labeisl_topic_asset_map as select * from labeisl.labeisl_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labeisl_poll as select * from labeisl.labeisl_poll';
    execute 'create table '||v_backupschemaname||'.labeisl_poll_option as select * from labeisl.labeisl_poll_option';
    execute 'create table '||v_backupschemaname||'.labeisl_poll_response as select * from labeisl.labeisl_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
