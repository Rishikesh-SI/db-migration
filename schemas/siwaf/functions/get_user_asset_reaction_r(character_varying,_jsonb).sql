-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_user_asset_reaction_r(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_user_asset_reaction_r(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_user_asset_reaction_r(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_asset_reaction_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
/*
SELECT * from siwaf._get_user_asset_reaction_r(
'labmi',-- <p_schema_prefix character varying>,
'{
  "user_guid": null,
  "asset_id": "1",
  "asset_type_id": "1",
  "is_detail": 0,
  "page_number": 1,
  "item_number": 10
}'-- <p_json jsonb>,
);
*/

declare
	
    v_user_guid character varying(100);
    v_asset_id numeric[];
    v_asset_type_id numeric[];
    v_is_detail numeric;
    v_page_number numeric;
    v_item_number numeric;
    v_limit numeric;
    v_offset numeric;
    v_user_id numeric;
    v_client_user_id numeric;
    v_i numeric;
    v_comment_id numeric;
    v_asset_reaction_json jsonb;
    v_asset_reaction_json_arr jsonb[];
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_asset_reactions_count numeric;
    v_asset_comments_count numeric;
    v_asset_user_reaction numeric;
    v_comment_reactions_count numeric;
    v_comment_user_reaction numeric;
    v_comment_total_reply_count numeric;
    v_comment_latest_reply numeric;
    v_latest_reply_reactions_count numeric;
    v_latest_reply_user_reaction numeric;
    v_listing_comment_count numeric := 1;
    v_j numeric;
    v_comment_json jsonb;
	v_comment_json_arr jsonb[];
	v_comments_json jsonb;
	v_comment_id_arr numeric[];
	
begin
	
   set enable_seqscan = false;
	
    select p_json->>'user_guid', string_to_array(p_json->>'asset_id',',')::numeric[],
	        string_to_array(p_json->>'asset_type_id',',')::numeric[],
			p_json->>'is_detail', p_json->>'page_number', p_json->>'item_number'
	into v_user_guid, v_asset_id, v_asset_type_id, v_is_detail, v_page_number, v_item_number;
	
    v_offset := ((v_page_number - 1) * v_item_number);
    v_limit := v_item_number;
	
    if v_user_guid is not null then
		
        execute 'select user_id
					from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
                    where user_guid = '''||v_user_guid||''''
		into v_user_id;
		
	end if;
	
    select source_value
	into v_client_user_id
    from siwaf.siwaf_client_comment_source_map
    where client_code = p_schema_prefix
    and source_id = 1;
	
	if v_is_detail = 0 then
		
-- 		raise notice '%',v_asset_id;
		
		-- Optimized: Process all assets in a single query instead of looping
		execute '
			select jsonb_build_object(''data'', array_to_json(array_agg(asset_data)))
			from (
				select jsonb_build_object(
					''asset_id'', asset_id,
					''asset_type_id'', asset_type_id,
					''reactions_count'', reactions_count,
					''comments_count'', comments_count,
					''user_reaction'', user_reaction,
					''comments'', comments_json
				) as asset_data
				from (
					select 
						unnest_asset.asset_id,
						unnest_asset.asset_type_id,
						coalesce(rc.reactions_count, 0) as reactions_count,
						coalesce(cc.comments_count, 0) as comments_count,
						coalesce(ur.reaction_id, 0) as user_reaction,
						-- Get top comments with their details
						(
							select array_to_json(array_agg(comment_row))
							from (
								select 
									wu.user_full_name,
									wu.profile_picture_url,
									wu.client_id,
									wu.is_custom_image,
									case wu.user_id when $2 then 1 else 0 end as is_admin_user,
									case wu.user_id when $3 then 1 else 0 end as is_edit_delete_allowed,
									uar.comment_text,
									uar.user_asset_reaction_id as comment_id,
									uar.reaction_date,
									coalesce(acr_cnt.reaction_count, 0) as reactions_count,
									coalesce(acr_user.reaction_id, 0) as user_reaction,
									coalesce(reply_cnt.reply_count, 0) as total_replies,
									-- Latest reply subquery
									(
										select array_to_json(array_agg(reply_row))
										from (
											select 
												wu1.user_full_name,
												wu1.profile_picture_url,
												wu1.client_id,
												uar1.reaction_date,
												wu1.is_custom_image,
												case wu1.user_id when $2 then 1 else 0 end as is_admin_user,
												case wu1.user_id when $3 then 1 else 0 end as is_edit_delete_allowed,
												uar1.comment_text,
												uar1.user_asset_reaction_id as comment_id,
												coalesce(latest_acr_cnt.reaction_count, 0) as reactions_count,
												coalesce(latest_acr_user.reaction_id, 0) as user_reaction,
												coalesce(cs1.is_spam, 0) as is_spam
											from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
											join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu1 
												on wu1.user_id = uar1.user_id
											left join (
												select comment_id, count(1) as reaction_count
												from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
												group by comment_id
											) latest_acr_cnt on latest_acr_cnt.comment_id = uar1.user_asset_reaction_id
											left join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction latest_acr_user 
												on latest_acr_user.comment_id = uar1.user_asset_reaction_id 
												and latest_acr_user.user_id = $3
											left join (
												select distinct comment_id, reported_by, 1 as is_spam 
												from '||p_schema_prefix||'.'||p_schema_prefix||'_comment_spam
											) cs1 on uar1.user_asset_reaction_id = cs1.comment_id 
												and cs1.reported_by = $3
											where uar1.parent_comment_id = uar.user_asset_reaction_id
											order by uar1.reaction_date desc
											limit 1
										) reply_row
									) as latest_reply,
									coalesce(cs.is_spam, 0) as is_spam
								from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
								join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu 
									on wu.user_id = uar.user_id
								left join (
									select comment_id, count(1) as reaction_count
									from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
									group by comment_id
								) acr_cnt on acr_cnt.comment_id = uar.user_asset_reaction_id
								left join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr_user 
									on acr_user.comment_id = uar.user_asset_reaction_id 
									and acr_user.user_id = $3
								left join (
									select parent_comment_id, count(1) as reply_count
									from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
									where parent_comment_id is not null
									group by parent_comment_id
								) reply_cnt on reply_cnt.parent_comment_id = uar.user_asset_reaction_id
								left join (
									select distinct comment_id, reported_by, 1 as is_spam 
									from '||p_schema_prefix||'.'||p_schema_prefix||'_comment_spam
								) cs on uar.user_asset_reaction_id = cs.comment_id 
									and cs.reported_by = $3
								where uar.asset_id = unnest_asset.asset_id
									and uar.asset_type_id = unnest_asset.asset_type_id
									and uar.reaction_id = 4
									and uar.parent_comment_id is null
								order by 
									case when uar.user_id = $1 then 0 else 1 end,
									uar.reaction_date desc
								limit '||v_listing_comment_count||'
							) comment_row
						) as comments_json
					from (
						select 
							unnest($4::numeric[]) as asset_id,
							unnest($5::numeric[]) as asset_type_id
					) unnest_asset
					-- Count reactions (excluding comments)
					left join (
						select asset_id, asset_type_id, count(1) as reactions_count
						from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
						where asset_id = any($4::numeric[])
							and reaction_id <> 4
						group by asset_id, asset_type_id
					) rc on rc.asset_id = unnest_asset.asset_id 
						and rc.asset_type_id = unnest_asset.asset_type_id
					-- Count comments
					left join (
						select asset_id, asset_type_id, count(1) as comments_count
						from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
						where asset_id = any($4::numeric[])
							and reaction_id = 4
							and parent_comment_id is null
						group by asset_id, asset_type_id
					) cc on cc.asset_id = unnest_asset.asset_id 
						and cc.asset_type_id = unnest_asset.asset_type_id
					-- Get user reaction
					left join '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction ur 
						on ur.asset_id = unnest_asset.asset_id
						and ur.asset_type_id = unnest_asset.asset_type_id
						and ur.reaction_id <> 4
						and ur.user_id = $3
				) asset_details
			) all_assets
		'
		into p_asset_reaction_json
		using coalesce(v_user_id, v_client_user_id, 0), 
			  coalesce(v_client_user_id, 0), 
			  coalesce(v_user_id, 0),
			  v_asset_id,
			  v_asset_type_id;
		
		
		
		
	else

    execute '
    select (''{"data":[{"asset_reaction_json":''||row_to_json(row)::text||''}]}'')::jsonb
    from (
        select
            $1 as asset_id,
            $2 as asset_type_id,
            rc.reactions_count,
            cc.comments_count,
            coalesce(ur.reaction_id, 0) as user_reaction,
            (
                select array_to_json(array_agg(comment_row))
                from (
                    select
                        tab.user_id,
                        wu.user_full_name,
                        wu.profile_picture_url,
                        wu.client_id,
                        wu.is_custom_image,
                        case wu.user_id when $4 then 1 else 0 end is_admin_user,
                        case wu.user_id when $3 then 1 else 0 end is_edit_delete_allowed,
                        tab.comment_id,
                        tab.comment_text,
                        tab.reaction_date,
                        coalesce(acr_cnt.reaction_count, 0) as reactions_count,
                        coalesce(acr_user.reaction_id, 0) as user_reaction,
                        coalesce(reply_cnt.reply_count, 0) as total_replies,
                        (
                            select array_to_json(array_agg(reply_row))
                            from (
                                select
                                    wu1.user_full_name,
                                    wu1.profile_picture_url,
                                    wu1.client_id,
                                    wu1.is_custom_image,
                                    uar1.reaction_date,
                                    case wu1.user_id when $4 then 1 else 0 end is_admin_user,
                                    case wu1.user_id when $3 then 1 else 0 end is_edit_delete_allowed,
                                    uar1.user_asset_reaction_id as comment_id,
                                    uar1.comment_text,
                                    coalesce(cs1.is_spam, 0) as is_spam,
                                    coalesce(latest_acr_cnt.reaction_count, 0) as reactions_count,
                                    coalesce(latest_acr_user.reaction_id, 0) as user_reaction
                                from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu1
                                    on wu1.user_id = uar1.user_id
                                left join (
                                    select comment_id, count(1) as reaction_count
                                    from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
                                    group by comment_id
                                ) latest_acr_cnt on latest_acr_cnt.comment_id = uar1.user_asset_reaction_id
                                left join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction latest_acr_user
                                    on latest_acr_user.comment_id = uar1.user_asset_reaction_id
                                   and latest_acr_user.user_id = $3
                                left join (
                                    select distinct comment_id, reported_by, 1 as is_spam
                                    from '||p_schema_prefix||'.'||p_schema_prefix||'_comment_spam
                                ) cs1 on cs1.comment_id = uar1.user_asset_reaction_id
                                       and cs1.reported_by = $3
                                where uar1.parent_comment_id = tab.comment_id
                                order by uar1.reaction_date desc
                                limit 1
                            ) reply_row
                        ) as latest_reply,
                        tab.is_spam
                    from (
                        select
                            uar.user_id,
                            uar.user_asset_reaction_id as comment_id,
                            uar.comment_text,
                            uar.reaction_date,
                            coalesce(cs.is_spam,0) as is_spam
                        from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                        left join (
                            select distinct comment_id, reported_by, 1 as is_spam
                            from '||p_schema_prefix||'.'||p_schema_prefix||'_comment_spam
                        ) cs on cs.comment_id = uar.user_asset_reaction_id
                               and cs.reported_by = $3
                        where uar.asset_id = $1
                          and uar.asset_type_id = $2
                          and uar.reaction_id = 4
                          and uar.parent_comment_id is null
                        order by uar.reaction_date desc
                        limit '||v_limit||' offset '||v_offset||'
                    ) tab
                    join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu
                        on wu.user_id = tab.user_id
                    left join (
                        select comment_id, count(1) as reaction_count
                        from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
                        group by comment_id
                    ) acr_cnt on acr_cnt.comment_id = tab.comment_id
                    left join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr_user
                        on acr_user.comment_id = tab.comment_id
                       and acr_user.user_id = $3
                    left join (
                        select parent_comment_id, count(1) as reply_count
                        from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                        group by parent_comment_id
                    ) reply_cnt on reply_cnt.parent_comment_id = tab.comment_id
                ) comment_row
            ) as comments
        from (select 1) base
cross join lateral (
    select count(1) as reactions_count
    from labmi.labmi_user_asset_reaction
    where asset_id = $1
      and asset_type_id = $2
      and reaction_id <> 4
) rc
cross join lateral (
    select count(1) as comments_count
    from labmi.labmi_user_asset_reaction
    where asset_id = $1
      and asset_type_id = $2
      and reaction_id = 4
      and parent_comment_id is null
) cc
left join labmi.labmi_user_asset_reaction ur
    on ur.asset_id = $1
   and ur.asset_type_id = $2
   and ur.reaction_id <> 4
   and ur.user_id = $3

    ) row
    '
    into p_asset_reaction_json
    using
        coalesce(v_asset_id[1],0),
        coalesce(v_asset_type_id[1],0),
        coalesce(v_user_id,0),
        coalesce(v_client_user_id,0);

end if;

	
	---raise notice '%',p_asset_reaction_json;
	
    if p_asset_reaction_json is not null then
    	p_result := 1;
	else
    	p_result := 0;
		p_asset_reaction_json := '{"data":[]}'::jsonb;
	end if;
	
	
	
	--p_asset_reaction_json := '{}'::jsonb ;
	
-- exception
-- 	when others then
-- 		p_result := -1;
-- 	  	p_asset_reaction_json := '{"data":[]}'::jsonb;
	
end;
$_$;


--
