-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_upd_comments_stats()
-- Type: FUNCTION

-- Name: isl_upd_comments_stats(); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_upd_comments_stats(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	
    delete from isl.isl_asset_reaction_summary;
    
    insert into isl.isl_asset_reaction_summary
	select uar.asset_id, uar.asset_type_id,
    		(select array(select uar1.user_asset_reaction_id
                          from isl.isl_user_asset_reaction uar1
                          where uar1.asset_id = uar.asset_id
                          and uar1.asset_type_id = uar.asset_type_id
                          and uar1.reaction_id = 4
                          and uar1.parent_comment_id is null
                          order by uar1.reaction_date desc
                          limit 10)
            ) latest_comments,
            sum(case when uar.reaction_id <> 4 then 1 else 0 end) total_reactions,
            sum(case when uar.reaction_id = 4 then 1 else 0 end) total_comments
	from isl.isl_user_asset_reaction uar
    where uar.parent_comment_id is null
    group by uar.asset_id, uar.asset_type_id;
    
    delete from isl.isl_comment_reaction_summary;
    
    insert into isl.isl_comment_reaction_summary
	select uar.asset_id, uar.asset_type_id, uar.user_asset_reaction_id comment_id, uar.comment_text, uar.reaction_date, uar.user_id, null, null, null
    from isl.isl_user_asset_reaction uar
    where uar.reaction_id = 4;
    
    with tab as
	(select parent_comment_id, user_asset_reaction_id comment_id
     from (select parent_comment_id, user_asset_reaction_id, row_number() over(partition by parent_comment_id order by reaction_date desc) rn
           from isl.isl_user_asset_reaction
           where parent_comment_id is not null) a
     where rn = 1
    )
    update isl.isl_comment_reaction_summary crs
    set latest_reply = tab.comment_id
    from tab
    where tab.parent_comment_id = crs.comment_id;
    
    with tab as
    (select comment_id, count(1) rc
     from isl.isl_asset_comment_reaction
     group by comment_id
    )
    update isl.isl_comment_reaction_summary crs
    set total_reactions = tab.rc
    from tab
    where tab.comment_id = crs.comment_id;
    
    with tab as
    (select parent_comment_id, count(1) rc
     from isl.isl_user_asset_reaction
     where reaction_id = 4
     group by parent_comment_id
    )
    update isl.isl_comment_reaction_summary crs
    set total_replies = tab.rc
    from tab
    where tab.parent_comment_id = crs.comment_id;
    
    p_result := 1;
    
exception
	when others then
    	p_result := -1;
	
end;
$$;


--
