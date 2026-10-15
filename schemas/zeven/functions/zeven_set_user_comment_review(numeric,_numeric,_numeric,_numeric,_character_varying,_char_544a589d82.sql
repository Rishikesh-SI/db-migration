-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_set_user_comment_review(numeric, numeric, numeric, numeric, character varying, character varying, numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: zeven_set_user_comment_review(numeric, numeric, numeric, numeric, character varying, character varying, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_set_user_comment_review(p_comment_reviewid numeric, p_userid numeric, p_venue_masterid numeric, p_type numeric, p_comment_review_text character varying, p_comment_review_title character varying, p_been_played_there numeric, p_reply_to_id numeric, p_rating numeric, p_opt_type numeric, OUT ret numeric, OUT p_reviewid numeric, OUT p_ratingid numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare 
v_venue_parentid  zeven.zeven_comment_review.venue_parentid%type;
v_venue_type      zeven.zeven_comment_review.venue_type%type;
v_activity_ponumerics numeric;
v_sysdate timestamp(0) = current_timestamp;
v_comment_reviewid numeric;
v_ratingid        numeric;
v_valid_user numeric = 0;
v_sportid numeric = 0;
v_user_activity_ret numeric = 0;
v_is_insert numeric = 0;
v_filter_ratingid numeric = 0;
v_avg_rate numeric = 0;
v_rating_filterid numeric = 0;
v_zeven_filter_masterid numeric = 0;

begin

  select	count(1)
  into    v_valid_user
  from    zeven.zeven_user    
  where   user_id = p_userid ;
    
  begin
    select  venue_parentid,venue_type,sport_master_id
    into    v_venue_parentid,v_venue_type,v_sportid
    from    zeven.zeven_venue_master
    where   venue_masterid = p_venue_masterid;
  exception 
      when no_data_found then
      v_venue_parentid := 0; 
  end;
  
  begin
    select  zeven_filter_masterid
    into    v_rating_filterid
    from    zeven.zeven_filter_master
    where   filter_name = 'ratings';
  exception 
      when no_data_found then
      v_venue_parentid := 0; 
  end;
  
   begin
    select  zeven_comment_reviewid
    into    v_comment_reviewid
    from    zeven.zeven_comment_review
    where   user_id  = p_userid
            and 
            venue_masterid = p_venue_masterid;
  exception 
      when no_data_found then
      v_comment_reviewid := 0; 
  end;
  
  begin
    select  zeven_ratingid
    into    v_ratingid
    from    zeven.zeven_rating
    where   user_id  = p_userid
            and 
            venue_masterid = p_venue_masterid;
  exception 
      when no_data_found then
      v_ratingid := 0; 
  end;
  
  if p_opt_type = 1 and v_valid_user = 1  then
    --insert the review/comment
    -- review is thr? 
    if length(p_comment_review_text) > 0 then
      if p_rating is not null then
        v_is_insert := 1;
      else
        v_is_insert := 0;
      end if;
    elsif  p_rating is not null then --only rating is thr?
       v_is_insert := 1;
    end if;
    
    if v_is_insert = 1 then
      if length(p_comment_review_text) > 0 and coalesce(v_comment_reviewid,0) = 0 then
        -- v_comment_reviewid := zeven.seq_zeven_comment_reviewid.nextval;
        select nextval('zeven.seq_zeven_comment_reviewid') into v_comment_reviewid;
        insert into zeven.zeven_comment_review 
        ( 
          zeven_comment_reviewid,user_id,venue_masterid,venue_type,venue_parentid,type,comment_review_text,been_played_there,reply_to_id,
          created_date,updated_date,comment_review_title,is_published
        )
       values
       (
          v_comment_reviewid,p_userid,p_venue_masterid,v_venue_type,v_venue_parentid,p_type,p_comment_review_text,p_been_played_there,p_reply_to_id,
          v_sysdate,v_sysdate,p_comment_review_title,1
       );
       
      end if;
      
     --insert ratings if provided
     if p_rating is not null and v_ratingid = 0 then
      -- v_ratingid := zeven.seq_zeven_ratingid.nextval;
      select nextval('zeven.seq_zeven_ratingid') into v_ratingid;
      insert into zeven.zeven_rating
      (
        zeven_ratingid,user_id,venue_masterid,venue_type,venue_parentid,ratings,created_date,updated_date,zeven_comment_reviewid
      )
      values
      (
        v_ratingid,p_userid,p_venue_masterid,v_venue_type,v_venue_parentid,p_rating,v_sysdate,v_sysdate,v_comment_reviewid
      );
      end if;
      
      -- allocate ponumeric for review and ratings
      if p_rating is not null and  length(p_comment_review_text) > 0 then
        perform zeven.zeven_set_user_track_activity( p_userid,v_sportid,v_comment_reviewid,p_venue_masterid,v_venue_parentid,11,0,v_user_activity_ret);
        ret := v_user_activity_ret;
      elsif p_rating is not null then
        perform zeven.zeven_set_user_track_activity( p_userid,v_sportid,v_ratingid,p_venue_masterid,v_venue_parentid,12,0,v_user_activity_ret);
        ret :=  v_user_activity_ret;
      end if;
      /* commit; */
    else
      ret := 0;
    end if;
    
    p_reviewid := v_comment_reviewid;
    p_ratingid := v_ratingid;
  elsif p_opt_type = 2 and v_valid_user = 1 then 
    perform zeven.zeven_set_user_track_activity( p_userid,v_sportid,p_comment_reviewid,p_venue_masterid,v_venue_parentid,3,0,v_user_activity_ret);
    ret :=  v_user_activity_ret;
    p_reviewid := v_comment_reviewid;
    p_ratingid := v_ratingid;
  elsif p_opt_type = 3 and v_valid_user = 1 then 
    -- v_comment_reviewid := zeven.seq_zeven_comment_reviewid.nextval;
    select nextval('zeven.seq_zeven_comment_reviewid') into v_comment_reviewid;
    insert into zeven.zeven_comment_review 
    ( 
      zeven_comment_reviewid,user_id,venue_masterid,venue_type,venue_parentid,type,comment_review_text,
      been_played_there,reply_to_id,created_date,updated_date,comment_review_title,is_published
    )
   values
   (
      v_comment_reviewid,p_userid,p_venue_masterid,v_venue_type,v_venue_parentid,p_type,p_comment_review_text,
      p_been_played_there,p_reply_to_id,v_sysdate,v_sysdate,p_comment_review_title,1
   );
   /* commit; */
   
   ret :=  1;
   p_reviewid := v_comment_reviewid;
   p_ratingid := v_ratingid;
  elsif p_opt_type = 4 and v_valid_user = 1 then 
    perform zeven.zeven_set_user_track_activity( p_userid,v_sportid,p_comment_reviewid,p_venue_masterid,v_venue_parentid,18,0,v_user_activity_ret);
    ret :=  v_user_activity_ret;
    
  elsif p_opt_type = 5 and v_valid_user = 1 then 
    update  zeven.zeven_comment_review 
    set     comment_review_title = p_comment_review_title,
            comment_review_text = p_comment_review_text,
            updated_date = v_sysdate
    where   user_id  = p_userid
            and 
            venue_masterid = p_venue_masterid;
    
    update  zeven.zeven_rating 
    set     ratings = coalesce(p_rating,ratings),
            updated_date = v_sysdate
    where   user_id  = p_userid
            and 
            venue_masterid = p_venue_masterid;
    
    /* commit; */
    ret :=  1;
    p_reviewid := v_comment_reviewid;
    p_ratingid := v_ratingid;
  end if;
  
  --store avg of every facility rating in filter values for search 
  if  p_opt_type in (1,5) and v_valid_user = 1 then 
    begin
      select  round(avg(ratings),0)
      into    v_avg_rate
      from    zeven.zeven_rating
      where venue_masterid = p_venue_masterid;
    exception 
      when no_data_found then
      v_avg_rate := 0; 
  end;
    
    begin
      select  zeven_venue_filter_valuesid
      into    v_filter_ratingid
      from    zeven.zeven_venue_filter_values 
      where   venue_masterid = p_venue_masterid
              and 
              zeven_filter_masterid = v_rating_filterid;
    exception 
      when no_data_found then
      v_filter_ratingid := 0; 
    end;
  
    begin
    select  zeven_filter_masterid
    into    v_zeven_filter_masterid
    from    zeven.zeven_filter_master
    where   parent_filter_id = v_rating_filterid
            and
            filter_name = v_avg_rate;
    exception 
      when no_data_found then
      v_zeven_filter_masterid := null; 
    end;
    
    if v_filter_ratingid > 0 then
      update  zeven.zeven_venue_filter_values 
      set     venue_filter_value = v_zeven_filter_masterid,
              updated_date = v_sysdate
      where   zeven_venue_filter_valuesid = v_filter_ratingid;
    else
      v_filter_ratingid := seq_zeven_venue_filter_values.nextval;
      insert into zeven.zeven_venue_filter_values
      (
        zeven_venue_filter_valuesid,venue_masterid,zeven_filter_masterid,venue_filter_value,is_deleted,is_published,created_date,updated_date                   
      )
      select  v_filter_ratingid,p_venue_masterid,v_rating_filterid,v_zeven_filter_masterid,0,1,v_sysdate,v_sysdate
      from    dual  ;
    end if;
    /* commit; */
  end if;
    
exception
when others then
  ret:=-1111;
  /* rollback; */
  -- raise notice '%','error'||sqlcode||sqlerrm;
end;

$$;


--
