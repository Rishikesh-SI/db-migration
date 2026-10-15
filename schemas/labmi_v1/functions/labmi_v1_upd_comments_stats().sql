-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_upd_comments_stats()
-- Type: FUNCTION

-- Name: labmi_v1_upd_comments_stats(); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_upd_comments_stats(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	
    delete from labmi_v1.labmi_v1_asset_reaction_summary;
    
    insert into labmi_v1.labmi_v1_asset_reaction_summary
	select uar.asset_id, uar.asset_type_id,
    		(select array(select uar1.user_asset_reaction_id
                          from labmi_v1.labmi_v1_user_asset_reaction uar1
                          where uar1.asset_id = uar.asset_id
                          and uar1.asset_type_id = uar.asset_type_id
                          and uar1.reaction_id = 4
                          and uar1.parent_comment_id is null
                          order by uar1.reaction_date desc
                          limit 10)
            ) latest_comments,
            sum(case when uar.reaction_id <> 4 then 1 else 0 end) total_reactions,
            sum(case when uar.reaction_id = 4 then 1 else 0 end) total_comments
	from labmi_v1.labmi_v1_user_asset_reaction uar
    where uar.parent_comment_id is null
    group by uar.asset_id, uar.asset_type_id;
    
    delete from labmi_v1.labmi_v1_comment_reaction_summary;
    
    insert into labmi_v1.labmi_v1_comment_reaction_summary
	select uar.asset_id, uar.asset_type_id, uar.user_asset_reaction_id comment_id, uar.comment_text, uar.reaction_date, uar.user_id, null, null, null
    from labmi_v1.labmi_v1_user_asset_reaction uar
    where uar.reaction_id = 4;
    
    with tab as
	(select parent_comment_id, user_asset_reaction_id comment_id
     from (select parent_comment_id, user_asset_reaction_id, row_number() over(partition by parent_comment_id order by reaction_date desc) rn
           from labmi_v1.labmi_v1_user_asset_reaction
           where parent_comment_id is not null) a
     where rn = 1
    )
    update labmi_v1.labmi_v1_comment_reaction_summary crs
    set latest_reply = tab.comment_id
    from tab
    where tab.parent_comment_id = crs.comment_id;
    
    with tab as
    (select comment_id, count(1) rc
     from labmi_v1.labmi_v1_asset_comment_reaction
     group by comment_id
    )
    update labmi_v1.labmi_v1_comment_reaction_summary crs
    set total_reactions = tab.rc
    from tab
    where tab.comment_id = crs.comment_id;
    
    with tab as
    (select parent_comment_id, count(1) rc
     from labmi_v1.labmi_v1_user_asset_reaction
     where reaction_id = 4
     group by parent_comment_id
    )
    update labmi_v1.labmi_v1_comment_reaction_summary crs
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
