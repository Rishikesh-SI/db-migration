-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_db_backup()
-- Type: FUNCTION

-- Name: labfih_db_backup(); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labfih';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labfih_article as select * from labfih.labfih_article';
    execute 'create table '||v_backupschemaname||'.labfih_article_asset_map as select * from labfih.labfih_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labfih_video as select * from labfih.labfih_video';
    execute 'create table '||v_backupschemaname||'.labfih_album as select * from labfih.labfih_album';
    execute 'create table '||v_backupschemaname||'.labfih_album_asset_map as select * from labfih.labfih_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labfih_image as select * from labfih.labfih_image';
    execute 'create table '||v_backupschemaname||'.labfih_author_action as select * from labfih.labfih_author_action';
    execute 'create table '||v_backupschemaname||'.labfih_user as select * from labfih.labfih_user';
    execute 'create table '||v_backupschemaname||'.labfih_seo_data as select * from labfih.labfih_seo_data';
    execute 'create table '||v_backupschemaname||'.labfih_topic as select * from labfih.labfih_topic';
    execute 'create table '||v_backupschemaname||'.labfih_topic_asset_map as select * from labfih.labfih_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labfih_poll as select * from labfih.labfih_poll';
    execute 'create table '||v_backupschemaname||'.labfih_poll_option as select * from labfih.labfih_poll_option';
    execute 'create table '||v_backupschemaname||'.labfih_poll_response as select * from labfih.labfih_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
