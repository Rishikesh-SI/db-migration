-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_db_backup()
-- Type: FUNCTION

-- Name: labwpl_db_backup(); Type: FUNCTION; Schema: labwpl; Owner: -
--

CREATE FUNCTION labwpl.labwpl_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labwpl';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labwpl_article as select * from labwpl.labwpl_article';
    execute 'create table '||v_backupschemaname||'.labwpl_article_asset_map as select * from labwpl.labwpl_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labwpl_video as select * from labwpl.labwpl_video';
    execute 'create table '||v_backupschemaname||'.labwpl_album as select * from labwpl.labwpl_album';
    execute 'create table '||v_backupschemaname||'.labwpl_album_asset_map as select * from labwpl.labwpl_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labwpl_image as select * from labwpl.labwpl_image';
    execute 'create table '||v_backupschemaname||'.labwpl_author_action as select * from labwpl.labwpl_author_action';
    execute 'create table '||v_backupschemaname||'.labwpl_user as select * from labwpl.labwpl_user';
    execute 'create table '||v_backupschemaname||'.labwpl_seo_data as select * from labwpl.labwpl_seo_data';
    execute 'create table '||v_backupschemaname||'.labwpl_topic as select * from labwpl.labwpl_topic';
    execute 'create table '||v_backupschemaname||'.labwpl_topic_asset_map as select * from labwpl.labwpl_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labwpl_poll as select * from labwpl.labwpl_poll';
    execute 'create table '||v_backupschemaname||'.labwpl_poll_option as select * from labwpl.labwpl_poll_option';
    execute 'create table '||v_backupschemaname||'.labwpl_poll_response as select * from labwpl.labwpl_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
