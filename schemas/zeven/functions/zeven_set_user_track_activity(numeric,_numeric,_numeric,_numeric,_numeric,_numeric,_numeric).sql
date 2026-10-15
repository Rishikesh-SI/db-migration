-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_set_user_track_activity(numeric, numeric, numeric, numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: zeven_set_user_track_activity(numeric, numeric, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_set_user_track_activity(p_userid numeric, p_sport_id numeric, p_article_id numeric, p_category_id numeric, p_sub_categoryid numeric, p_activity_id numeric, p_asset_type_id numeric, OUT p_ret_type numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_sysdate				timestamp(0) = current_timestamp;
v_valid_user    numeric = 0;
v_is_activity_done  numeric = 0;
v_activity_points numeric = 0;
v_like_exist numeric = 0;

begin

    select	count(1)
    into    v_valid_user
    from    zeven.zeven_web_user    
    where   user_id = p_userid ;

   select count(1)
   into   v_like_exist
   from   zeven.zeven_track_user_activity 
   where  user_id = p_userid
          and
          articleid = p_article_id
          and
          --categoryid = p_category_id
          --and
          asset_type_id = p_asset_type_id
          and
          sportid = p_sport_id
          and
          activityid = 3
          and
          p_activity_id = 3;
        
   if v_valid_user = 1 and v_like_exist = 0 then
   begin
    --log user activity
    insert into zeven.zeven_track_user_activity 
    (
      track_user_activityid,user_id,sportid,categoryid,sub_categoryid,articleid,activityid,asset_type_id,created_date,updated_date
    )
    values
    (
      -- zeven.seq_zeven_trk_usr_activityid.nextval,p_userid,p_sport_id,p_category_id,0,p_article_id,p_activity_id,p_asset_type_id,v_sysdate,v_sysdate
		nextval('zeven.seq_zeven_trk_usr_activityid'),p_userid,p_sport_id,p_category_id,0,p_article_id,p_activity_id,p_asset_type_id,v_sysdate,v_sysdate
    );
    
    ---give points for user activity
    select  count(1) 
    into    v_is_activity_done
    from    zeven.zeven_track_user_activity_pts
    where   user_id = p_userid
            and
            articleid = p_article_id
            and
            activityid  = p_activity_id
            and
--            categoryid = p_category_id
--            and
--            sub_categoryid = p_sub_categoryid
--            and
            sportid = p_sport_id
            and
            asset_type_id= p_asset_type_id;
            
    if v_is_activity_done = 0 then
      begin
        select  coalesce(activity_points,0)
        into    v_activity_points
        from    zeven.zeven_activity_master
        where   activityid = p_activity_id;
       exception 
        when no_data_found then
        v_activity_points := 0; 
      end;
      
      insert into zeven.zeven_track_user_activity_pts
      (
        user_id,articleid ,activityid,sportid,categoryid,sub_categoryid,points,asset_type_id, created_date,updated_date
      )
      values  
      (
        p_userid,p_article_id,p_activity_id,p_sport_id,p_category_id,0,v_activity_points,p_asset_type_id,v_sysdate,v_sysdate
      );
      
      if exists(select 1 from zeven.zeven_user_overall_points where user_id = p_userid) then
      	update zeven.zeven_user_overall_points
       set    op.points = coalesce(op.points,0) + coalesce(v_activity_points,0),
              updated_date = v_sysdate
              where user_id = p_userid;
      else
      	insert into zeven.zeven_user_overall_points
       (
          user_id,
          points,
          created_date,
          updated_date
        )
        select 
        (
          p_userid,
          v_activity_points,
          v_sysdate,
          v_sysdate
         );
      end if;
      
      /*merge into zeven.zeven_user_overall_points op
      using (
              select  p_userid as user_id
              from    dual
            ) tp
       on (op.user_id = tp.user_id)
       when matched then 
       update 
       set    op.points = coalesce(op.points,0) + coalesce(v_activity_points,0),
              updated_date = v_sysdate
       when not matched then 
       insert 
       (
          user_id,
          points,
          created_date,
          updated_date
        )
        select 
        (
          p_userid,
          v_activity_points,
          v_sysdate,
          v_sysdate
         );*/
         
      end if;
    end;
    /* commit; */
    p_ret_type := 1;
   else
    p_ret_type := 0;
   end if;
   
null;
exception
when others then
/* rollback; */ 
-- raise notice '%','error'||sqlcode||sqlerrm;
p_ret_type := -1111;    
end;

$$;


--
