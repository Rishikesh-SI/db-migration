-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_db_backup()
-- Type: FUNCTION

-- Name: labgsoc_db_backup(); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labgsoc';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labgsoc_article as select * from labgsoc.labgsoc_article';
    execute 'create table '||v_backupschemaname||'.labgsoc_article_asset_map as select * from labgsoc.labgsoc_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labgsoc_video as select * from labgsoc.labgsoc_video';
    execute 'create table '||v_backupschemaname||'.labgsoc_album as select * from labgsoc.labgsoc_album';
    execute 'create table '||v_backupschemaname||'.labgsoc_album_asset_map as select * from labgsoc.labgsoc_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labgsoc_image as select * from labgsoc.labgsoc_image';
    execute 'create table '||v_backupschemaname||'.labgsoc_author_action as select * from labgsoc.labgsoc_author_action';
    execute 'create table '||v_backupschemaname||'.labgsoc_user as select * from labgsoc.labgsoc_user';
    execute 'create table '||v_backupschemaname||'.labgsoc_seo_data as select * from labgsoc.labgsoc_seo_data';
    execute 'create table '||v_backupschemaname||'.labgsoc_topic as select * from labgsoc.labgsoc_topic';
    execute 'create table '||v_backupschemaname||'.labgsoc_topic_asset_map as select * from labgsoc.labgsoc_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labgsoc_poll as select * from labgsoc.labgsoc_poll';
    execute 'create table '||v_backupschemaname||'.labgsoc_poll_option as select * from labgsoc.labgsoc_poll_option';
    execute 'create table '||v_backupschemaname||'.labgsoc_poll_response as select * from labgsoc.labgsoc_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
