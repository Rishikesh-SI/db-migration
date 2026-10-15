-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_db_backup()
-- Type: FUNCTION

-- Name: khi_db_backup(); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_sourceschemaname varchar(20) := 'khi';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.khi_article as select * from khi.khi_article';
    execute 'create table '||v_backupschemaname||'.khi_article_asset_map as select * from khi.khi_article_asset_map';
    execute 'create table '||v_backupschemaname||'.khi_video as select * from khi.khi_video';
    execute 'create table '||v_backupschemaname||'.khi_album as select * from khi.khi_album';
    execute 'create table '||v_backupschemaname||'.khi_album_asset_map as select * from khi.khi_album_asset_map';
    execute 'create table '||v_backupschemaname||'.khi_image as select * from khi.khi_image';
    execute 'create table '||v_backupschemaname||'.khi_author_action as select * from khi.khi_author_action';
    execute 'create table '||v_backupschemaname||'.khi_user as select * from khi.khi_user';
    execute 'create table '||v_backupschemaname||'.khi_seo_data as select * from khi.khi_seo_data';
    execute 'create table '||v_backupschemaname||'.khi_topic as select * from khi.khi_topic';
    execute 'create table '||v_backupschemaname||'.khi_topic_asset_map as select * from khi.khi_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.khi_poll as select * from khi.khi_poll';
    execute 'create table '||v_backupschemaname||'.khi_poll_option as select * from khi.khi_poll_option';
    execute 'create table '||v_backupschemaname||'.khi_poll_response as select * from khi.khi_poll_response';
    
    p_result := 1;
    
end;

$$;


--
