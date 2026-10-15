-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_db_backup()
-- Type: FUNCTION

-- Name: utt_db_backup(); Type: FUNCTION; Schema: utt; Owner: -
--

CREATE FUNCTION utt.utt_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'utt';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.utt_article as select * from utt.utt_article';
    execute 'create table '||v_backupschemaname||'.utt_article_asset_map as select * from utt.utt_article_asset_map';
    execute 'create table '||v_backupschemaname||'.utt_video as select * from utt.utt_video';
    execute 'create table '||v_backupschemaname||'.utt_album as select * from utt.utt_album';
    execute 'create table '||v_backupschemaname||'.utt_album_asset_map as select * from utt.utt_album_asset_map';
    execute 'create table '||v_backupschemaname||'.utt_image as select * from utt.utt_image';
    execute 'create table '||v_backupschemaname||'.utt_author_action as select * from utt.utt_author_action';
    execute 'create table '||v_backupschemaname||'.utt_user as select * from utt.utt_user';
    execute 'create table '||v_backupschemaname||'.utt_seo_data as select * from utt.utt_seo_data';
    execute 'create table '||v_backupschemaname||'.utt_topic as select * from utt.utt_topic';
    execute 'create table '||v_backupschemaname||'.utt_topic_asset_map as select * from utt.utt_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.utt_poll as select * from utt.utt_poll';
    execute 'create table '||v_backupschemaname||'.utt_poll_option as select * from utt.utt_poll_option';
    execute 'create table '||v_backupschemaname||'.utt_poll_response as select * from utt.utt_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
