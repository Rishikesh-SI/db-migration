-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_db_backup()
-- Type: FUNCTION

-- Name: labkxp_db_backup(); Type: FUNCTION; Schema: labkxp1; Owner: -
--

CREATE FUNCTION labkxp1.labkxp_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labkxp';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labkxp_article as select * from labkxp.labkxp_article';
    execute 'create table '||v_backupschemaname||'.labkxp_article_asset_map as select * from labkxp.labkxp_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labkxp_video as select * from labkxp.labkxp_video';
    execute 'create table '||v_backupschemaname||'.labkxp_album as select * from labkxp.labkxp_album';
    execute 'create table '||v_backupschemaname||'.labkxp_album_asset_map as select * from labkxp.labkxp_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labkxp_image as select * from labkxp.labkxp_image';
    execute 'create table '||v_backupschemaname||'.labkxp_author_action as select * from labkxp.labkxp_author_action';
    execute 'create table '||v_backupschemaname||'.labkxp_user as select * from labkxp.labkxp_user';
    execute 'create table '||v_backupschemaname||'.labkxp_seo_data as select * from labkxp.labkxp_seo_data';
    execute 'create table '||v_backupschemaname||'.labkxp_topic as select * from labkxp.labkxp_topic';
    execute 'create table '||v_backupschemaname||'.labkxp_topic_asset_map as select * from labkxp.labkxp_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labkxp_poll as select * from labkxp.labkxp_poll';
    execute 'create table '||v_backupschemaname||'.labkxp_poll_option as select * from labkxp.labkxp_poll_option';
    execute 'create table '||v_backupschemaname||'.labkxp_poll_response as select * from labkxp.labkxp_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
