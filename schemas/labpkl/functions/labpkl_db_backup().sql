-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_db_backup()
-- Type: FUNCTION

-- Name: labpkl_db_backup(); Type: FUNCTION; Schema: labpkl; Owner: -
--

CREATE FUNCTION labpkl.labpkl_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labpkl';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labpkl_article as select * from labpkl.labpkl_article';
    execute 'create table '||v_backupschemaname||'.labpkl_article_asset_map as select * from labpkl.labpkl_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labpkl_video as select * from labpkl.labpkl_video';
    execute 'create table '||v_backupschemaname||'.labpkl_album as select * from labpkl.labpkl_album';
    execute 'create table '||v_backupschemaname||'.labpkl_album_asset_map as select * from labpkl.labpkl_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labpkl_image as select * from labpkl.labpkl_image';
    execute 'create table '||v_backupschemaname||'.labpkl_author_action as select * from labpkl.labpkl_author_action';
    execute 'create table '||v_backupschemaname||'.labpkl_user as select * from labpkl.labpkl_user';
    execute 'create table '||v_backupschemaname||'.labpkl_seo_data as select * from labpkl.labpkl_seo_data';
    execute 'create table '||v_backupschemaname||'.labpkl_topic as select * from labpkl.labpkl_topic';
    execute 'create table '||v_backupschemaname||'.labpkl_topic_asset_map as select * from labpkl.labpkl_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labpkl_poll as select * from labpkl.labpkl_poll';
    execute 'create table '||v_backupschemaname||'.labpkl_poll_option as select * from labpkl.labpkl_poll_option';
    execute 'create table '||v_backupschemaname||'.labpkl_poll_response as select * from labpkl.labpkl_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
