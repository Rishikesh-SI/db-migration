-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_review_details(numeric, numeric, numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_review_details(numeric, numeric, numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_review_details(p_userid numeric, p_venue_masterid numeric, p_page_number numeric, p_item_count numeric, p_sort_order numeric, p_cur_review refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare 
v_from_row_number	numeric = 0;
v_to_row_number	numeric = 0;
v_valid_user numeric = 0;

begin

  v_from_row_number := (p_item_count * p_page_number - (p_item_count-1));
  v_to_row_number := (p_item_count * p_page_number);
  
  if p_userid is not null then
    select	count(1)
    into    v_valid_user
    from    zeven.zeven_web_user    
    where   user_id = p_userid;
    
    if v_valid_user = 1 then
      open p_cur_review for
        select *
        from    (
                  select  row_number () over ( order by rt.updated_date desc) as order_no,
                          cr.zeven_comment_reviewid,u.user_id,u.social_user_name,u.user_full_name,cr.venue_masterid,cr.venue_parentid,cr.comment_review_text,
                          rt.created_date,rt.updated_date,cr.comment_review_title,rt.ratings,check_ins,u.user_guid,u.client_id,u.social_id,rt.zeven_ratingid
                  from    zeven.zeven_rating rt
                  inner join  zeven.zeven_web_user u
                          on  u.user_id = rt.user_id
                  left join   zeven.zeven_comment_review cr 
                          on  cr.zeven_comment_reviewid = rt.zeven_comment_reviewid
                              and
                              is_published <> -1
                  left join   (
                                select  count(1) as check_ins,venue_masterid
                                from    zeven.zeven_venue_checkins
                                where   user_id = p_userid
                                group by venue_masterid
                              )r
                          on  r.venue_masterid = cr.venue_masterid
                  where   rt.user_id = p_userid
                          
                )a
       where order_no between v_from_row_number and v_to_row_number 
       order by updated_date desc;
     end if;                     
    end if; 
    
    if p_venue_masterid is not null then
      if p_sort_order = 1 then
        open p_cur_review for
        select *
        from    (
                  select  row_number () over ( order by rt.updated_date desc) as order_no,
                          cr.zeven_comment_reviewid,u.user_id,u.social_user_name,u.user_full_name,cr.venue_masterid,cr.venue_parentid,cr.comment_review_text,
                          rt.created_date,rt.updated_date,cr.comment_review_title,rt.ratings,check_ins,u.user_guid,u.client_id,u.social_id,rt.zeven_ratingid,
                          coalesce(rating.counts,0) total_ratings
                  from    zeven.zeven_rating rt
                  inner join  zeven.zeven_web_user u
                          on  u.user_id = rt.user_id
                  left join   zeven.zeven_comment_review cr 
                          on  cr.zeven_comment_reviewid = rt.zeven_comment_reviewid
                              and
                              is_published <> -1
                  left join   (
                                select  count(1) as check_ins,user_id
                                from    zeven.zeven_venue_checkins
                                where   venue_masterid = p_venue_masterid
                                group by user_id
                              )r
                          on  r.user_id = cr.user_id
                 left join   (
                                select  count(1) as counts,user_id
                                from    zeven.zeven_rating
                                group by user_id
                              )rating
                          on  rating.user_id = rt.user_id 
                  where   rt.venue_masterid = p_venue_masterid
                  order by updated_date desc
                )a
       where order_no between v_from_row_number and v_to_row_number ;
    end if;
    
    if p_sort_order = 2 then
        open p_cur_review for
        select *
        from    (
                  select  row_number () over ( order by rt.ratings desc nulls last) as order_no,
                          cr.zeven_comment_reviewid,u.user_id,u.social_user_name,u.user_full_name,cr.venue_masterid,cr.venue_parentid,cr.comment_review_text,
                          rt.created_date,rt.updated_date,cr.comment_review_title,rt.ratings,check_ins,u.user_guid,u.client_id,u.social_id,rt.zeven_ratingid,
                          coalesce(rating.counts,0) total_ratings
                  from    zeven.zeven_rating rt
                  inner join  zeven.zeven_web_user u
                          on  u.user_id = rt.user_id
                  left join   zeven.zeven_comment_review cr
                          on  cr.zeven_comment_reviewid = rt.zeven_comment_reviewid
                              and
                              is_published <> -1
                  left join   (
                                select  count(1) as check_ins,user_id
                                from    zeven.zeven_venue_checkins
                                where   venue_masterid = p_venue_masterid
                                group by user_id
                              )r
                          on  r.user_id = cr.user_id
                  left join   (
                                select  count(1) as counts,user_id
                                from    zeven.zeven_rating
                                group by user_id
                              )rating
                          on  rating.user_id = rt.user_id 
                  where   rt.venue_masterid = p_venue_masterid
                  order by ratings desc nulls last
                )a
       where order_no between v_from_row_number and v_to_row_number ;
    end if;
    
    if p_sort_order = 3 then
        open p_cur_review for
        select *
        from    (
                  select  row_number () over ( order by rt.ratings asc nulls last,rt.updated_date desc) as order_no,
                          cr.zeven_comment_reviewid,u.user_id,u.social_user_name,u.user_full_name,cr.venue_masterid,cr.venue_parentid,cr.comment_review_text,
                          rt.created_date,rt.updated_date,cr.comment_review_title,rt.ratings,check_ins,u.user_guid,u.client_id,u.social_id,rt.zeven_ratingid,
                          coalesce(rating.counts,0) total_ratings
                  from    zeven.zeven_rating rt
                  inner join  zeven.zeven_web_user u
                          on  u.user_id = rt.user_id
                  left join   zeven.zeven_comment_review cr
                          on  cr.zeven_comment_reviewid = rt.zeven_comment_reviewid
                              and
                              is_published <> -1
                  left join   (
                                select  count(1) as check_ins,user_id
                                from    zeven.zeven_venue_checkins
                                where   venue_masterid = p_venue_masterid
                                group by user_id
                              )r
                          on  r.user_id = cr.user_id
                  left join   (
                                select  count(1) as counts,user_id
                                from    zeven.zeven_rating
                                group by user_id
                              )rating
                          on  rating.user_id = rt.user_id 
                  where   rt.venue_masterid = p_venue_masterid
                  order by ratings asc nulls last,updated_date desc
                )a
       where order_no between v_from_row_number and v_to_row_number ;
    end if;
  end if;
end;

$$;


--
