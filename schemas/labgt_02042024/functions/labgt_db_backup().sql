-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_db_backup()
-- Type: FUNCTION

-- Name: labgt_db_backup(); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labgt';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labgt_article as select * from labgt.labgt_article';
    execute 'create table '||v_backupschemaname||'.labgt_article_asset_map as select * from labgt.labgt_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labgt_video as select * from labgt.labgt_video';
    execute 'create table '||v_backupschemaname||'.labgt_album as select * from labgt.labgt_album';
    execute 'create table '||v_backupschemaname||'.labgt_album_asset_map as select * from labgt.labgt_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labgt_image as select * from labgt.labgt_image';
    execute 'create table '||v_backupschemaname||'.labgt_author_action as select * from labgt.labgt_author_action';
    execute 'create table '||v_backupschemaname||'.labgt_user as select * from labgt.labgt_user';
    execute 'create table '||v_backupschemaname||'.labgt_seo_data as select * from labgt.labgt_seo_data';
    execute 'create table '||v_backupschemaname||'.labgt_topic as select * from labgt.labgt_topic';
    execute 'create table '||v_backupschemaname||'.labgt_topic_asset_map as select * from labgt.labgt_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labgt_poll as select * from labgt.labgt_poll';
    execute 'create table '||v_backupschemaname||'.labgt_poll_option as select * from labgt.labgt_poll_option';
    execute 'create table '||v_backupschemaname||'.labgt_poll_response as select * from labgt.labgt_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
