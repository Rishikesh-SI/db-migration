-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_db_backup()
-- Type: FUNCTION

-- Name: labirao_db_backup(); Type: FUNCTION; Schema: labirao; Owner: -
--

CREATE FUNCTION labirao.labirao_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labirao';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labirao_article as select * from labirao.labirao_article';
    execute 'create table '||v_backupschemaname||'.labirao_article_asset_map as select * from labirao.labirao_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labirao_video as select * from labirao.labirao_video';
    execute 'create table '||v_backupschemaname||'.labirao_album as select * from labirao.labirao_album';
    execute 'create table '||v_backupschemaname||'.labirao_album_asset_map as select * from labirao.labirao_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labirao_image as select * from labirao.labirao_image';
    execute 'create table '||v_backupschemaname||'.labirao_author_action as select * from labirao.labirao_author_action';
    execute 'create table '||v_backupschemaname||'.labirao_user as select * from labirao.labirao_user';
    execute 'create table '||v_backupschemaname||'.labirao_seo_data as select * from labirao.labirao_seo_data';
    execute 'create table '||v_backupschemaname||'.labirao_topic as select * from labirao.labirao_topic';
    execute 'create table '||v_backupschemaname||'.labirao_topic_asset_map as select * from labirao.labirao_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labirao_poll as select * from labirao.labirao_poll';
    execute 'create table '||v_backupschemaname||'.labirao_poll_option as select * from labirao.labirao_poll_option';
    execute 'create table '||v_backupschemaname||'.labirao_poll_response as select * from labirao.labirao_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
