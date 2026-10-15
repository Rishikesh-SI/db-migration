-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_pics_by_pub_type_admin(numeric, numeric, numeric, numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_pics_by_pub_type_admin(numeric, numeric, numeric, numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_pics_by_pub_type_admin(p_publish_type_id numeric, p_play_activity_type_id numeric, p_facility_id numeric, p_page_number numeric, p_items_number numeric, p_cur_pics_by_pub_type_cnt refcursor, p_cur_pics_by_pub_type refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare 
v_from_row_number	numeric = 0;
v_to_row_number	numeric = 0;

begin
 

  v_from_row_number := (p_items_number * p_page_number - (p_items_number-1));
  v_to_row_number := (p_items_number * p_page_number);
  
  
    if p_play_activity_type_id = 1 then
        
         if p_publish_type_id = -1 then
           
           open p_cur_pics_by_pub_type_cnt for
           select count(1) counts
           from zeven.zeven_pic_play_usr_act_map ppua
           inner join   zeven.zeven_venue_master zvm
           on        ppua.facility_id = zvm.venue_masterid and play_activity_type_id = 1 and zvm.is_active = 1
            where    play_activity_type_id = p_play_activity_type_id
            and         ppua.is_deleted = 0
            and         ppua.is_saved   = 1
            and ppua.photo_id in (select ztua.articleid
                                          from zeven.zeven_track_user_activity ztua
                                          where ztua.activityid in (17)
                                          group by ztua.articleid,ztua.activityid
                                          having count(1) > 2);
        
            open p_cur_pics_by_pub_type for
           select  
                  row_number() over (order by ppua.photo_id) order_no,
                  ppua.photo_id,
                  ppua.image_name,
                  ppua.img_extension,
                  ppua.img_courtesy,
                  ppua.play_activity_type_id,
                  ppua.play_activity_ref_id,
                  ppua.facility_id,
                  zvm.venue_name,
                  zvm.created_date
            from zeven.zeven_pic_play_usr_act_map ppua
             inner join   zeven.zeven_venue_master zvm
              on        ppua.facility_id = zvm.venue_masterid and play_activity_type_id = 1 and zvm.is_active = 1
            where  play_activity_type_id = p_play_activity_type_id
            and         ppua.is_deleted = 0
            and         ppua.is_saved   = 1
            and ppua.photo_id in (select ztua.articleid
                                          from zeven.zeven_track_user_activity ztua
                                          where ztua.activityid in (17)
                                          group by ztua.articleid,ztua.activityid
                                          having count(1) > 2);
                                          
        else
        
            open p_cur_pics_by_pub_type_cnt for
            select count(1) counts
            from        zeven.zeven_pic_play_usr_act_map ppua
              inner join   zeven.zeven_venue_master zvm
              on          ppua.facility_id = zvm.venue_masterid and play_activity_type_id = 1 and zvm.is_active = 1
              where       ppua.is_published = p_publish_type_id
              and         ppua.facility_id  = coalesce(p_facility_id,ppua.facility_id)
              and         ppua.is_deleted = 0
              and         ppua.is_saved   = 1;
              
            
              open p_cur_pics_by_pub_type for
              select * 
                from(select    row_number() over (order by ppua.photo_id) order_no,
                          ppua.photo_id,
                          ppua.image_name,
                          ppua.img_extension,
                          ppua.img_courtesy,
                          ppua.play_activity_type_id,
                          ppua.play_activity_ref_id,
                          ppua.facility_id,
                          zvm.venue_name,
                          zvm.created_date
              from        zeven.zeven_pic_play_usr_act_map ppua
              inner join   zeven.zeven_venue_master zvm
              on          ppua.facility_id = zvm.venue_masterid and play_activity_type_id = 1 and zvm.is_active = 1
              where       ppua.is_published = p_publish_type_id
              and         ppua.facility_id  = coalesce(p_facility_id,ppua.facility_id)
              and         ppua.is_deleted = 0
              and         ppua.is_saved   = 1) tab
              where order_no between  v_from_row_number and v_to_row_number;
              
              end if;    
    
  elsif  p_play_activity_type_id = 2  then
  
      if p_publish_type_id = -1 then
           
           open p_cur_pics_by_pub_type_cnt for
           select count(1) counts
           from zeven.zeven_pic_play_usr_act_map ppua
           inner join   zeven.zeven_venue_master zvm
           on        ppua.facility_id = zvm.venue_masterid and play_activity_type_id = 1 and zvm.is_active = 1
            where    play_activity_type_id = p_play_activity_type_id
            and         ppua.is_deleted = 0
            and         ppua.is_saved   = 1
            and ppua.photo_id in (select ztua.articleid
                                          from zeven.zeven_track_user_activity ztua
                                          where ztua.activityid in (17)
                                          group by ztua.articleid,ztua.activityid
                                          having count(1) > 2);
        
            open p_cur_pics_by_pub_type for
           select  
                  row_number() over (order by ppua.photo_id) order_no,
                  ppua.photo_id,
                  ppua.image_name,
                  ppua.img_extension,
                  ppua.img_courtesy,
                  ppua.play_activity_type_id,
                  ppua.play_activity_ref_id,
                  ppua.facility_id,
                  zvm.venue_name,
                  zvm.created_date
            from zeven.zeven_pic_play_usr_act_map ppua
             inner join   zeven.zeven_venue_master zvm
              on        ppua.facility_id = zvm.venue_masterid and play_activity_type_id = 1 and zvm.is_active = 1
            where  play_activity_type_id = p_play_activity_type_id
            and         ppua.is_deleted = 0
            and         ppua.is_saved   = 1
            and ppua.photo_id in (select ztua.articleid
                                          from zeven.zeven_track_user_activity ztua
                                          where ztua.activityid in (17)
                                          group by ztua.articleid,ztua.activityid
                                          having count(1) > 2);
                                          
        else
        
     open p_cur_pics_by_pub_type_cnt for
       select count(1) counts
        from    zeven.zeven_pic_play_usr_act_map ppua
              inner join   zeven.zeven_comment_review zcr
              on          ppua.play_activity_ref_id = zcr.zeven_comment_reviewid and play_activity_type_id = 2 and zcr.is_published <> -1
              inner join  zeven.zeven_user zu
              on          ppua.user_id = zu.userid
              inner join  zeven.zeven_venue_master zvm
              on          ppua.facility_id = zvm.venue_masterid
              where       ppua.is_published = p_publish_type_id
              and         ppua.is_deleted = 0
              and         ppua.is_saved   = 1;
     
              open p_cur_pics_by_pub_type for  
                select *
                from (select    row_number() over (order by ppua.photo_id) order_no,
                                ppua.photo_id,
                                ppua.image_name,
                                ppua.img_extension,
                                ppua.img_courtesy,
                                ppua.play_activity_type_id,
                                ppua.play_activity_ref_id,
                                ppua.facility_id,
                                zcr.userid,
                                zu.user_name,
                                zcr.venue_masterid,
                                zvm.venue_name,
                                zcr.comment_review_text,
                                zcr.created_date
                    from        zeven.zeven_pic_play_usr_act_map ppua
                    inner join   zeven.zeven_comment_review zcr
                    on          ppua.play_activity_ref_id = zcr.zeven_comment_reviewid and play_activity_type_id = 2 and zcr.is_published <> -1
                    inner join  zeven.zeven_web_user zu
                    on          ppua.user_id = zu.user_id
                    inner join  zeven.zeven_venue_master zvm
                    on          ppua.facility_id = zvm.venue_masterid
                    where       ppua.is_published = p_publish_type_id
                    and         ppua.is_deleted = 0
                    and         ppua.is_saved   = 1) tab
                where order_no between  v_from_row_number and v_to_row_number;
                
            end if;
      
    elsif  p_play_activity_type_id = 3  then
        
         if p_publish_type_id = -1 then
           
           open p_cur_pics_by_pub_type_cnt for
           select count(1) counts
           from zeven.zeven_pic_play_usr_act_map ppua
           inner join   zeven.zeven_venue_master zvm
           on        ppua.facility_id = zvm.venue_masterid and play_activity_type_id = 1 and zvm.is_active = 1
            where    play_activity_type_id = p_play_activity_type_id
            and         ppua.is_deleted = 0
            and         ppua.is_saved   = 1
            and ppua.photo_id in (select ztua.articleid
                                          from zeven.zeven_track_user_activity ztua
                                          where ztua.activityid in (17)
                                          group by ztua.articleid,ztua.activityid
                                          having count(1) > 2);
        
            open p_cur_pics_by_pub_type for
           select  
                  row_number() over (order by ppua.photo_id) order_no,
                  ppua.photo_id,
                  ppua.image_name,
                  ppua.img_extension,
                  ppua.img_courtesy,
                  ppua.play_activity_type_id,
                  ppua.play_activity_ref_id,
                  ppua.facility_id,
                  zvm.venue_name,
                  zvm.created_date
            from zeven.zeven_pic_play_usr_act_map ppua
             inner join   zeven.zeven_venue_master zvm
              on        ppua.facility_id = zvm.venue_masterid and play_activity_type_id = 1 and zvm.is_active = 1
            where  play_activity_type_id = p_play_activity_type_id
            and         ppua.is_deleted = 0
            and         ppua.is_saved   = 1
            and ppua.photo_id in (select ztua.articleid
                                          from zeven.zeven_track_user_activity ztua
                                          where ztua.activityid in (17)
                                          group by ztua.articleid,ztua.activityid
                                          having count(1) > 2);
                                          
        else
        
        open p_cur_pics_by_pub_type_cnt for  
          select count(1) counts
          from        zeven.zeven_pic_play_usr_act_map ppua
          inner join   zeven.zeven_user_journal zuj
          on          ppua.play_activity_ref_id = zuj.journal_id and play_activity_type_id = 3 and zuj.is_delete = 0
          inner join  zeven.zeven_user zu
          on          ppua.user_id = zu.userid 
          where       ppua.is_published = p_publish_type_id
          and         ppua.is_deleted = 0
          and         ppua.is_saved   = 1;
          
           open p_cur_pics_by_pub_type for 
                select * 
                 from(select   row_number() over (order by ppua.photo_id) order_no, 
                          ppua.photo_id,
                          ppua.image_name,
                          ppua.img_extension,
                          ppua.img_courtesy,
                          ppua.play_activity_type_id,
                          ppua.play_activity_ref_id,
                          ppua.facility_id,
                          zuj.user_id,
                          zu.user_name,
                          zuj.venue_id,
                          zuj.venue_name,
                          zuj.note,
                          zuj.created_date
              from        zeven.zeven_pic_play_usr_act_map ppua
              inner join   zeven.zeven_user_journal zuj
              on          ppua.play_activity_ref_id = zuj.journal_id and play_activity_type_id = 3 and zuj.is_delete = 0
              inner join  zeven.zeven_web_user zu
              on          ppua.user_id = zu.user_id 
              where       ppua.is_published = p_publish_type_id
              and         ppua.is_deleted = 0
              and         ppua.is_saved   = 1) tab
              where order_no between  v_from_row_number and v_to_row_number;
        
        end if;
   elsif  p_play_activity_type_id = 4  then
     
      if p_publish_type_id = -1 then
           
           open p_cur_pics_by_pub_type_cnt for
           select count(1) counts
           from zeven.zeven_pic_play_usr_act_map ppua
           inner join   zeven.zeven_venue_master zvm
           on        ppua.facility_id = zvm.venue_masterid and play_activity_type_id = 1 and zvm.is_active = 1
            where    play_activity_type_id = p_play_activity_type_id
            and         ppua.is_deleted = 0
            and         ppua.is_saved   = 1
            and ppua.photo_id in (select ztua.articleid
                                          from zeven.zeven_track_user_activity ztua
                                          where ztua.activityid in (17)
                                          group by ztua.articleid,ztua.activityid
                                          having count(1) > 2);
        
            open p_cur_pics_by_pub_type for
           select  
                  row_number() over (order by ppua.photo_id) order_no,
                  ppua.photo_id,
                  ppua.image_name,
                  ppua.img_extension,
                  ppua.img_courtesy,
                  ppua.play_activity_type_id,
                  ppua.play_activity_ref_id,
                  ppua.facility_id,
                  zvm.venue_name,
                  zvm.created_date
            from zeven.zeven_pic_play_usr_act_map ppua
             inner join   zeven.zeven_venue_master zvm
              on        ppua.facility_id = zvm.venue_masterid and play_activity_type_id = 1 and zvm.is_active = 1
            where  play_activity_type_id = p_play_activity_type_id
            and         ppua.is_deleted = 0
            and         ppua.is_saved   = 1
            and ppua.photo_id in (select ztua.articleid
                                          from zeven.zeven_track_user_activity ztua
                                          where ztua.activityid in (17)
                                          group by ztua.articleid,ztua.activityid
                                          having count(1) > 2);
                                          
        else
        
       open p_cur_pics_by_pub_type_cnt for  
         select count(1) counts
         from        zeven.zeven_pic_play_usr_act_map ppua
        inner join   zeven.zeven_venue_checkins zvc
        on          ppua.play_activity_ref_id = zvc.zeven_venue_checkinsid and play_activity_type_id = 3 
        inner join  zeven.zeven_web_user zu
        on          ppua.user_id = zu.user_id 
        inner join  zeven.zeven_venue_master zvm
        on          ppua.facility_id = zvm.venue_masterid
        where       ppua.is_published = p_publish_type_id
        and         ppua.is_deleted = 0
        and         ppua.is_saved   = 1;
     
          open p_cur_pics_by_pub_type for  
            select * 
               from (select row_number() over (order by ppua.photo_id) order_no,    
                          ppua.photo_id,
                          ppua.image_name,
                          ppua.img_extension,
                          ppua.img_courtesy,
                          ppua.play_activity_type_id,
                          ppua.play_activity_ref_id,
                          ppua.facility_id,
                          zvm.venue_name,
                          zvc.zeven_venue_checkinsid,
                          zvc.userid,
                          zu.user_name,
                          zvc.venue_masterid,
                          zvc.created_date
              from        zeven.zeven_pic_play_usr_act_map ppua
              inner join   zeven.zeven_venue_checkins zvc
              on          ppua.play_activity_ref_id = zvc.zeven_venue_checkinsid and play_activity_type_id = 3 
              inner join  zeven.zeven_web_user zu
              on          ppua.user_id = zu.user_id 
              inner join  zeven.zeven_venue_master zvm
              on          ppua.facility_id = zvm.venue_masterid
              where       ppua.is_published = p_publish_type_id
              and         ppua.is_deleted = 0
              and         ppua.is_saved   = 1) tab
          where order_no between  v_from_row_number and v_to_row_number;
      
      end if;
      end if;
  
end;

$$;


--
