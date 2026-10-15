-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_asset_comment_replies_r(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_asset_comment_replies_r(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_asset_comment_replies_r(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_comment_replies_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

/*
SELECT * from siwaf._get_asset_comment_replies_r(
	'labmi',-- <p_schema_prefix character varying>, 
	'{
  "user_guid": null,
  "comment_id": 1,
  "page_number": 1,
  "item_number": 10
}'-- <p_json jsonb>, 
);
*/

declare
	
     v_user_guid character varying(250);
     v_comment_id numeric;
     v_page_number numeric;
     v_item_number numeric;
     v_user_id numeric;
     v_offset numeric;
     v_limit numeric;
     v_client_user_id numeric;
     
begin
	
     select p_json->>'user_guid', p_json->>'comment_id', p_json->>'page_number', p_json->>'item_number'
     into v_user_guid, v_comment_id, v_page_number, v_item_number;
     
     if v_user_guid is not null then
     	execute 'select user_id from '||p_schema_prefix||'.'||p_schema_prefix||'_web_user
          		where user_guid = '''||v_user_guid||''''
		into v_user_id;
     end if;
     
     select source_value into v_client_user_id from siwaf.siwaf_client_comment_source_map where client_code = p_schema_prefix and source_id = 1;
     
     v_offset := ((v_page_number - 1) * v_item_number);
     v_limit := v_item_number;
     
     execute 'select (''{"replies":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
     		from (select tab.user_id, wu.user_full_name, wu.profile_picture_url, wu.client_id, wu.is_custom_image,
            				case wu.user_id when $2 then 1 else 0 end is_admin_user,
                              case wu.user_id when $1 then 1 else 0 end is_edit_delete_allowed,
            				tab.comment_id, tab.comment_text, tab.comment_type,
               				coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                              		where acr.comment_id = tab.comment_id),0) as reactions_count,
                              coalesce((select reaction_id from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                              		where acr.comment_id = tab.comment_id
                                   	and acr.user_id = $1),0) as user_reaction
					from (select uar.user_id, uar.user_asset_reaction_id as comment_id, uar.comment_text, uar.comment_type
               				from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                         		where parent_comment_id = '||v_comment_id||'
                                   order by uar.reaction_date desc
                                   limit '||v_limit||' offset '||v_offset||'
						) as tab
					join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu
                         on wu.user_id = tab.user_id
				) as row'
	into p_comment_replies_json
     using coalesce(v_user_id, 0), coalesce(v_client_user_id, 0);
     
     if p_comment_replies_json is not null then
     	p_result := 1;
	else
     	p_result := 0;
          p_comment_replies_json := '{"replies":[]}'::jsonb;
     end if;
     
/*exception
	when others then
     	p_result := -1;
          p_comment_replies_json := '{"replies":[]}'::jsonb;*/
end;

$_$;


--
