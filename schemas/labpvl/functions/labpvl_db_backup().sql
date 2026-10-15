-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_db_backup()
-- Type: FUNCTION

-- Name: labpvl_db_backup(); Type: FUNCTION; Schema: labpvl; Owner: -
--

CREATE FUNCTION labpvl.labpvl_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labpvl';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labpvl_article as select * from labpvl.labpvl_article';
    execute 'create table '||v_backupschemaname||'.labpvl_article_asset_map as select * from labpvl.labpvl_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labpvl_video as select * from labpvl.labpvl_video';
    execute 'create table '||v_backupschemaname||'.labpvl_album as select * from labpvl.labpvl_album';
    execute 'create table '||v_backupschemaname||'.labpvl_album_asset_map as select * from labpvl.labpvl_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labpvl_image as select * from labpvl.labpvl_image';
    execute 'create table '||v_backupschemaname||'.labpvl_author_action as select * from labpvl.labpvl_author_action';
    execute 'create table '||v_backupschemaname||'.labpvl_user as select * from labpvl.labpvl_user';
    execute 'create table '||v_backupschemaname||'.labpvl_seo_data as select * from labpvl.labpvl_seo_data';
    execute 'create table '||v_backupschemaname||'.labpvl_topic as select * from labpvl.labpvl_topic';
    execute 'create table '||v_backupschemaname||'.labpvl_topic_asset_map as select * from labpvl.labpvl_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labpvl_poll as select * from labpvl.labpvl_poll';
    execute 'create table '||v_backupschemaname||'.labpvl_poll_option as select * from labpvl.labpvl_poll_option';
    execute 'create table '||v_backupschemaname||'.labpvl_poll_response as select * from labpvl.labpvl_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
