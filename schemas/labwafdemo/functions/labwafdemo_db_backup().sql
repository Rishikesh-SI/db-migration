-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: labwafdemo_db_backup()
-- Type: FUNCTION

-- Name: labwafdemo_db_backup(); Type: FUNCTION; Schema: labwafdemo; Owner: -
--

CREATE FUNCTION labwafdemo.labwafdemo_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labwafdemo';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labwafdemo_article as select * from labwafdemo.labwafdemo_article';
    execute 'create table '||v_backupschemaname||'.labwafdemo_article_asset_map as select * from labwafdemo.labwafdemo_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labwafdemo_video as select * from labwafdemo.labwafdemo_video';
    execute 'create table '||v_backupschemaname||'.labwafdemo_album as select * from labwafdemo.labwafdemo_album';
    execute 'create table '||v_backupschemaname||'.labwafdemo_album_asset_map as select * from labwafdemo.labwafdemo_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labwafdemo_image as select * from labwafdemo.labwafdemo_image';
    execute 'create table '||v_backupschemaname||'.labwafdemo_author_action as select * from labwafdemo.labwafdemo_author_action';
    execute 'create table '||v_backupschemaname||'.labwafdemo_user as select * from labwafdemo.labwafdemo_user';
    execute 'create table '||v_backupschemaname||'.labwafdemo_seo_data as select * from labwafdemo.labwafdemo_seo_data';
    execute 'create table '||v_backupschemaname||'.labwafdemo_topic as select * from labwafdemo.labwafdemo_topic';
    execute 'create table '||v_backupschemaname||'.labwafdemo_topic_asset_map as select * from labwafdemo.labwafdemo_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labwafdemo_poll as select * from labwafdemo.labwafdemo_poll';
    execute 'create table '||v_backupschemaname||'.labwafdemo_poll_option as select * from labwafdemo.labwafdemo_poll_option';
    execute 'create table '||v_backupschemaname||'.labwafdemo_poll_response as select * from labwafdemo.labwafdemo_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
