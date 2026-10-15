-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_venue_details(numeric, numeric, character varying, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_user_venue_details(numeric, numeric, character varying, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_user_venue_details(p_userid numeric, p_venue_masterid numeric, p_review_ids character varying, p_cur_bookmark refcursor, p_cur_user_review refcursor, p_cur_user_rating refcursor, p_cur_user_review_img refcursor, p_cur_want_to_play refcursor, p_user_report_abuse_reviews refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare 
v_valid_user numeric = 0;
v_want_to_play_cnt numeric = 0;
v_user_review_id    numeric ;

begin

  select	count(1)
  into    v_valid_user
  from    zeven.zeven_web_user    
  where   user_id = p_userid;
  
  select  count(1)
  into    v_want_to_play_cnt
  from    zeven.zeven_want_to_play
  where   venue_masterid = p_venue_masterid
          and
          user_id = p_userid;
      
  begin     
    select  zeven_comment_reviewid
    into    v_user_review_id
    from    zeven.zeven_comment_review
    where   user_id = p_userid
            and
            venue_masterid = p_venue_masterid;
  exception 
    when no_data_found then
    v_user_review_id := null; 
  end;    
  
  
  if v_valid_user = 1 then
    open p_cur_bookmark for
      select  count(1) as bookmark
      from    zeven.zeven_venue_bookmark
      where   user_id = p_userid
              and
              venue_masterid = p_venue_masterid;
      
    open p_cur_user_review for
      select  cr.zeven_comment_reviewid,cr.user_id,u.user_name,cr.venue_masterid,cr.venue_parentid,cr.comment_review_text,
              cr.created_date,cr.updated_date,cr.comment_review_title,u.clientid,u.socialid
      from    zeven.zeven_comment_review cr
      inner join zeven.zeven_web_user u
              on u.user_id = cr.user_id
      where   cr.user_id = p_userid
              and
              cr.venue_masterid = p_venue_masterid
              and
              is_published <> -1;
              
     open p_cur_user_rating for
      select  ratings
      from    zeven.zeven_rating r
      where   venue_masterid = p_venue_masterid
              and
              user_id = p_userid; 
       
      open p_cur_user_review_img for 
        select  photo_id,image_name,img_extension
        from    zeven.zeven_pic_play_usr_act_map
        where   play_activity_ref_id = v_user_review_id
                and
                play_activity_type_id = 2
                and
                facility_id = p_venue_masterid
                and
                user_id = p_userid
                and
                is_saved = 1
                and
                is_published in (1,3)
                and is_deleted = 0;
        
      
      open p_cur_want_to_play for
        select v_want_to_play_cnt as want_to_play_cnt from dual;
       
    if length(p_review_ids) > 0 then
     open p_user_report_abuse_reviews for execute ' select  zeven_comment_reviewid,case when track_user_activityid is null then 0 else 1 end report_abuse_flag
                from    zeven.zeven_comment_review cr
                left join zeven.zeven_track_user_activity  tr
                      on  tr.articleid = cr.zeven_comment_reviewid 
                          and tr.activityid = 18
                          and tr.user_id = ' || p_userid || '
                where     zeven_comment_reviewid  in ( ' || p_review_ids || ' )';
                          

    else
      open p_user_report_abuse_reviews for
        select '' as zeven_comment_reviewid,'' as report_abuse_flag
      from    dual;
   end if;
    
     
  end if;
end;
$$;


--
