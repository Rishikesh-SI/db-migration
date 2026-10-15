-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_admin_get_img_review(numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_admin_get_img_review(numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_admin_get_img_review(p_opt_type numeric, p_is_published numeric, p_page_number numeric, p_items_number numeric, p_ret refcursor, p_cur_get_curation_cnt refcursor, p_cur_get_curation refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare 
v_from_row_number	numeric = 0;
v_to_row_number	numeric = 0;

begin
 

    
  v_from_row_number := (p_items_number * p_page_number - (p_items_number-1));
  v_to_row_number := (p_items_number * p_page_number);

    if p_opt_type = 1 then
      

      open p_cur_get_curation_cnt for 
        select count(1) counts
      from zeven.zeven_comment_review zcr
      left join zeven.zeven_web_user zu
      on   zu.user_id = zcr.userid and zu.is_active = 1
      left join zeven.zeven_venue_master zvm
      on   zvm.venue_masterid = zcr.venue_masterid
      where zcr.is_published  = p_is_published;
      

      open p_cur_get_curation for 
      select *
      from
      (select row_number() over (order by zcr.created_date desc) order_no,
               zcr.zeven_comment_reviewid,
               zcr.userid,
               zu.full_name,
               zcr.venue_masterid,
               zvm.venue_name,
               zcr.type,
               zcr.comment_review_title,
               zcr.comment_review_text,    
               zcr.is_published,
               zcr.created_date
      from zeven.zeven_comment_review zcr
      left join zeven.zeven_web_user zu
      on   zu.user_id = zcr.userid and zu.is_active = 1
      left join zeven.zeven_venue_master zvm
      on   zvm.venue_masterid = zcr.venue_masterid
      where zcr.is_published  = p_is_published)tab
      where  order_no between  v_from_row_number and v_to_row_number;
   
        
     open p_ret for select 1;
     
  end if;
  

end;
$$;


--
