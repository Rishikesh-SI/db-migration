-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_db_backup()
-- Type: FUNCTION

-- Name: labsrk_db_backup(); Type: FUNCTION; Schema: labsrk; Owner: -
--

CREATE FUNCTION labsrk.labsrk_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labsrk';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labsrk_article as select * from labsrk.labsrk_article';
    execute 'create table '||v_backupschemaname||'.labsrk_article_asset_map as select * from labsrk.labsrk_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labsrk_video as select * from labsrk.labsrk_video';
    execute 'create table '||v_backupschemaname||'.labsrk_album as select * from labsrk.labsrk_album';
    execute 'create table '||v_backupschemaname||'.labsrk_album_asset_map as select * from labsrk.labsrk_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labsrk_image as select * from labsrk.labsrk_image';
    execute 'create table '||v_backupschemaname||'.labsrk_author_action as select * from labsrk.labsrk_author_action';
    execute 'create table '||v_backupschemaname||'.labsrk_user as select * from labsrk.labsrk_user';
    execute 'create table '||v_backupschemaname||'.labsrk_seo_data as select * from labsrk.labsrk_seo_data';
    execute 'create table '||v_backupschemaname||'.labsrk_topic as select * from labsrk.labsrk_topic';
    execute 'create table '||v_backupschemaname||'.labsrk_topic_asset_map as select * from labsrk.labsrk_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labsrk_poll as select * from labsrk.labsrk_poll';
    execute 'create table '||v_backupschemaname||'.labsrk_poll_option as select * from labsrk.labsrk_poll_option';
    execute 'create table '||v_backupschemaname||'.labsrk_poll_response as select * from labsrk.labsrk_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
