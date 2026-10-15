-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_db_backup()
-- Type: FUNCTION

-- Name: labstlz_db_backup(); Type: FUNCTION; Schema: labstlz; Owner: -
--

CREATE FUNCTION labstlz.labstlz_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labstlz';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labstlz_article as select * from labstlz.labstlz_article';
    execute 'create table '||v_backupschemaname||'.labstlz_article_asset_map as select * from labstlz.labstlz_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labstlz_video as select * from labstlz.labstlz_video';
    execute 'create table '||v_backupschemaname||'.labstlz_album as select * from labstlz.labstlz_album';
    execute 'create table '||v_backupschemaname||'.labstlz_album_asset_map as select * from labstlz.labstlz_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labstlz_image as select * from labstlz.labstlz_image';
    execute 'create table '||v_backupschemaname||'.labstlz_author_action as select * from labstlz.labstlz_author_action';
    execute 'create table '||v_backupschemaname||'.labstlz_user as select * from labstlz.labstlz_user';
    execute 'create table '||v_backupschemaname||'.labstlz_seo_data as select * from labstlz.labstlz_seo_data';
    execute 'create table '||v_backupschemaname||'.labstlz_topic as select * from labstlz.labstlz_topic';
    execute 'create table '||v_backupschemaname||'.labstlz_topic_asset_map as select * from labstlz.labstlz_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labstlz_poll as select * from labstlz.labstlz_poll';
    execute 'create table '||v_backupschemaname||'.labstlz_poll_option as select * from labstlz.labstlz_poll_option';
    execute 'create table '||v_backupschemaname||'.labstlz_poll_response as select * from labstlz.labstlz_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
