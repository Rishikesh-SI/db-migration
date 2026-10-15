-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_asset_activity_count(numeric[], numeric[], refcursor)
-- Type: FUNCTION

-- Name: zeven_asset_activity_count(numeric[], numeric[], refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_asset_activity_count(p_arr_article_id numeric[], p_arr_asset_type_id numeric[], p_arr_cur_asset_activity_count refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_identifier_flag numeric[];
    
begin
	
	v_identifier_flag := nextval('zeven.seq_gtt_wafid');
    
  	for i in 1..array_length(p_arr_article_id,1)
  	loop
    	
        insert into zeven.gtt_waf(col1_seqid, col2_number, col3_number, col4_number, col5_number, col6_number, col7_number, col14_number,
                                  col15_number, col16_number)
		values(v_identifier_flag, p_arr_article_id[i], p_arr_asset_type_id[i], 0, 0, 0, 0, 0, 0, 0);
        
	end loop;
    
  	for i in 1..array_length(p_arr_article_id,1)
    loop
    	
        if exists(select 1 from zeven.gtt_waf where col2_number = p_arr_article_id[i] and col3_number = p_arr_asset_type_id[i]) then
        	
            with tu as
            (
                select p_arr_article_id[i] as articleid, p_arr_asset_type_id[i] as asset_type_id,
                	   	sum(case when activityid = 1 then 1 else 0 end) as gmail_share_count,
                		sum(case when activityid = 9 then 1 else 0 end) as fb_share_count,
                		sum(case when activityid = 10 then 1 else 0 end) as twitter_share_count,
                		sum(case when activityid = 2 then 1 else 0 end) as comment_count,
                		sum(case when activityid = 3 then 1 else 0 end) as like_count,
                  		sum(case when activityid = 4 then 1 else 0 end) as view_count,
                  		sum(case when activityid = 6 then 1 else 0 end) as report_count
                from   zeven.zeven_track_user_activity
                where  articleid = p_arr_article_id[i]
                and    asset_type_id = p_arr_asset_type_id[i]
                and    activityid in (1,2,3,4,6,9,10)
                group by articleid, asset_type_id
            )
            update zeven.gtt_waf
            set    col4_number = coalesce(gmail_share_count,0),
            		col5_number = coalesce(fb_share_count,0),
                    col6_number = coalesce(twitter_share_count,0),
                    col7_number = coalesce(comment_count,0),
                    col14_number = coalesce(like_count,0),
                    col15_number = coalesce(view_count,0),
                    col16_number = coalesce(report_count,0)
			from   tu
            where  articleid = col2_number
            and    asset_type_id = col3_number;
            
		else
        	
            with tu as
            (
                select p_arr_article_id[i] as articleid, p_arr_asset_type_id[i] as asset_type_id,
                		sum(case when activityid = 1 then 1 else 0 end) as gmail_share_count,
                		sum(case when activityid = 9 then 1 else 0 end) as fb_share_count,
                  		sum(case when activityid = 10 then 1 else 0 end) as twitter_share_count,
                  		sum(case when activityid = 2 then 1 else 0 end) as comment_count,
                  		sum(case when activityid = 3 then 1 else 0 end) as like_count,
                  		sum(case when activityid = 4 then 1 else 0 end) as view_count,
                  		sum(case when activityid = 6 then 1 else 0 end) as report_count
                from   zeven.zeven_track_user_activity
                where  articleid = p_arr_article_id[i]
                and    asset_type_id = p_arr_asset_type_id[i]
                and    activityid in (1,2,3,4,6,9,10)
                group by articleid, asset_type_id
            )
            insert into zeven.gtt_waf(col2_number, col3_number, col4_number, col5_number, col6_number, col7_number, col14_number, col15_number,
                                      col16_number)
            select * from tu;
            
		end if;
	
    end loop;
    
  	open p_arr_cur_asset_activity_count for
    select col2_number as articleid, col3_number as asset_type_id, col4_number as gmail_share_count, col5_number as fb_share_count,
    		col6_number as twitter_share_count, col7_number as comment_count, col14_number as like_count, col15_number as view_count,
            col16_number as report_count
	from    zeven.gtt_waf gtt
    where   col1_seqid = v_identifier_flag;
    
    delete from zeven.gtt_waf where col1_seqid = v_identifier_flag;
    
end;
$$;


--
