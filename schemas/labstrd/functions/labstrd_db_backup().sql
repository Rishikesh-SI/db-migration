-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_db_backup()
-- Type: FUNCTION

-- Name: labstrd_db_backup(); Type: FUNCTION; Schema: labstrd; Owner: -
--

CREATE FUNCTION labstrd.labstrd_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labstrd';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labstrd_article as select * from labstrd.labstrd_article';
    execute 'create table '||v_backupschemaname||'.labstrd_article_asset_map as select * from labstrd.labstrd_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labstrd_video as select * from labstrd.labstrd_video';
    execute 'create table '||v_backupschemaname||'.labstrd_album as select * from labstrd.labstrd_album';
    execute 'create table '||v_backupschemaname||'.labstrd_album_asset_map as select * from labstrd.labstrd_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labstrd_image as select * from labstrd.labstrd_image';
    execute 'create table '||v_backupschemaname||'.labstrd_author_action as select * from labstrd.labstrd_author_action';
    execute 'create table '||v_backupschemaname||'.labstrd_user as select * from labstrd.labstrd_user';
    execute 'create table '||v_backupschemaname||'.labstrd_seo_data as select * from labstrd.labstrd_seo_data';
    execute 'create table '||v_backupschemaname||'.labstrd_topic as select * from labstrd.labstrd_topic';
    execute 'create table '||v_backupschemaname||'.labstrd_topic_asset_map as select * from labstrd.labstrd_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labstrd_poll as select * from labstrd.labstrd_poll';
    execute 'create table '||v_backupschemaname||'.labstrd_poll_option as select * from labstrd.labstrd_poll_option';
    execute 'create table '||v_backupschemaname||'.labstrd_poll_response as select * from labstrd.labstrd_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
