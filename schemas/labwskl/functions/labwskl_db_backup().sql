-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_db_backup()
-- Type: FUNCTION

-- Name: labwskl_db_backup(); Type: FUNCTION; Schema: labwskl; Owner: -
--

CREATE FUNCTION labwskl.labwskl_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labwskl';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labwskl_article as select * from labwskl.labwskl_article';
    execute 'create table '||v_backupschemaname||'.labwskl_article_asset_map as select * from labwskl.labwskl_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labwskl_video as select * from labwskl.labwskl_video';
    execute 'create table '||v_backupschemaname||'.labwskl_album as select * from labwskl.labwskl_album';
    execute 'create table '||v_backupschemaname||'.labwskl_album_asset_map as select * from labwskl.labwskl_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labwskl_image as select * from labwskl.labwskl_image';
    execute 'create table '||v_backupschemaname||'.labwskl_author_action as select * from labwskl.labwskl_author_action';
    execute 'create table '||v_backupschemaname||'.labwskl_user as select * from labwskl.labwskl_user';
    execute 'create table '||v_backupschemaname||'.labwskl_seo_data as select * from labwskl.labwskl_seo_data';
    execute 'create table '||v_backupschemaname||'.labwskl_topic as select * from labwskl.labwskl_topic';
    execute 'create table '||v_backupschemaname||'.labwskl_topic_asset_map as select * from labwskl.labwskl_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labwskl_poll as select * from labwskl.labwskl_poll';
    execute 'create table '||v_backupschemaname||'.labwskl_poll_option as select * from labwskl.labwskl_poll_option';
    execute 'create table '||v_backupschemaname||'.labwskl_poll_response as select * from labwskl.labwskl_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
