-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_comment_notification_detail(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_comment_notification_detail(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_comment_notification_detail(p_schema_prefix character varying, p_json jsonb, OUT p_comment_notification_detail jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

/*
'{
	"user_guid": null,
  	"comment_id": 891
}';
*/

declare
	
     v_user_guid text;
     v_page_number numeric;
	v_item_number numeric;
     v_comment_id numeric;
     v_user_id numeric;
	v_asset_id numeric;
	v_asset_type_id numeric;
     v_title_alias text;
	v_client_user_id numeric;
     
begin
	
	select p_json->>'user_guid', p_json->>'page_number', p_json->>'item_number',p_json->>'comment_id'
	into v_user_guid, v_page_number, v_item_number, v_comment_id;
	
    	execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
     		set is_read = 1
              	where user_asset_reaction_id = $1'
	using v_comment_id;
     
    	execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
     		set is_read = 1
              	where comment_id = $1'
	using v_comment_id;
    	
    	if v_user_guid is not null then
     	
          execute 'select user_id
          		from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
          		where user_guid = $1'
		into v_user_id
		using v_user_guid;
          
   	end if;
   	
     execute 'select asset_id, asset_type_id
     		from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
               where user_asset_reaction_id = $1'
	into v_asset_id, v_asset_type_id
     using v_comment_id;
     
     execute 'select title_alias
     		from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list
               where asset_id = $1
               and asset_type_id = $2'
	into v_title_alias
     using v_asset_id, v_asset_type_id;
	
     select source_value into v_client_user_id
     from siwaf.siwaf_client_comment_source_map
     where client_code = p_schema_prefix
     and source_id = 1;
     
     execute 'select (''{"data":[{"asset_reaction_json":''||string_agg(row_to_json(row)::text,'','')||''}]}'')::jsonb
     		from (select $1 as asset_id, $2 as asset_type_id, $3 as title_alias,
               			(select array_to_json(array_agg(row))
                              	from (select uar.user_id, wu.user_full_name, wu.profile_picture_url, wu.client_id,
                                   			wu.is_custom_image, case wu.user_id when $6 then 1 else 0 end is_admin_user,
                                            case wu.user_id when $5 then 1 else 0 end is_edit_delete_allowed,
                                                  uar.user_asset_reaction_id as comment_id,uar.reaction_date,uar.comment_text,uar.comment_type,
                                                  coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                  		where acr.comment_id = uar.user_asset_reaction_id),0) as reactions_count,
										coalesce((select reaction_id from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                  		where acr.comment_id = uar.user_asset_reaction_id
                                                            and acr.user_id = $5),0) as user_reaction,
										coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                                  		where uar1.parent_comment_id = uar.user_asset_reaction_id),0) as total_replies,
										(select array_to_json(array_agg(row))
                                                  	from (select uar1.user_id, wu1.user_full_name, wu1.profile_picture_url,
                                                       			wu1.client_id, wu1.is_custom_image,
                                                                      case wu1.user_id when $6 then 1 else 0 end is_admin_user,
                                                                      case wu1.user_id when $5 then 1 else 0 end is_edit_delete_allowed,
                                                                      uar1.user_asset_reaction_id as comment_id,uar1.reaction_date ,uar1.comment_text,uar1.comment_type,
                                                                      coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                                      		where acr.comment_id = uar1.user_asset_reaction_id),0) as reactions_count,
														coalesce((select reaction_id from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                                      		where acr.comment_id = uar1.user_asset_reaction_id
                                                                                and acr.user_id = $5),0) as user_reaction
													from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                                                 join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu1
                                                                 on wu1.user_id = uar1.user_id
                                                                 where uar1.parent_comment_id = uar.user_asset_reaction_id
                                                                 order by uar1.reaction_date desc
                                                            ) row
										) as latest_reply
									from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
									join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu
                                             on wu.user_id = uar.user_id
                                             where uar.user_asset_reaction_id = $4
								) row
						) as comments
				) as row'
	into p_comment_notification_detail
     using v_asset_id, v_asset_type_id, v_title_alias, v_comment_id, v_user_id, coalesce(v_client_user_id,0);
     
end;

$_$;


--
