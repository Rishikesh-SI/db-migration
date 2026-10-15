-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_poll_detail_r(numeric, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: stn_get_poll_detail_r(numeric, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_poll_detail_r(p_pollid numeric, p_poll_cur refcursor, p_option_cur refcursor, p_author_cur refcursor, p_poll_responce_cur refcursor, p_poll_image_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_authorjsonarr jsonb[];
     v_poll_responcearray jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     v_json2 varchar(30000) := '{"Poll_Response":[';
     v_author_count numeric;
     v_resp_count numeric;
     v_poll_responsejson jsonb;
     
     v_sysdate timestamp;
begin
      v_sysdate:= current_timestamp at time zone 'utc';
      
      open p_poll_cur for
     SELECT * FROM stn.stn_POLL WHERE POLL_ID=p_pollid and is_published=1 and is_trashed=0
  and start_date<=v_sysdate 
    ;
     
      open p_option_cur for
     SELECT * FROM stn.stn_POLL_OPTION WHERE POLL_ID=p_pollid and is_active=1 and is_deleted=0;
     
     open p_author_cur for
     SELECT * FROM stn.stn_AUTHOr_ACTION WHERE ASSET_ID=p_pollid and asset_type_id =6 ;
     
     open p_poll_responce_cur for
     select 
            response_option_id as option_id,
            count(response_count) as response_count
            from stn.stn_poll_response
            where poll_id=p_pollid 
            group by response_option_id   ;
     
     open p_poll_image_cur for
     select asset_id,pa.asset_type_id,image_path,image_file_name image_name,is_cover
     from stn.stn_poll_asset_map pa
     join stn.stn_image i
     on pa.asset_id=i.image_id
     and pa.asset_type_id=3 
     where pa.poll_id=p_pollid;
    
end;

$$;


--
