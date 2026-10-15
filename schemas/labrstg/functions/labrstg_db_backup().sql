-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_db_backup()
-- Type: FUNCTION

-- Name: labrstg_db_backup(); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labrstg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labrstg_article as select * from labrstg.labrstg_article';
    execute 'create table '||v_backupschemaname||'.labrstg_article_asset_map as select * from labrstg.labrstg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labrstg_video as select * from labrstg.labrstg_video';
    execute 'create table '||v_backupschemaname||'.labrstg_album as select * from labrstg.labrstg_album';
    execute 'create table '||v_backupschemaname||'.labrstg_album_asset_map as select * from labrstg.labrstg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labrstg_image as select * from labrstg.labrstg_image';
    execute 'create table '||v_backupschemaname||'.labrstg_author_action as select * from labrstg.labrstg_author_action';
    execute 'create table '||v_backupschemaname||'.labrstg_user as select * from labrstg.labrstg_user';
    execute 'create table '||v_backupschemaname||'.labrstg_seo_data as select * from labrstg.labrstg_seo_data';
    execute 'create table '||v_backupschemaname||'.labrstg_topic as select * from labrstg.labrstg_topic';
    execute 'create table '||v_backupschemaname||'.labrstg_topic_asset_map as select * from labrstg.labrstg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labrstg_poll as select * from labrstg.labrstg_poll';
    execute 'create table '||v_backupschemaname||'.labrstg_poll_option as select * from labrstg.labrstg_poll_option';
    execute 'create table '||v_backupschemaname||'.labrstg_poll_response as select * from labrstg.labrstg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
