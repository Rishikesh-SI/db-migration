-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_asset_reaction_r(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_asset_reaction_r(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_asset_reaction_r(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_asset_reaction_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_asset_id numeric;
     v_asset_type_id numeric;
     v_page_number numeric;
     v_item_number numeric;
     v_comment_id numeric;
     v_client_user_id numeric;
     v_offset numeric;
     v_limit numeric;
     v_reaction_count_json jsonb;
     v_user_reaction_json jsonb;
     v_json jsonb;
     
begin
	
     select p_json->>'asset_id', p_json->>'asset_type_id', p_json->>'page_number', p_json->>'item_number', p_json->>'comment_id'
     into v_asset_id, v_asset_type_id, v_page_number, v_item_number, v_comment_id;
     
     select source_value into v_client_user_id
     from siwaf.siwaf_client_comment_source_map
     where client_code = p_schema_prefix
     and source_id = 1;
     
     v_offset := ((v_page_number - 1) * v_item_number);
     v_limit := v_item_number;
     
     if v_comment_id is null then
     	
          execute 'select (''{"reaction_count":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
          		from (select uar.reaction_id, count(1)
                    		from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                         	where uar.asset_id = '||v_asset_id||'
                         	and uar.asset_type_id = '||v_asset_type_id||'
                         	and uar.reaction_id <> 4 '
                         	' group by uar.reaction_id
					) as row'
		into v_reaction_count_json
    		using v_comment_id;
    		
     	execute 'select (''{"user_reaction":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
          		from (select tab.user_id, wu.user_full_name, wu.profile_picture_url, wu.client_id, wu.is_custom_image,
                    			case wu.user_id when $2 then 1 else 0 end is_admin_user, tab.reaction_id
						from (select uar.user_id, uar.reaction_id
                              		from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                                        where uar.asset_id = '||v_asset_id||'
                                        and uar.asset_type_id = '||v_asset_type_id||'
                                        and uar.reaction_id <> 4 '
                                        ' order by uar.reaction_date desc
                                        limit '||v_limit||' offset '||v_offset||'
                         		) as tab
						join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu
                         	on wu.user_id = tab.user_id
					) as row'
		into v_user_reaction_json
    		using v_comment_id, coalesce(v_client_user_id, 0);
     	
	else
     	
     	execute 'select (''{"reaction_count":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
          		from (select acr.reaction_id, count(1)
                    		from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                         	where comment_id = $1'
                         	' group by acr.reaction_id
					) as row'
		into v_reaction_count_json
    		using v_comment_id;
    		
     	execute 'select (''{"user_reaction":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
     			from (select tab.user_id, wu.user_full_name, wu.profile_picture_url, wu.client_id, wu.is_custom_image,
                    			case wu.user_id when $2 then 1 else 0 end is_admin_user, tab.reaction_id
						from (select user_id, reaction_id
                              		from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
                                   	where comment_id = $1
                                   	order by reaction_date desc
                                   	limit '||v_limit||' offset '||v_offset||'
                         		) as tab
						join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu
                         	on wu.user_id = tab.user_id
					) as row'
		into v_user_reaction_json
    		using v_comment_id, coalesce(v_client_user_id, 0);
	     
	end if;
     
     select ('{"data":['||row_to_json(row)||']}')::jsonb
     from (select v_reaction_count_json as reaction_count_json, v_user_reaction_json as user_reaction_json) as row
     into v_json;
     
     if v_json is not null then
     	p_result := 1;
          p_asset_reaction_json := v_json;
     else
     	p_result := 0;
          p_asset_reaction_json := '{"data":[]}'::jsonb;
     end if;
     
/*exception
	when others then
     	p_result := -1;
          p_asset_reaction_json := '{"data":[]}'::jsonb;*/
end;

$_$;


--
