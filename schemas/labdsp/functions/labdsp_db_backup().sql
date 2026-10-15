-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_db_backup()
-- Type: FUNCTION

-- Name: labdsp_db_backup(); Type: FUNCTION; Schema: labdsp; Owner: -
--

CREATE FUNCTION labdsp.labdsp_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labdsp';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labdsp_article as select * from labdsp.labdsp_article';
    execute 'create table '||v_backupschemaname||'.labdsp_article_asset_map as select * from labdsp.labdsp_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labdsp_video as select * from labdsp.labdsp_video';
    execute 'create table '||v_backupschemaname||'.labdsp_album as select * from labdsp.labdsp_album';
    execute 'create table '||v_backupschemaname||'.labdsp_album_asset_map as select * from labdsp.labdsp_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labdsp_image as select * from labdsp.labdsp_image';
    execute 'create table '||v_backupschemaname||'.labdsp_author_action as select * from labdsp.labdsp_author_action';
    execute 'create table '||v_backupschemaname||'.labdsp_user as select * from labdsp.labdsp_user';
    execute 'create table '||v_backupschemaname||'.labdsp_seo_data as select * from labdsp.labdsp_seo_data';
    execute 'create table '||v_backupschemaname||'.labdsp_topic as select * from labdsp.labdsp_topic';
    execute 'create table '||v_backupschemaname||'.labdsp_topic_asset_map as select * from labdsp.labdsp_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labdsp_poll as select * from labdsp.labdsp_poll';
    execute 'create table '||v_backupschemaname||'.labdsp_poll_option as select * from labdsp.labdsp_poll_option';
    execute 'create table '||v_backupschemaname||'.labdsp_poll_response as select * from labdsp.labdsp_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
