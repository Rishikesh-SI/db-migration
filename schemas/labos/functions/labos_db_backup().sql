-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_db_backup()
-- Type: FUNCTION

-- Name: labos_db_backup(); Type: FUNCTION; Schema: labos; Owner: -
--

CREATE FUNCTION labos.labos_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labos';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labos_article as select * from labos.labos_article';
    execute 'create table '||v_backupschemaname||'.labos_article_asset_map as select * from labos.labos_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labos_video as select * from labos.labos_video';
    execute 'create table '||v_backupschemaname||'.labos_album as select * from labos.labos_album';
    execute 'create table '||v_backupschemaname||'.labos_album_asset_map as select * from labos.labos_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labos_image as select * from labos.labos_image';
    execute 'create table '||v_backupschemaname||'.labos_author_action as select * from labos.labos_author_action';
    execute 'create table '||v_backupschemaname||'.labos_user as select * from labos.labos_user';
    execute 'create table '||v_backupschemaname||'.labos_seo_data as select * from labos.labos_seo_data';
    execute 'create table '||v_backupschemaname||'.labos_topic as select * from labos.labos_topic';
    execute 'create table '||v_backupschemaname||'.labos_topic_asset_map as select * from labos.labos_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labos_poll as select * from labos.labos_poll';
    execute 'create table '||v_backupschemaname||'.labos_poll_option as select * from labos.labos_poll_option';
    execute 'create table '||v_backupschemaname||'.labos_poll_response as select * from labos.labos_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
