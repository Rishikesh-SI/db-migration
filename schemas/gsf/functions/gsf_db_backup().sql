-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_db_backup()
-- Type: FUNCTION

-- Name: gsf_db_backup(); Type: FUNCTION; Schema: gsf; Owner: -
--

CREATE FUNCTION gsf.gsf_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'gsf';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.gsf_article as select * from gsf.gsf_article';
    execute 'create table '||v_backupschemaname||'.gsf_article_asset_map as select * from gsf.gsf_article_asset_map';
    execute 'create table '||v_backupschemaname||'.gsf_video as select * from gsf.gsf_video';
    execute 'create table '||v_backupschemaname||'.gsf_album as select * from gsf.gsf_album';
    execute 'create table '||v_backupschemaname||'.gsf_album_asset_map as select * from gsf.gsf_album_asset_map';
    execute 'create table '||v_backupschemaname||'.gsf_image as select * from gsf.gsf_image';
    execute 'create table '||v_backupschemaname||'.gsf_author_action as select * from gsf.gsf_author_action';
    execute 'create table '||v_backupschemaname||'.gsf_user as select * from gsf.gsf_user';
    execute 'create table '||v_backupschemaname||'.gsf_seo_data as select * from gsf.gsf_seo_data';
    execute 'create table '||v_backupschemaname||'.gsf_topic as select * from gsf.gsf_topic';
    execute 'create table '||v_backupschemaname||'.gsf_topic_asset_map as select * from gsf.gsf_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.gsf_poll as select * from gsf.gsf_poll';
    execute 'create table '||v_backupschemaname||'.gsf_poll_option as select * from gsf.gsf_poll_option';
    execute 'create table '||v_backupschemaname||'.gsf_poll_response as select * from gsf.gsf_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
