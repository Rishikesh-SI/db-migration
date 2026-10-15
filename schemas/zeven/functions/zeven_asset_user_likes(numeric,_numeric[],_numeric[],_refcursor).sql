-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_asset_user_likes(numeric, numeric[], numeric[], refcursor)
-- Type: FUNCTION

-- Name: zeven_asset_user_likes(numeric, numeric[], numeric[], refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_asset_user_likes(p_userid numeric, p_arr_article_id numeric[], p_arr_asset_type_id numeric[], p_arr_cur_asset_likes refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare 
v_sysdate				    timestamp(0) = current_timestamp;
v_identifier_flag           numeric;

begin
	
	select nextval('zeven.seq_gtt_wafid') into v_identifier_flag;
  
  for i in 1..array_length(p_arr_article_id,1)
  loop
    insert into zeven.gtt_waf 
    (
      col1_seqid,col2_number,col3_number,col4_number ,col5_number
    )
    values 
    (
      v_identifier_flag,p_arr_article_id[i],p_arr_asset_type_id[i],0,p_userid
    );
  end loop;
    
  for i in 1..array_length(p_arr_article_id,1)
  loop
	
	with a as
	(
		select  p_arr_article_id[i] as articleid,p_arr_asset_type_id[i] as asset_type_id,p_userid as userid
		from    zeven.zeven_track_user_activity
		where   articleid = p_arr_article_id[i]
		and asset_type_id = p_arr_asset_type_id[i]
		and activityid = 3
		and userid = p_userid
	)
	update zeven.gtt_waf up
	set col4_number = 1
	from a
	where exists(select 1
				 from   zeven.gtt_waf b
				 where  b.col2_number = a.articleid
				 and b.col3_number = a.asset_type_id
				 and b.col5_number = a.userid);
	
    /*merge into  zeven.gtt_waf up
    using (
           select  p_arr_article_id(i) as articleid,p_arr_asset_type_id(i) as asset_type_id,p_userid as userid
           from    zeven.zeven_track_user_activity
           where   articleid = p_arr_article_id(i)
                    and
                    asset_type_id = p_arr_asset_type_id(i)
                    and
                    activityid = 3
                    and
                    userid = p_userid
          )  tu
      on    (
             up.col2_number = tu.articleid
             and 
             up.col3_number = tu.asset_type_id
             and
             up.col5_number = tu.userid
          )
    when matched then
    update 
    set     up.col4_number = 1;*/
  end loop;
    
    /* commit; */
  
  open p_arr_cur_asset_likes for
      select  col5_number as userid,col2_number as articleid,col3_number as asset_type_id,
              col4_number as liked
      from    zeven.gtt_waf gtt
      where   col1_seqid = v_identifier_flag;

    delete from zeven.gtt_waf where col1_seqid = v_identifier_flag;
    /* commit; */
    
end;
$$;


--
