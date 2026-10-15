-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_db_backup()
-- Type: FUNCTION

-- Name: labmcfc_db_backup(); Type: FUNCTION; Schema: labmcfc; Owner: -
--

CREATE FUNCTION labmcfc.labmcfc_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labmcfc';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labmcfc_article as select * from labmcfc.labmcfc_article';
    execute 'create table '||v_backupschemaname||'.labmcfc_article_asset_map as select * from labmcfc.labmcfc_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labmcfc_video as select * from labmcfc.labmcfc_video';
    execute 'create table '||v_backupschemaname||'.labmcfc_album as select * from labmcfc.labmcfc_album';
    execute 'create table '||v_backupschemaname||'.labmcfc_album_asset_map as select * from labmcfc.labmcfc_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labmcfc_image as select * from labmcfc.labmcfc_image';
    execute 'create table '||v_backupschemaname||'.labmcfc_author_action as select * from labmcfc.labmcfc_author_action';
    execute 'create table '||v_backupschemaname||'.labmcfc_user as select * from labmcfc.labmcfc_user';
    execute 'create table '||v_backupschemaname||'.labmcfc_seo_data as select * from labmcfc.labmcfc_seo_data';
    execute 'create table '||v_backupschemaname||'.labmcfc_topic as select * from labmcfc.labmcfc_topic';
    execute 'create table '||v_backupschemaname||'.labmcfc_topic_asset_map as select * from labmcfc.labmcfc_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labmcfc_poll as select * from labmcfc.labmcfc_poll';
    execute 'create table '||v_backupschemaname||'.labmcfc_poll_option as select * from labmcfc.labmcfc_poll_option';
    execute 'create table '||v_backupschemaname||'.labmcfc_poll_response as select * from labmcfc.labmcfc_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
