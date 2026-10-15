-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_db_backup()
-- Type: FUNCTION

-- Name: labdsg_db_backup(); Type: FUNCTION; Schema: labdsg; Owner: -
--

CREATE FUNCTION labdsg.labdsg_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labdsg';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labdsg_article as select * from labdsg.labdsg_article';
    execute 'create table '||v_backupschemaname||'.labdsg_article_asset_map as select * from labdsg.labdsg_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labdsg_video as select * from labdsg.labdsg_video';
    execute 'create table '||v_backupschemaname||'.labdsg_album as select * from labdsg.labdsg_album';
    execute 'create table '||v_backupschemaname||'.labdsg_album_asset_map as select * from labdsg.labdsg_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labdsg_image as select * from labdsg.labdsg_image';
    execute 'create table '||v_backupschemaname||'.labdsg_author_action as select * from labdsg.labdsg_author_action';
    execute 'create table '||v_backupschemaname||'.labdsg_user as select * from labdsg.labdsg_user';
    execute 'create table '||v_backupschemaname||'.labdsg_seo_data as select * from labdsg.labdsg_seo_data';
    execute 'create table '||v_backupschemaname||'.labdsg_topic as select * from labdsg.labdsg_topic';
    execute 'create table '||v_backupschemaname||'.labdsg_topic_asset_map as select * from labdsg.labdsg_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labdsg_poll as select * from labdsg.labdsg_poll';
    execute 'create table '||v_backupschemaname||'.labdsg_poll_option as select * from labdsg.labdsg_poll_option';
    execute 'create table '||v_backupschemaname||'.labdsg_poll_response as select * from labdsg.labdsg_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
