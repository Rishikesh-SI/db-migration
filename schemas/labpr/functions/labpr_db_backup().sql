-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_db_backup()
-- Type: FUNCTION

-- Name: labpr_db_backup(); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labpr';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labpr_article as select * from labpr.labpr_article';
    execute 'create table '||v_backupschemaname||'.labpr_article_asset_map as select * from labpr.labpr_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labpr_video as select * from labpr.labpr_video';
    execute 'create table '||v_backupschemaname||'.labpr_album as select * from labpr.labpr_album';
    execute 'create table '||v_backupschemaname||'.labpr_album_asset_map as select * from labpr.labpr_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labpr_image as select * from labpr.labpr_image';
    execute 'create table '||v_backupschemaname||'.labpr_author_action as select * from labpr.labpr_author_action';
    execute 'create table '||v_backupschemaname||'.labpr_user as select * from labpr.labpr_user';
    execute 'create table '||v_backupschemaname||'.labpr_seo_data as select * from labpr.labpr_seo_data';
    execute 'create table '||v_backupschemaname||'.labpr_topic as select * from labpr.labpr_topic';
    execute 'create table '||v_backupschemaname||'.labpr_topic_asset_map as select * from labpr.labpr_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labpr_poll as select * from labpr.labpr_poll';
    execute 'create table '||v_backupschemaname||'.labpr_poll_option as select * from labpr.labpr_poll_option';
    execute 'create table '||v_backupschemaname||'.labpr_poll_response as select * from labpr.labpr_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
