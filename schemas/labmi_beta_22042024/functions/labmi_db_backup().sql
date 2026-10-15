-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_db_backup()
-- Type: FUNCTION

-- Name: labmi_db_backup(); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_db_backup(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_sourceschemaname varchar(20) := 'labmi';
    v_currentdate varchar(8) := replace(current_date::text,'-','');
    v_backupschemaname varchar(20) := v_sourceschemaname||v_currentdate;
    
begin
	
    execute 'create schema '||v_backupschemaname;
    execute 'create table '||v_backupschemaname||'.labmi_article as select * from labmi.labmi_article';
    execute 'create table '||v_backupschemaname||'.labmi_article_asset_map as select * from labmi.labmi_article_asset_map';
    execute 'create table '||v_backupschemaname||'.labmi_video as select * from labmi.labmi_video';
    execute 'create table '||v_backupschemaname||'.labmi_album as select * from labmi.labmi_album';
    execute 'create table '||v_backupschemaname||'.labmi_album_asset_map as select * from labmi.labmi_album_asset_map';
    execute 'create table '||v_backupschemaname||'.labmi_image as select * from labmi.labmi_image';
    execute 'create table '||v_backupschemaname||'.labmi_author_action as select * from labmi.labmi_author_action';
    execute 'create table '||v_backupschemaname||'.labmi_user as select * from labmi.labmi_user';
    execute 'create table '||v_backupschemaname||'.labmi_seo_data as select * from labmi.labmi_seo_data';
    execute 'create table '||v_backupschemaname||'.labmi_topic as select * from labmi.labmi_topic';
    execute 'create table '||v_backupschemaname||'.labmi_topic_asset_map as select * from labmi.labmi_topic_asset_map';
    execute 'create table '||v_backupschemaname||'.labmi_poll as select * from labmi.labmi_poll';
    execute 'create table '||v_backupschemaname||'.labmi_poll_option as select * from labmi.labmi_poll_option';
    execute 'create table '||v_backupschemaname||'.labmi_poll_response as select * from labmi.labmi_poll_response';
    
    p_result := 1;
    
end;

 $$;


--
