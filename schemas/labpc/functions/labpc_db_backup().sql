-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_db_backup()
-- Type: FUNCTION

-- Name: labpc_db_backup(); Type: FUNCTION; Schema: labpc; Owner: -
--

CREATE FUNCTION labpc.labpc_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labpc';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labpc_article as select * from labpc.labpc_article';
    execute 'create table '||v_backupschemaname||'.labpc_article_asset_map as select * from labpc.labpc_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labpc_video as select * from labpc.labpc_video';
    execute 'create table '||v_backupschemaname||'.labpc_album as select * from labpc.labpc_album';
    execute 'create table '||v_backupschemaname||'.labpc_album_asset_map as select * from labpc.labpc_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labpc_image as select * from labpc.labpc_image';
    execute 'create table '||v_backupschemaname||'.labpc_author_action as select * from labpc.labpc_author_action';
    execute 'create table '||v_backupschemaname||'.labpc_user as select * from labpc.labpc_user';
    execute 'create table '||v_backupschemaname||'.labpc_seo_data as select * from labpc.labpc_seo_data';
    execute 'create table '||v_backupschemaname||'.labpc_topic as select * from labpc.labpc_topic';
    execute 'create table '||v_backupschemaname||'.labpc_topic_asset_map as select * from labpc.labpc_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labpc_poll as select * from labpc.labpc_poll';
    execute 'create table '||v_backupschemaname||'.labpc_poll_option as select * from labpc.labpc_poll_option';
    execute 'create table '||v_backupschemaname||'.labpc_poll_response as select * from labpc.labpc_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
