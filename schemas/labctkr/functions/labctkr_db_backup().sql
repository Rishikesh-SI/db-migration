-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: labctkr_db_backup()
-- Type: FUNCTION

-- Name: labctkr_db_backup(); Type: FUNCTION; Schema: labctkr; Owner: -
--

CREATE FUNCTION labctkr.labctkr_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labctkr';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labctkr_article as select * from labctkr.labctkr_article';
    execute 'create table '||v_backupschemaname||'.labctkr_article_asset_map as select * from labctkr.labctkr_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labctkr_video as select * from labctkr.labctkr_video';
    execute 'create table '||v_backupschemaname||'.labctkr_album as select * from labctkr.labctkr_album';
    execute 'create table '||v_backupschemaname||'.labctkr_album_asset_map as select * from labctkr.labctkr_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labctkr_image as select * from labctkr.labctkr_image';
    execute 'create table '||v_backupschemaname||'.labctkr_author_action as select * from labctkr.labctkr_author_action';
    execute 'create table '||v_backupschemaname||'.labctkr_user as select * from labctkr.labctkr_user';
    execute 'create table '||v_backupschemaname||'.labctkr_seo_data as select * from labctkr.labctkr_seo_data';
    execute 'create table '||v_backupschemaname||'.labctkr_topic as select * from labctkr.labctkr_topic';
    execute 'create table '||v_backupschemaname||'.labctkr_topic_asset_map as select * from labctkr.labctkr_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labctkr_poll as select * from labctkr.labctkr_poll';
    execute 'create table '||v_backupschemaname||'.labctkr_poll_option as select * from labctkr.labctkr_poll_option';
    execute 'create table '||v_backupschemaname||'.labctkr_poll_response as select * from labctkr.labctkr_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
