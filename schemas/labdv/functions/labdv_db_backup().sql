-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_db_backup()
-- Type: FUNCTION

-- Name: labdv_db_backup(); Type: FUNCTION; Schema: labdv; Owner: -
--

CREATE FUNCTION labdv.labdv_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labdv';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labdv_article as select * from labdv.labdv_article';
    execute 'create table '||v_backupschemaname||'.labdv_article_asset_map as select * from labdv.labdv_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labdv_video as select * from labdv.labdv_video';
    execute 'create table '||v_backupschemaname||'.labdv_album as select * from labdv.labdv_album';
    execute 'create table '||v_backupschemaname||'.labdv_album_asset_map as select * from labdv.labdv_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labdv_image as select * from labdv.labdv_image';
    execute 'create table '||v_backupschemaname||'.labdv_author_action as select * from labdv.labdv_author_action';
    execute 'create table '||v_backupschemaname||'.labdv_user as select * from labdv.labdv_user';
    execute 'create table '||v_backupschemaname||'.labdv_seo_data as select * from labdv.labdv_seo_data';
    execute 'create table '||v_backupschemaname||'.labdv_topic as select * from labdv.labdv_topic';
    execute 'create table '||v_backupschemaname||'.labdv_topic_asset_map as select * from labdv.labdv_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labdv_poll as select * from labdv.labdv_poll';
    execute 'create table '||v_backupschemaname||'.labdv_poll_option as select * from labdv.labdv_poll_option';
    execute 'create table '||v_backupschemaname||'.labdv_poll_response as select * from labdv.labdv_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
