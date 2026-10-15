-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_db_backup()
-- Type: FUNCTION

-- Name: labrr_db_backup(); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labRR';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labRR_article as select * from labRR.labRR_article';
    execute 'create table '||v_backupschemaname||'.labRR_article_asset_map as select * from labRR.labRR_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labRR_video as select * from labRR.labRR_video';
    execute 'create table '||v_backupschemaname||'.labRR_album as select * from labRR.labRR_album';
    execute 'create table '||v_backupschemaname||'.labRR_album_asset_map as select * from labRR.labRR_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labRR_image as select * from labRR.labRR_image';
    execute 'create table '||v_backupschemaname||'.labRR_author_action as select * from labRR.labRR_author_action';
    execute 'create table '||v_backupschemaname||'.labRR_user as select * from labRR.labRR_user';
    execute 'create table '||v_backupschemaname||'.labRR_seo_data as select * from labRR.labRR_seo_data';
    execute 'create table '||v_backupschemaname||'.labRR_topic as select * from labRR.labRR_topic';
    execute 'create table '||v_backupschemaname||'.labRR_topic_asset_map as select * from labRR.labRR_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labRR_poll as select * from labRR.labRR_poll';
    execute 'create table '||v_backupschemaname||'.labRR_poll_option as select * from labRR.labRR_poll_option';
    execute 'create table '||v_backupschemaname||'.labRR_poll_response as select * from labRR.labRR_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
