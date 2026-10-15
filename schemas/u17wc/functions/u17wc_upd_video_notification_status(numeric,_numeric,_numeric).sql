-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_upd_video_notification_status(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: u17wc_upd_video_notification_status(numeric, numeric, numeric); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_upd_video_notification_status(p_videoid numeric, p_versionnumber numeric, p_status numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

begin
	
    if exists(select 1 from u17wc.u17wc_video_notification_map where video_id = p_videoid) then
    	
        update u17wc.u17wc_video_notification_map set status = p_status where video_id = p_videoid;
        
        update u17wc.u17wc_asset_draft
        set asset_data = jsonb_set(asset_data, '{data,trigger_notification}', p_status::text::jsonb, true)
        where asset_id = p_videoid
        and asset_type_id = 4
        and version_number = p_versionnumber;
        
        p_result := 0;
        
    else
    	
        p_result := 0;
        
    end if;
    
end;

$$;


--
