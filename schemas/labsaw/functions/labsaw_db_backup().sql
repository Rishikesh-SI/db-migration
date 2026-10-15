-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_db_backup()
-- Type: FUNCTION

-- Name: labsaw_db_backup(); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labsaw';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labsaw_article as select * from labsaw.labsaw_article';
    execute 'create table '||v_backupschemaname||'.labsaw_article_asset_map as select * from labsaw.labsaw_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labsaw_video as select * from labsaw.labsaw_video';
    execute 'create table '||v_backupschemaname||'.labsaw_album as select * from labsaw.labsaw_album';
    execute 'create table '||v_backupschemaname||'.labsaw_album_asset_map as select * from labsaw.labsaw_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labsaw_image as select * from labsaw.labsaw_image';
    execute 'create table '||v_backupschemaname||'.labsaw_author_action as select * from labsaw.labsaw_author_action';
    execute 'create table '||v_backupschemaname||'.labsaw_user as select * from labsaw.labsaw_user';
    execute 'create table '||v_backupschemaname||'.labsaw_seo_data as select * from labsaw.labsaw_seo_data';
    execute 'create table '||v_backupschemaname||'.labsaw_topic as select * from labsaw.labsaw_topic';
    execute 'create table '||v_backupschemaname||'.labsaw_topic_asset_map as select * from labsaw.labsaw_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labsaw_poll as select * from labsaw.labsaw_poll';
    execute 'create table '||v_backupschemaname||'.labsaw_poll_option as select * from labsaw.labsaw_poll_option';
    execute 'create table '||v_backupschemaname||'.labsaw_poll_response as select * from labsaw.labsaw_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
