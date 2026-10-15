-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_db_backup()
-- Type: FUNCTION

-- Name: labso_db_backup(); Type: FUNCTION; Schema: labso_bkp; Owner: -
--

CREATE FUNCTION labso_bkp.labso_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labso';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labso_article as select * from labso.labso_article';
    execute 'create table '||v_backupschemaname||'.labso_article_asset_map as select * from labso.labso_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labso_video as select * from labso.labso_video';
    execute 'create table '||v_backupschemaname||'.labso_album as select * from labso.labso_album';
    execute 'create table '||v_backupschemaname||'.labso_album_asset_map as select * from labso.labso_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labso_image as select * from labso.labso_image';
    execute 'create table '||v_backupschemaname||'.labso_author_action as select * from labso.labso_author_action';
    execute 'create table '||v_backupschemaname||'.labso_user as select * from labso.labso_user';
    execute 'create table '||v_backupschemaname||'.labso_seo_data as select * from labso.labso_seo_data';
    execute 'create table '||v_backupschemaname||'.labso_topic as select * from labso.labso_topic';
    execute 'create table '||v_backupschemaname||'.labso_topic_asset_map as select * from labso.labso_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labso_poll as select * from labso.labso_poll';
    execute 'create table '||v_backupschemaname||'.labso_poll_option as select * from labso.labso_poll_option';
    execute 'create table '||v_backupschemaname||'.labso_poll_response as select * from labso.labso_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
