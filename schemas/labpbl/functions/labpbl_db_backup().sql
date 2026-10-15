-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_db_backup()
-- Type: FUNCTION

-- Name: labpbl_db_backup(); Type: FUNCTION; Schema: labpbl; Owner: -
--

CREATE FUNCTION labpbl.labpbl_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labpbl';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labpbl_article as select * from labpbl.labpbl_article';
    execute 'create table '||v_backupschemaname||'.labpbl_article_asset_map as select * from labpbl.labpbl_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labpbl_video as select * from labpbl.labpbl_video';
    execute 'create table '||v_backupschemaname||'.labpbl_album as select * from labpbl.labpbl_album';
    execute 'create table '||v_backupschemaname||'.labpbl_album_asset_map as select * from labpbl.labpbl_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labpbl_image as select * from labpbl.labpbl_image';
    execute 'create table '||v_backupschemaname||'.labpbl_author_action as select * from labpbl.labpbl_author_action';
    execute 'create table '||v_backupschemaname||'.labpbl_user as select * from labpbl.labpbl_user';
    execute 'create table '||v_backupschemaname||'.labpbl_seo_data as select * from labpbl.labpbl_seo_data';
    execute 'create table '||v_backupschemaname||'.labpbl_topic as select * from labpbl.labpbl_topic';
    execute 'create table '||v_backupschemaname||'.labpbl_topic_asset_map as select * from labpbl.labpbl_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labpbl_poll as select * from labpbl.labpbl_poll';
    execute 'create table '||v_backupschemaname||'.labpbl_poll_option as select * from labpbl.labpbl_poll_option';
    execute 'create table '||v_backupschemaname||'.labpbl_poll_response as select * from labpbl.labpbl_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
