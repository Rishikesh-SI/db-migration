-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_db_backup()
-- Type: FUNCTION

-- Name: labmsg_db_backup(); Type: FUNCTION; Schema: labmsg; Owner: -
--

CREATE FUNCTION labmsg.labmsg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labmsg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labmsg_article as select * from labmsg.labmsg_article';
    execute 'create table '||v_backupschemaname||'.labmsg_article_asset_map as select * from labmsg.labmsg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labmsg_video as select * from labmsg.labmsg_video';
    execute 'create table '||v_backupschemaname||'.labmsg_album as select * from labmsg.labmsg_album';
    execute 'create table '||v_backupschemaname||'.labmsg_album_asset_map as select * from labmsg.labmsg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labmsg_image as select * from labmsg.labmsg_image';
    execute 'create table '||v_backupschemaname||'.labmsg_author_action as select * from labmsg.labmsg_author_action';
    execute 'create table '||v_backupschemaname||'.labmsg_user as select * from labmsg.labmsg_user';
    execute 'create table '||v_backupschemaname||'.labmsg_seo_data as select * from labmsg.labmsg_seo_data';
    execute 'create table '||v_backupschemaname||'.labmsg_topic as select * from labmsg.labmsg_topic';
    execute 'create table '||v_backupschemaname||'.labmsg_topic_asset_map as select * from labmsg.labmsg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labmsg_poll as select * from labmsg.labmsg_poll';
    execute 'create table '||v_backupschemaname||'.labmsg_poll_option as select * from labmsg.labmsg_poll_option';
    execute 'create table '||v_backupschemaname||'.labmsg_poll_response as select * from labmsg.labmsg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
