-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_db_backup()
-- Type: FUNCTION

-- Name: labukk_db_backup(); Type: FUNCTION; Schema: labukk; Owner: -
--

CREATE FUNCTION labukk.labukk_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labukk';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labukk_article as select * from labukk.labukk_article';
    execute 'create table '||v_backupschemaname||'.labukk_article_asset_map as select * from labukk.labukk_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labukk_video as select * from labukk.labukk_video';
    execute 'create table '||v_backupschemaname||'.labukk_album as select * from labukk.labukk_album';
    execute 'create table '||v_backupschemaname||'.labukk_album_asset_map as select * from labukk.labukk_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labukk_image as select * from labukk.labukk_image';
    execute 'create table '||v_backupschemaname||'.labukk_author_action as select * from labukk.labukk_author_action';
    execute 'create table '||v_backupschemaname||'.labukk_user as select * from labukk.labukk_user';
    execute 'create table '||v_backupschemaname||'.labukk_seo_data as select * from labukk.labukk_seo_data';
    execute 'create table '||v_backupschemaname||'.labukk_topic as select * from labukk.labukk_topic';
    execute 'create table '||v_backupschemaname||'.labukk_topic_asset_map as select * from labukk.labukk_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labukk_poll as select * from labukk.labukk_poll';
    execute 'create table '||v_backupschemaname||'.labukk_poll_option as select * from labukk.labukk_poll_option';
    execute 'create table '||v_backupschemaname||'.labukk_poll_response as select * from labukk.labukk_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
