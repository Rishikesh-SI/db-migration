-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_db_backup()
-- Type: FUNCTION

-- Name: labstmp_db_backup(); Type: FUNCTION; Schema: labstmp; Owner: -
--

CREATE FUNCTION labstmp.labstmp_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labstmp';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labstmp_article as select * from labstmp.labstmp_article';
    execute 'create table '||v_backupschemaname||'.labstmp_article_asset_map as select * from labstmp.labstmp_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labstmp_video as select * from labstmp.labstmp_video';
    execute 'create table '||v_backupschemaname||'.labstmp_album as select * from labstmp.labstmp_album';
    execute 'create table '||v_backupschemaname||'.labstmp_album_asset_map as select * from labstmp.labstmp_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labstmp_image as select * from labstmp.labstmp_image';
    execute 'create table '||v_backupschemaname||'.labstmp_author_action as select * from labstmp.labstmp_author_action';
    execute 'create table '||v_backupschemaname||'.labstmp_user as select * from labstmp.labstmp_user';
    execute 'create table '||v_backupschemaname||'.labstmp_seo_data as select * from labstmp.labstmp_seo_data';
    execute 'create table '||v_backupschemaname||'.labstmp_topic as select * from labstmp.labstmp_topic';
    execute 'create table '||v_backupschemaname||'.labstmp_topic_asset_map as select * from labstmp.labstmp_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labstmp_poll as select * from labstmp.labstmp_poll';
    execute 'create table '||v_backupschemaname||'.labstmp_poll_option as select * from labstmp.labstmp_poll_option';
    execute 'create table '||v_backupschemaname||'.labstmp_poll_response as select * from labstmp.labstmp_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
