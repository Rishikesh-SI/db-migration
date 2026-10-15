-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_db_backup()
-- Type: FUNCTION

-- Name: labwf_db_backup(); Type: FUNCTION; Schema: labwf; Owner: -
--

CREATE FUNCTION labwf.labwf_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labwf';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labwf_article as select * from labwf.labwf_article';
    execute 'create table '||v_backupschemaname||'.labwf_article_asset_map as select * from labwf.labwf_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labwf_video as select * from labwf.labwf_video';
    execute 'create table '||v_backupschemaname||'.labwf_album as select * from labwf.labwf_album';
    execute 'create table '||v_backupschemaname||'.labwf_album_asset_map as select * from labwf.labwf_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labwf_image as select * from labwf.labwf_image';
    execute 'create table '||v_backupschemaname||'.labwf_author_action as select * from labwf.labwf_author_action';
    execute 'create table '||v_backupschemaname||'.labwf_user as select * from labwf.labwf_user';
    execute 'create table '||v_backupschemaname||'.labwf_seo_data as select * from labwf.labwf_seo_data';
    execute 'create table '||v_backupschemaname||'.labwf_topic as select * from labwf.labwf_topic';
    execute 'create table '||v_backupschemaname||'.labwf_topic_asset_map as select * from labwf.labwf_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labwf_poll as select * from labwf.labwf_poll';
    execute 'create table '||v_backupschemaname||'.labwf_poll_option as select * from labwf.labwf_poll_option';
    execute 'create table '||v_backupschemaname||'.labwf_poll_response as select * from labwf.labwf_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
