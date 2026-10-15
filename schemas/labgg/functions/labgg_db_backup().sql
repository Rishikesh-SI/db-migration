-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_db_backup()
-- Type: FUNCTION

-- Name: labgg_db_backup(); Type: FUNCTION; Schema: labgg; Owner: -
--

CREATE FUNCTION labgg.labgg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labgg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labgg_article as select * from labgg.labgg_article';
    execute 'create table '||v_backupschemaname||'.labgg_article_asset_map as select * from labgg.labgg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labgg_video as select * from labgg.labgg_video';
    execute 'create table '||v_backupschemaname||'.labgg_album as select * from labgg.labgg_album';
    execute 'create table '||v_backupschemaname||'.labgg_album_asset_map as select * from labgg.labgg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labgg_image as select * from labgg.labgg_image';
    execute 'create table '||v_backupschemaname||'.labgg_author_action as select * from labgg.labgg_author_action';
    execute 'create table '||v_backupschemaname||'.labgg_user as select * from labgg.labgg_user';
    execute 'create table '||v_backupschemaname||'.labgg_seo_data as select * from labgg.labgg_seo_data';
    execute 'create table '||v_backupschemaname||'.labgg_topic as select * from labgg.labgg_topic';
    execute 'create table '||v_backupschemaname||'.labgg_topic_asset_map as select * from labgg.labgg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labgg_poll as select * from labgg.labgg_poll';
    execute 'create table '||v_backupschemaname||'.labgg_poll_option as select * from labgg.labgg_poll_option';
    execute 'create table '||v_backupschemaname||'.labgg_poll_response as select * from labgg.labgg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
