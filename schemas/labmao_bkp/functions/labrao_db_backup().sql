-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labrao_db_backup()
-- Type: FUNCTION

-- Name: labrao_db_backup(); Type: FUNCTION; Schema: labmao_bkp; Owner: -
--

CREATE FUNCTION labmao_bkp.labrao_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labrao';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labrao_article as select * from labrao.labrao_article';
    execute 'create table '||v_backupschemaname||'.labrao_article_asset_map as select * from labrao.labrao_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labrao_video as select * from labrao.labrao_video';
    execute 'create table '||v_backupschemaname||'.labrao_album as select * from labrao.labrao_album';
    execute 'create table '||v_backupschemaname||'.labrao_album_asset_map as select * from labrao.labrao_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labrao_image as select * from labrao.labrao_image';
    execute 'create table '||v_backupschemaname||'.labrao_author_action as select * from labrao.labrao_author_action';
    execute 'create table '||v_backupschemaname||'.labrao_user as select * from labrao.labrao_user';
    execute 'create table '||v_backupschemaname||'.labrao_seo_data as select * from labrao.labrao_seo_data';
    execute 'create table '||v_backupschemaname||'.labrao_topic as select * from labrao.labrao_topic';
    execute 'create table '||v_backupschemaname||'.labrao_topic_asset_map as select * from labrao.labrao_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labrao_poll as select * from labrao.labrao_poll';
    execute 'create table '||v_backupschemaname||'.labrao_poll_option as select * from labrao.labrao_poll_option';
    execute 'create table '||v_backupschemaname||'.labrao_poll_response as select * from labrao.labrao_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
