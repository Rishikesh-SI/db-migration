-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_db_backup()
-- Type: FUNCTION

-- Name: labwis_db_backup(); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labwis';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labwis_article as select * from labwis.labwis_article';
    execute 'create table '||v_backupschemaname||'.labwis_article_asset_map as select * from labwis.labwis_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labwis_video as select * from labwis.labwis_video';
    execute 'create table '||v_backupschemaname||'.labwis_album as select * from labwis.labwis_album';
    execute 'create table '||v_backupschemaname||'.labwis_album_asset_map as select * from labwis.labwis_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labwis_image as select * from labwis.labwis_image';
    execute 'create table '||v_backupschemaname||'.labwis_author_action as select * from labwis.labwis_author_action';
    execute 'create table '||v_backupschemaname||'.labwis_user as select * from labwis.labwis_user';
    execute 'create table '||v_backupschemaname||'.labwis_seo_data as select * from labwis.labwis_seo_data';
    execute 'create table '||v_backupschemaname||'.labwis_topic as select * from labwis.labwis_topic';
    execute 'create table '||v_backupschemaname||'.labwis_topic_asset_map as select * from labwis.labwis_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labwis_poll as select * from labwis.labwis_poll';
    execute 'create table '||v_backupschemaname||'.labwis_poll_option as select * from labwis.labwis_poll_option';
    execute 'create table '||v_backupschemaname||'.labwis_poll_response as select * from labwis.labwis_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
