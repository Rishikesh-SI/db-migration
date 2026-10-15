-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_db_backup()
-- Type: FUNCTION

-- Name: labpcm_db_backup(); Type: FUNCTION; Schema: labpcm; Owner: -
--

CREATE FUNCTION labpcm.labpcm_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labpcm';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labpcm_article as select * from labpcm.labpcm_article';
    execute 'create table '||v_backupschemaname||'.labpcm_article_asset_map as select * from labpcm.labpcm_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labpcm_video as select * from labpcm.labpcm_video';
    execute 'create table '||v_backupschemaname||'.labpcm_album as select * from labpcm.labpcm_album';
    execute 'create table '||v_backupschemaname||'.labpcm_album_asset_map as select * from labpcm.labpcm_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labpcm_image as select * from labpcm.labpcm_image';
    execute 'create table '||v_backupschemaname||'.labpcm_author_action as select * from labpcm.labpcm_author_action';
    execute 'create table '||v_backupschemaname||'.labpcm_user as select * from labpcm.labpcm_user';
    execute 'create table '||v_backupschemaname||'.labpcm_seo_data as select * from labpcm.labpcm_seo_data';
    execute 'create table '||v_backupschemaname||'.labpcm_topic as select * from labpcm.labpcm_topic';
    execute 'create table '||v_backupschemaname||'.labpcm_topic_asset_map as select * from labpcm.labpcm_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labpcm_poll as select * from labpcm.labpcm_poll';
    execute 'create table '||v_backupschemaname||'.labpcm_poll_option as select * from labpcm.labpcm_poll_option';
    execute 'create table '||v_backupschemaname||'.labpcm_poll_response as select * from labpcm.labpcm_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
