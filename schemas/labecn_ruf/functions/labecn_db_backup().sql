-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_ruf
-- Object: labecn_db_backup()
-- Type: FUNCTION

-- Name: labecn_db_backup(); Type: FUNCTION; Schema: labecn_ruf; Owner: -
--

CREATE FUNCTION labecn_ruf.labecn_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labecn';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labecn_article as select * from labecn.labecn_article';
    execute 'create table '||v_backupschemaname||'.labecn_article_asset_map as select * from labecn.labecn_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labecn_video as select * from labecn.labecn_video';
    execute 'create table '||v_backupschemaname||'.labecn_album as select * from labecn.labecn_album';
    execute 'create table '||v_backupschemaname||'.labecn_album_asset_map as select * from labecn.labecn_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labecn_image as select * from labecn.labecn_image';
    execute 'create table '||v_backupschemaname||'.labecn_author_action as select * from labecn.labecn_author_action';
    execute 'create table '||v_backupschemaname||'.labecn_user as select * from labecn.labecn_user';
    execute 'create table '||v_backupschemaname||'.labecn_seo_data as select * from labecn.labecn_seo_data';
    execute 'create table '||v_backupschemaname||'.labecn_topic as select * from labecn.labecn_topic';
    execute 'create table '||v_backupschemaname||'.labecn_topic_asset_map as select * from labecn.labecn_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labecn_poll as select * from labecn.labecn_poll';
    execute 'create table '||v_backupschemaname||'.labecn_poll_option as select * from labecn.labecn_poll_option';
    execute 'create table '||v_backupschemaname||'.labecn_poll_response as select * from labecn.labecn_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
