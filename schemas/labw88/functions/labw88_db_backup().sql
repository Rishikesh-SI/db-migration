-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_db_backup()
-- Type: FUNCTION

-- Name: labw88_db_backup(); Type: FUNCTION; Schema: labw88; Owner: -
--

CREATE FUNCTION labw88.labw88_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labw88';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labw88_article as select * from labw88.labw88_article';
    execute 'create table '||v_backupschemaname||'.labw88_article_asset_map as select * from labw88.labw88_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labw88_video as select * from labw88.labw88_video';
    execute 'create table '||v_backupschemaname||'.labw88_album as select * from labw88.labw88_album';
    execute 'create table '||v_backupschemaname||'.labw88_album_asset_map as select * from labw88.labw88_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labw88_image as select * from labw88.labw88_image';
    execute 'create table '||v_backupschemaname||'.labw88_author_action as select * from labw88.labw88_author_action';
    execute 'create table '||v_backupschemaname||'.labw88_user as select * from labw88.labw88_user';
    execute 'create table '||v_backupschemaname||'.labw88_seo_data as select * from labw88.labw88_seo_data';
    execute 'create table '||v_backupschemaname||'.labw88_topic as select * from labw88.labw88_topic';
    execute 'create table '||v_backupschemaname||'.labw88_topic_asset_map as select * from labw88.labw88_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labw88_poll as select * from labw88.labw88_poll';
    execute 'create table '||v_backupschemaname||'.labw88_poll_option as select * from labw88.labw88_poll_option';
    execute 'create table '||v_backupschemaname||'.labw88_poll_response as select * from labw88.labw88_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
