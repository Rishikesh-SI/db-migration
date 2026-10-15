-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkrold
-- Object: labtkr_db_backup()
-- Type: FUNCTION

-- Name: labtkr_db_backup(); Type: FUNCTION; Schema: labtkrold; Owner: -
--

CREATE FUNCTION labtkrold.labtkr_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labtkr';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labtkr_article as select * from labtkr.labtkr_article';
    execute 'create table '||v_backupschemaname||'.labtkr_article_asset_map as select * from labtkr.labtkr_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labtkr_video as select * from labtkr.labtkr_video';
    execute 'create table '||v_backupschemaname||'.labtkr_album as select * from labtkr.labtkr_album';
    execute 'create table '||v_backupschemaname||'.labtkr_album_asset_map as select * from labtkr.labtkr_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labtkr_image as select * from labtkr.labtkr_image';
    execute 'create table '||v_backupschemaname||'.labtkr_author_action as select * from labtkr.labtkr_author_action';
    execute 'create table '||v_backupschemaname||'.labtkr_user as select * from labtkr.labtkr_user';
    execute 'create table '||v_backupschemaname||'.labtkr_seo_data as select * from labtkr.labtkr_seo_data';
    execute 'create table '||v_backupschemaname||'.labtkr_topic as select * from labtkr.labtkr_topic';
    execute 'create table '||v_backupschemaname||'.labtkr_topic_asset_map as select * from labtkr.labtkr_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labtkr_poll as select * from labtkr.labtkr_poll';
    execute 'create table '||v_backupschemaname||'.labtkr_poll_option as select * from labtkr.labtkr_poll_option';
    execute 'create table '||v_backupschemaname||'.labtkr_poll_response as select * from labtkr.labtkr_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
