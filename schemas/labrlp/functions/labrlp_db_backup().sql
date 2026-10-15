-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_db_backup()
-- Type: FUNCTION

-- Name: labrlp_db_backup(); Type: FUNCTION; Schema: labrlp; Owner: -
--

CREATE FUNCTION labrlp.labrlp_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labrlp';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labrlp_article as select * from labrlp.labrlp_article';
    execute 'create table '||v_backupschemaname||'.labrlp_article_asset_map as select * from labrlp.labrlp_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labrlp_video as select * from labrlp.labrlp_video';
    execute 'create table '||v_backupschemaname||'.labrlp_album as select * from labrlp.labrlp_album';
    execute 'create table '||v_backupschemaname||'.labrlp_album_asset_map as select * from labrlp.labrlp_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labrlp_image as select * from labrlp.labrlp_image';
    execute 'create table '||v_backupschemaname||'.labrlp_author_action as select * from labrlp.labrlp_author_action';
    execute 'create table '||v_backupschemaname||'.labrlp_user as select * from labrlp.labrlp_user';
    execute 'create table '||v_backupschemaname||'.labrlp_seo_data as select * from labrlp.labrlp_seo_data';
    execute 'create table '||v_backupschemaname||'.labrlp_topic as select * from labrlp.labrlp_topic';
    execute 'create table '||v_backupschemaname||'.labrlp_topic_asset_map as select * from labrlp.labrlp_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labrlp_poll as select * from labrlp.labrlp_poll';
    execute 'create table '||v_backupschemaname||'.labrlp_poll_option as select * from labrlp.labrlp_poll_option';
    execute 'create table '||v_backupschemaname||'.labrlp_poll_response as select * from labrlp.labrlp_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
