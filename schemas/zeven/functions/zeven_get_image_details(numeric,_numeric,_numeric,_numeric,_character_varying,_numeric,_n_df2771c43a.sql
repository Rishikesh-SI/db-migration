-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_image_details(numeric, numeric, numeric, numeric, character varying, numeric, numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_image_details(numeric, numeric, numeric, numeric, character varying, numeric, numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_image_details(p_userid numeric, p_venue_masterid numeric, p_is_zeven_uploads numeric, p_is_user_uploads numeric, p_review_ids character varying, p_type numeric, p_page_number numeric, p_item_count numeric, p_cur_image refcursor, p_cur_image_cnt refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare 
v_sql varchar(2000) = ' ';
v_from_row_number	numeric = 0;
v_to_row_number	numeric = 0;
v_valid_user numeric = 0;

begin

  
  select	count(1)
  into    v_valid_user
  from    zeven.zeven_web_user    
  where   user_id = p_userid;
  
  v_from_row_number := (p_item_count * p_page_number - (p_item_count-1));
  v_to_row_number := (p_item_count * p_page_number);
  
  if p_is_zeven_uploads = 1 and p_type = 1 then
    open p_cur_image for
      select  photo_id,image_name,play_activity_type_id,play_activity_ref_id,facility_id,user_id,
              is_saved,is_deleted,is_zeven_published,is_published,img_extension,img_courtesy
      from    (
               select   row_number () over ( order by created_date desc) as order_no,
                        photo_id,image_name,play_activity_type_id,play_activity_ref_id,facility_id,user_id,
                        is_saved,is_deleted,is_zeven_published,is_published,created_date,updated_date ,img_extension,img_courtesy
                from    zeven.zeven_pic_play_usr_act_map
                where   is_zeven_published = 1
                        and
                        is_published in (1,3)
                        and
                        facility_id = p_venue_masterid
                        and
                        is_saved = 1
                        and
                        is_deleted = 0
              )a
      where order_no between v_from_row_number and v_to_row_number 
      order by created_date desc;
      
      open p_cur_image_cnt for
        select   count(1) as cnt
        from    zeven.zeven_pic_play_usr_act_map
        where   is_zeven_published = 1
                and
                is_published in (1,3)
                and
                facility_id = p_venue_masterid
                and
                is_saved = 1
                and
                is_deleted = 0;
  end if;
  
  if p_is_user_uploads = 1 and p_type = 2 then
    open p_cur_image for
      select  photo_id,image_name,play_activity_type_id,play_activity_ref_id,facility_id,user_id,
              is_saved,is_deleted,is_zeven_published,is_published,img_extension,img_courtesy
      from    (
               select   row_number () over ( order by created_date desc) as order_no,
                        photo_id,image_name,play_activity_type_id,play_activity_ref_id,facility_id,user_id,
                        is_saved,is_deleted,is_zeven_published,is_published,created_date,updated_date ,img_extension,img_courtesy
                from    zeven.zeven_pic_play_usr_act_map
                where   is_published in (1,3)
                        and
                        coalesce(user_id,0) > 0 
                        and
                        facility_id = p_venue_masterid
                        and
                        is_saved = 1
                        and
                        is_deleted = 0
              )a
      where order_no between v_from_row_number and v_to_row_number 
      order by created_date desc;
      
       open p_cur_image_cnt for
        select  count(1) as cnt
        from    zeven.zeven_pic_play_usr_act_map
        where   is_published in (1,3)
                and
                coalesce(user_id,0) > 0 
                and
                facility_id = p_venue_masterid
                and
                is_saved = 1
                and
                is_deleted = 0;
  end if;
  
  if p_userid is not null and p_type = 3 and v_valid_user = 1 then
    open p_cur_image for
      select  photo_id,image_name,play_activity_type_id,play_activity_ref_id,facility_id,user_id,
              is_saved,is_deleted,is_zeven_published,is_published,img_extension,img_courtesy
      from    (
               select   row_number () over ( order by created_date desc) as order_no,
                        photo_id,image_name,play_activity_type_id,play_activity_ref_id,facility_id,user_id,
                        is_saved,is_deleted,is_zeven_published,is_published ,created_date,updated_date,img_extension,img_courtesy
                from    zeven.zeven_pic_play_usr_act_map
                where   is_published in (1,3)
                        and
                        user_id = p_userid
                        and
                        is_saved = 1
                        and
                        is_deleted = 0
                )a
      where order_no between v_from_row_number and v_to_row_number 
      order by created_date desc;
      
      open p_cur_image_cnt for
        select  count(1) as cnt
        from    zeven.zeven_pic_play_usr_act_map
                where   is_published in (1,3)
                        and
                        user_id = p_userid
                        and
                        is_saved = 1
                        and
                        is_deleted = 0;
  end if;
  
  if p_review_ids is not null and p_type  = 4 then
    /*v_sql := '
             select   photo_id,image_name,play_activity_type_id,play_activity_ref_id,facility_id,user_id,
                      is_saved,is_deleted,is_zeven_published,is_published ,created_date,updated_date,img_extension,img_courtesy
              from    zeven.zeven_pic_play_usr_act_map
              where   is_published in (1,3)
                      and
                      play_activity_ref_id in (' || p_review_ids || ')
                      and
                      play_activity_type_id = 2
                      and
                      facility_id = ' || p_venue_masterid || '
                      and
                      is_saved = 1
                      and
                      is_deleted = 0
              order by created_date desc ';
              
    open p_cur_image for v_sql;*/
    
    open p_cur_image for execute '
             select   photo_id,image_name,play_activity_type_id,play_activity_ref_id,facility_id,user_id,
                      is_saved,is_deleted,is_zeven_published,is_published ,created_date,updated_date,img_extension,img_courtesy
              from    zeven.zeven_pic_play_usr_act_map
              where   is_published in (1,3)
                      and
                      play_activity_ref_id in (' || p_review_ids || ')
                      and
                      play_activity_type_id = 2
                      and
                      facility_id = ' || p_venue_masterid || '
                      and
                      is_saved = 1
                      and
                      is_deleted = 0
              order by created_date desc ';
    
    open p_cur_image_cnt for
        execute ' select  count(1) as cnt
          from    zeven.zeven_pic_play_usr_act_map
          where   is_published in (1,3)
                  and
                  play_activity_ref_id in (' || p_review_ids || ')
                  and
                  play_activity_type_id = 2
                  and
                  facility_id = ' || p_venue_masterid || '
                  and
                  is_saved = 1
                  and
                  is_deleted = 0';
  end if;
  
end;

$$;


--
