-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_db_backup()
-- Type: FUNCTION

-- Name: labmao_db_backup(); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labmao';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labmao_article as select * from labmao.labmao_article';
    execute 'create table '||v_backupschemaname||'.labmao_article_asset_map as select * from labmao.labmao_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labmao_video as select * from labmao.labmao_video';
    execute 'create table '||v_backupschemaname||'.labmao_album as select * from labmao.labmao_album';
    execute 'create table '||v_backupschemaname||'.labmao_album_asset_map as select * from labmao.labmao_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labmao_image as select * from labmao.labmao_image';
    execute 'create table '||v_backupschemaname||'.labmao_author_action as select * from labmao.labmao_author_action';
    execute 'create table '||v_backupschemaname||'.labmao_user as select * from labmao.labmao_user';
    execute 'create table '||v_backupschemaname||'.labmao_seo_data as select * from labmao.labmao_seo_data';
    execute 'create table '||v_backupschemaname||'.labmao_topic as select * from labmao.labmao_topic';
    execute 'create table '||v_backupschemaname||'.labmao_topic_asset_map as select * from labmao.labmao_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labmao_poll as select * from labmao.labmao_poll';
    execute 'create table '||v_backupschemaname||'.labmao_poll_option as select * from labmao.labmao_poll_option';
    execute 'create table '||v_backupschemaname||'.labmao_poll_response as select * from labmao.labmao_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
