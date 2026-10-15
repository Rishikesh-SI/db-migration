-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_db_backup()
-- Type: FUNCTION

-- Name: labuww_db_backup(); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labuww';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labuww_article as select * from labuww.labuww_article';
    execute 'create table '||v_backupschemaname||'.labuww_article_asset_map as select * from labuww.labuww_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labuww_video as select * from labuww.labuww_video';
    execute 'create table '||v_backupschemaname||'.labuww_album as select * from labuww.labuww_album';
    execute 'create table '||v_backupschemaname||'.labuww_album_asset_map as select * from labuww.labuww_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labuww_image as select * from labuww.labuww_image';
    execute 'create table '||v_backupschemaname||'.labuww_author_action as select * from labuww.labuww_author_action';
    execute 'create table '||v_backupschemaname||'.labuww_user as select * from labuww.labuww_user';
    execute 'create table '||v_backupschemaname||'.labuww_seo_data as select * from labuww.labuww_seo_data';
    execute 'create table '||v_backupschemaname||'.labuww_topic as select * from labuww.labuww_topic';
    execute 'create table '||v_backupschemaname||'.labuww_topic_asset_map as select * from labuww.labuww_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labuww_poll as select * from labuww.labuww_poll';
    execute 'create table '||v_backupschemaname||'.labuww_poll_option as select * from labuww.labuww_poll_option';
    execute 'create table '||v_backupschemaname||'.labuww_poll_response as select * from labuww.labuww_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
