-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_db_backup()
-- Type: FUNCTION

-- Name: labets_db_backup(); Type: FUNCTION; Schema: labets; Owner: -
--

CREATE FUNCTION labets.labets_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labets';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labets_article as select * from labets.labets_article';
    execute 'create table '||v_backupschemaname||'.labets_article_asset_map as select * from labets.labets_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labets_video as select * from labets.labets_video';
    execute 'create table '||v_backupschemaname||'.labets_album as select * from labets.labets_album';
    execute 'create table '||v_backupschemaname||'.labets_album_asset_map as select * from labets.labets_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labets_image as select * from labets.labets_image';
    execute 'create table '||v_backupschemaname||'.labets_author_action as select * from labets.labets_author_action';
    execute 'create table '||v_backupschemaname||'.labets_user as select * from labets.labets_user';
    execute 'create table '||v_backupschemaname||'.labets_seo_data as select * from labets.labets_seo_data';
    execute 'create table '||v_backupschemaname||'.labets_topic as select * from labets.labets_topic';
    execute 'create table '||v_backupschemaname||'.labets_topic_asset_map as select * from labets.labets_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labets_poll as select * from labets.labets_poll';
    execute 'create table '||v_backupschemaname||'.labets_poll_option as select * from labets.labets_poll_option';
    execute 'create table '||v_backupschemaname||'.labets_poll_response as select * from labets.labets_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
