-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_db_backup()
-- Type: FUNCTION

-- Name: labal_nassr_db_backup(); Type: FUNCTION; Schema: labal_nassr; Owner: -
--

CREATE FUNCTION labal_nassr.labal_nassr_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labal_nassr';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labal_nassr_article as select * from labal_nassr.labal_nassr_article';
    execute 'create table '||v_backupschemaname||'.labal_nassr_article_asset_map as select * from labal_nassr.labal_nassr_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labal_nassr_video as select * from labal_nassr.labal_nassr_video';
    execute 'create table '||v_backupschemaname||'.labal_nassr_album as select * from labal_nassr.labal_nassr_album';
    execute 'create table '||v_backupschemaname||'.labal_nassr_album_asset_map as select * from labal_nassr.labal_nassr_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labal_nassr_image as select * from labal_nassr.labal_nassr_image';
    execute 'create table '||v_backupschemaname||'.labal_nassr_author_action as select * from labal_nassr.labal_nassr_author_action';
    execute 'create table '||v_backupschemaname||'.labal_nassr_user as select * from labal_nassr.labal_nassr_user';
    execute 'create table '||v_backupschemaname||'.labal_nassr_seo_data as select * from labal_nassr.labal_nassr_seo_data';
    execute 'create table '||v_backupschemaname||'.labal_nassr_topic as select * from labal_nassr.labal_nassr_topic';
    execute 'create table '||v_backupschemaname||'.labal_nassr_topic_asset_map as select * from labal_nassr.labal_nassr_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labal_nassr_poll as select * from labal_nassr.labal_nassr_poll';
    execute 'create table '||v_backupschemaname||'.labal_nassr_poll_option as select * from labal_nassr.labal_nassr_poll_option';
    execute 'create table '||v_backupschemaname||'.labal_nassr_poll_response as select * from labal_nassr.labal_nassr_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
