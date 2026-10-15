-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_db_backup()
-- Type: FUNCTION

-- Name: labmcfc_v1_db_backup(); Type: FUNCTION; Schema: labmcfc_v1; Owner: -
--

CREATE FUNCTION labmcfc_v1.labmcfc_v1_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labmcfc_v1';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_article as select * from labmcfc_v1.labmcfc_v1_article';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_article_asset_map as select * from labmcfc_v1.labmcfc_v1_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_video as select * from labmcfc_v1.labmcfc_v1_video';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_album as select * from labmcfc_v1.labmcfc_v1_album';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_album_asset_map as select * from labmcfc_v1.labmcfc_v1_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_image as select * from labmcfc_v1.labmcfc_v1_image';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_author_action as select * from labmcfc_v1.labmcfc_v1_author_action';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_user as select * from labmcfc_v1.labmcfc_v1_user';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_seo_data as select * from labmcfc_v1.labmcfc_v1_seo_data';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_topic as select * from labmcfc_v1.labmcfc_v1_topic';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_topic_asset_map as select * from labmcfc_v1.labmcfc_v1_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_poll as select * from labmcfc_v1.labmcfc_v1_poll';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_poll_option as select * from labmcfc_v1.labmcfc_v1_poll_option';
    execute 'create table '||v_backupschemaname||'.labmcfc_v1_poll_response as select * from labmcfc_v1.labmcfc_v1_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
