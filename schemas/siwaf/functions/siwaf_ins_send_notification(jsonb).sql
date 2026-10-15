-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_ins_send_notification(jsonb)
-- Type: FUNCTION

-- Name: siwaf_ins_send_notification(jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf.siwaf_ins_send_notification(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	v_client_name	varchar;
	is_active		numeric;
	is_deleted			numeric;
	v_notification_id	varchar;
	v_message_node		jsonb;
	v_GCM_node			jsonb;
	v_title				varchar;
	v_Total_No_of_Subscriptions numeric;
	v_Total_No_of_Notification_Sent numeric;
	v_IOS_Device_Count numeric;
	v_Android_Device_Count numeric;
	v_noti_mssg character varying;
	v_asset_type character varying;
	v_campaign_id character varying;
begin
	select p_json->'data'->>'clientid',
	p_json->'data'->>'notificationid'
	into
	v_client_name,
	v_notification_id;
	select p_json->'data'->>'message' into v_message_node;
	--raise notice '%' , v_message_node;
	select v_message_node->>'GCM' into v_GCM_node;
	--raise notice '%' , v_GCM_node;
	select v_GCM_node->'data'->'alert'->>'title' into v_title;
	--raise notice '%' , v_title;
	select v_GCM_node->'data'->>'message' into v_noti_mssg;
	
	select v_GCM_node->'data'->>'asset_type' into v_asset_type;
	
	select v_GCM_node->'data'->>'campaign_id' into v_campaign_id;
	raise notice 'v_asset_type %' , v_asset_type;
	
	insert into siwaf.siwaf_send_notification 
    values(nextval('siwaf.siwaf_seq_notification_data_id '),
           v_client_name,current_timestamp,current_timestamp,1,0
           ,p_json,v_notification_id,v_title,
           v_asset_type,v_campaign_id,v_noti_mssg);
	p_result =1;
	
end;
$$;


--
