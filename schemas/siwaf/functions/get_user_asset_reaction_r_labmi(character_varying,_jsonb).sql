-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_user_asset_reaction_r_labmi(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_user_asset_reaction_r_labmi(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_user_asset_reaction_r_labmi(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_asset_reaction_json jsonb) RETURNS record
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
   
    select p_json->>'user_guid', string_to_array(p_json->>'asset_id',',')::numeric[], string_to_array(p_json->>'asset_type_id',',')::numeric[],
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
   
    select source_value into v_client_user_id
    from siwaf.siwaf_client_comment_source_map
    where client_code = p_schema_prefix
    and source_id = 1;
   
 
   
if v_is_detail = 0 then
-- raise notice '%',v_asset_id;
   
        for v_i in 1..array_length(v_asset_id, 1)
        loop
       
            v_comment_id := null;
            v_j := 1;
            v_comment_json_arr := null;
            v_comment_id_arr := null;
           
            execute 'select uar.user_asset_reaction_id
            from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                        where uar.asset_id = '||v_asset_id[v_i]||'
                        and uar.asset_type_id = '||v_asset_type_id[v_i]||'
                        and uar.reaction_id = 4
                        and uar.user_id = $1
                        and uar.parent_comment_id is null
                        order by uar.reaction_date desc
                        limit 1'
into v_comment_id
            using coalesce(v_user_id, v_client_user_id, 0);
           
            if v_comment_id is null then
           
                execute 'select comment_id
                from (select acr.comment_id, count(1) as reaction_count
                            from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                    where acr.asset_id = '||v_asset_id[v_i]||'
                                    and acr.asset_type_id = '||v_asset_type_id[v_i]||'
                                    group by acr.comment_id
                                    order by reaction_count desc
                                    limit 1
) as tab'
into v_comment_id;
               
end if;
           
            if v_comment_id is null then
           
                execute 'select uar.user_asset_reaction_id
                from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                            where uar.asset_id = '||v_asset_id[v_i]||'
                            and uar.asset_type_id = '||v_asset_type_id[v_i]||'
                            and uar.reaction_id = 4
                            and uar.parent_comment_id is null
                            order by uar.reaction_date desc
                            limit 1'
                into v_comment_id;
                   
end if;
           
            if v_comment_id is not null then
            v_comment_id_arr[1] := v_comment_id;
end if;
           
            while (v_listing_comment_count >= v_j and coalesce(v_comment_id,0) <> 0)
            loop
           
                execute 'select count(1)
                from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
                            where comment_id = $1'
into v_comment_reactions_count
                using coalesce(v_comment_id,0);
               
                execute 'select reaction_id
                from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
                            where comment_id = $1
                            and user_id = $2'
into v_comment_user_reaction
                using coalesce(v_comment_id,0), coalesce(v_user_id,0);
               
                execute 'select count(1)
                from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                            where parent_comment_id = $1'
into v_comment_total_reply_count
                using coalesce(v_comment_id,0);
               
                execute 'select user_asset_reaction_id as comment_id
                from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                            where parent_comment_id = $1
                            order by reaction_date desc
                            limit 1'
into v_comment_latest_reply
                using coalesce(v_comment_id,0);
               
                execute 'select count(1)
                from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
                            where comment_id = $1'
into v_latest_reply_reactions_count
                using coalesce(v_comment_latest_reply,0);
               
                execute 'select reaction_id
                from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
                            where comment_id = $1
                            and user_id = $2'
into v_latest_reply_user_reaction
                using coalesce(v_comment_latest_reply,0), coalesce(v_user_id,0);
               
                execute 'select row_to_json(row)
                from (select wu.user_full_name, wu.profile_picture_url, wu.client_id, wu.is_custom_image,
                            case wu.user_id when $2 then 1 else 0 end is_admin_user,
                                            case wu.user_id when $3 then 1 else 0 end is_edit_delete_allowed, uar.comment_text, $1 as comment_id,
                                            $4 as reactions_count, $5 as user_reaction, $6 as total_replies,uar.reaction_date,
                                            (select array_to_json(array_agg(row))
                                            from (select wu1.user_full_name, wu1.profile_picture_url, wu1.client_id,uar1.reaction_date,
                                                wu1.is_custom_image, case wu1.user_id when $2 then 1 else 0 end is_admin_user,
                                                                case wu1.user_id when $3 then 1 else 0 end is_edit_delete_allowed, uar1.comment_text,
                                                                $7 as comment_id, $8 as reactions_count, $9 as user_reaction
from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                                        join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu1
                                                        on wu1.user_id = uar1.user_id
                                                        where uar1.user_asset_reaction_id = $7
) row
) as latest_reply
from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                                    join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu
                                    on wu.user_id = uar.user_id
                                    where uar.user_asset_reaction_id = $1
) as row'
into v_comment_json
                using v_comment_id, coalesce(v_client_user_id,0), coalesce(v_user_id,0), v_comment_reactions_count, v_comment_user_reaction,
                v_comment_total_reply_count, v_comment_latest_reply, v_latest_reply_reactions_count, v_latest_reply_user_reaction;

                v_comment_json_arr[v_j] := v_comment_json;
               
                v_j := v_j + 1;
               
                execute 'select user_asset_reaction_id
                from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                            where asset_id = '||v_asset_id[v_i]||'
                            and asset_type_id = '||v_asset_type_id[v_i]||'
                            and reaction_id = 4
                            and reaction_date <= (select reaction_date
                            from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                                                    where user_asset_reaction_id = $1)
and user_asset_reaction_id <> $1
                            order by reaction_date desc'
into v_comment_id
                using coalesce(v_comment_id,0);
               
                if v_comment_id is not null then
                v_comment_id_arr[v_j] := v_comment_id;
else
                execute 'select uar.user_asset_reaction_id
                    from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                                where uar.asset_id = '||v_asset_id[v_i]||'
                                and uar.asset_type_id = '||v_asset_type_id[v_i]||'
                                and uar.reaction_id = 4
                                and uar.parent_comment_id is null
                                and uar.user_asset_reaction_id <>any(select unnest($1))
                                order by uar.reaction_date desc
                                limit 1'
into v_comment_id
                    using v_comment_id_arr;
                    v_comment_id_arr[v_j] := v_comment_id;
end if;
               
end loop;
           
            select ('['||string_agg(comment_json::text,',')||']')::jsonb
            from unnest(v_comment_json_arr) u(comment_json)
            into v_comments_json;
           
            execute 'select count(1)
            from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                        where asset_id = '||v_asset_id[v_i]||'
                        and asset_type_id = '||v_asset_type_id[v_i]||'
                        and reaction_id <> 4'
into v_asset_reactions_count;
           
          execute 'select count(1)
            from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                        where asset_id = '||v_asset_id[v_i]||'
                        and asset_type_id = '||v_asset_type_id[v_i]||'
                        and reaction_id = 4
                        and parent_comment_id is null'
into v_asset_comments_count;
           
          execute 'select reaction_id
            from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                        where asset_id = '||v_asset_id[v_i]||'
                        and asset_type_id = '||v_asset_type_id[v_i]||'
                        and reaction_id <> 4
                        and user_id = $1'
into v_asset_user_reaction
            using coalesce(v_user_id, 0);
           
            execute 'select row_to_json(row)
            from (select $1 as asset_id, $2 as asset_type_id, $3 as reactions_count, $4 as comments_count, $5 as user_reaction,
                        null as comments
) as row'
into v_asset_reaction_json
            using coalesce(v_asset_id[v_i],0), coalesce(v_asset_type_id[v_i],0), coalesce(v_asset_reactions_count,0),
            coalesce(v_asset_comments_count,0), coalesce(v_asset_user_reaction,0);

if v_comments_json is not null then
            v_asset_reaction_json := jsonb_set(v_asset_reaction_json,'{comments}',v_comments_json, true);
end if;
           
            v_asset_reaction_json_arr[v_i] := v_asset_reaction_json;
           
end loop;
       
        select ('{"data":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
        from (select asset_reaction_json from unnest(v_asset_reaction_json_arr) u(asset_reaction_json)) as row
        into p_asset_reaction_json;
       
else
   
        execute 'select count(1)
        from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                    where asset_id = '||v_asset_id[1]||'
                    and asset_type_id = '||v_asset_type_id[1]||'
                    and reaction_id <> 4'
into v_asset_reactions_count;
       
        execute 'select count(1)
        from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                    where asset_id = '||v_asset_id[1]||'
                    and asset_type_id = '||v_asset_type_id[1]||'
                    and reaction_id = 4
                    and parent_comment_id is null'
into v_asset_comments_count;
       
        execute 'select reaction_id
        from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
                    where asset_id = '||v_asset_id[1]||'
                    and asset_type_id = '||v_asset_type_id[1]||'
                    and reaction_id <> 4
                    and user_id = $1'
into v_asset_user_reaction  
        using coalesce(v_user_id, 0);
       
        execute 'select (''{"data":[{"asset_reaction_json":''||string_agg(row_to_json(row)::text,'','')||''}]}'')::jsonb
        from (select $1 as asset_id, $2 as asset_type_id, $3 as reactions_count, $4 as comments_count, $5 as user_reaction,
                    (select array_to_json(array_agg(row))
                                    from (select tab.user_id, wu.user_full_name, wu.profile_picture_url, wu.client_id, wu.is_custom_image,
                                        case wu.user_id when $7 then 1 else 0 end is_admin_user,
                                                        case wu.user_id when $6 then 1 else 0 end is_edit_delete_allowed,
                                        tab.comment_id, tab.comment_text, tab.reaction_date,
                                        coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                        where acr.comment_id = tab.comment_id),0) as reactions_count,
                                                        coalesce((select reaction_id from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                        where acr.comment_id = tab.comment_id
                                                                    and acr.user_id = $6),0) as user_reaction,
coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                                        where uar1.parent_comment_id = tab.comment_id),0) as total_replies,
                                                        (select array_to_json(array_agg(row))
                                                        from (select uar1.user_id, wu1.user_full_name, wu1.profile_picture_url, wu1.client_id, wu1.is_custom_image,
uar1.reaction_date,
                                                            case wu1.user_id when $7 then 1 else 0 end is_admin_user,
                                                                            case wu1.user_id when $6 then 1 else 0 end is_edit_delete_allowed,
                                                            uar1.user_asset_reaction_id as comment_id, uar1.comment_text,
                                                                            coalesce((select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                                            where acr.comment_id = uar1.user_asset_reaction_id),0) as reactions_count,
                                                                            coalesce((select reaction_id from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction acr
                                                                            where acr.comment_id = uar1.user_asset_reaction_id
                                                                                      and acr.user_id = $6),0) as user_reaction
from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar1
                                                                    join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu1
                                                              on wu1.user_id = uar1.user_id
                                                                    where uar1.parent_comment_id = tab.comment_id
                                                                    order by uar1.reaction_date desc
                                                                    limit 1) row
) as latest_reply
                                      from (select uar.user_id, uar.user_asset_reaction_id as comment_id, uar.comment_text, uar.reaction_date
                                                from '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction uar
                                                        where uar.asset_id = $1
                                                        and uar.asset_type_id = $2
                                                        and uar.reaction_id = 4
                                                        and uar.parent_comment_id is null
                                                        order by uar.reaction_date desc
                                                        limit '||v_limit||' offset '||v_offset||') as tab
join '||p_schema_prefix||'.'||p_schema_prefix||'_web_user wu
                                                on wu.user_id = tab.user_id) row
) as comments) as row'
into p_asset_reaction_json
        using coalesce(v_asset_id[1],0), coalesce(v_asset_type_id[1],0), coalesce(v_asset_reactions_count,0), coalesce(v_asset_comments_count,0),
        coalesce(v_asset_user_reaction,0), coalesce(v_user_id,0), coalesce(v_client_user_id,0);

end if;
   
    if p_asset_reaction_json is not null then
    p_result := 1;
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
