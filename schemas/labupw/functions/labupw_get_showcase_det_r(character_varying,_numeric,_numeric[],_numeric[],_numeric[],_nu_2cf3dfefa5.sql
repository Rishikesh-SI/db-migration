-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_get_showcase_det_r(character varying, numeric, numeric[], numeric[], numeric[], numeric, numeric, numeric, numeric, jsonb)
-- Type: FUNCTION

-- Name: labupw_get_showcase_det_r(character varying, numeric, numeric[], numeric[], numeric[], numeric, numeric, numeric, numeric, jsonb); Type: FUNCTION; Schema: labupw; Owner: -
--

CREATE FUNCTION labupw.labupw_get_showcase_det_r(p_schema_prefix character varying, p_showcase_id numeric, p_entity_role_map_id_arr numeric[], p_other_entity_role_map_id_arr numeric[], p_exclude_entity_role_map_id_arr numeric[], p_page_number numeric, p_page1_item_number numeric, p_item_number numeric, p_is_fallback numeric, p_exclude_data jsonb, OUT p_result numeric, OUT p_showcase_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
        v_fallback numeric := coalesce(p_is_fallback,0);
        v_fallback_query text := ' ';
        v_from_row_number numeric;
        v_to_row_number numeric;
        v_entity_count numeric;
        v_other_entity_count numeric;
        v_exclude_entity_count numeric;
        v_entity_filter_query_al text := ' ';
        v_entity_filter_query_tcam text := ' ';
        v_other_entity_filter_query_al text := ' ';
        v_other_entity_filter_query_tcam text := ' ';
        v_exclude_entity_filter_query_al text := ' ';
        v_exclude_entity_filter_query_tcam text := ' ';
        v_assets_count numeric;
        v_assets_json jsonb;
        v_showcase_asset_json jsonb;
        v_showcase_json jsonb;
        v_entity_filter_query_tcam1 text:=' ';
        v_other_entity_filter_query_tcam1 text:=' ';
        
        v_json1 jsonb;
        v_asset_id numeric;
        v_asset_type_id1 numeric;
        v_data jsonb;
        v_article_array numeric[];
        v_album_array numeric[];
        v_video_array numeric[];
        v_article_qry text := ' ';
        v_album_qry text := ' ';
        v_video_qry text := ' ';
        v_exclude_data_qry text := ' ';
        
        v_article_qry_1 text := ' ';
        v_album_qry_1 text := ' ';
        v_video_qry_1 text := ' ';
        v_exclude_data_qry_1 text := ' ';
        begin
        
         p_schema_prefix :=  'labupw';
        
        execute 'select (''{"data":''||row_to_json(row)::text||''}'')::jsonb
        from (select template_component_map_id, is_published as status,
        case is_published when 1 then 0 else 1 end as is_trashed,
        updated_by, updated_date as published_date,
        tcmap_guid as guid, null as version_number, null as count,
        null as asset_map
        from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_map
        where template_component_map_id = '||p_showcase_id||'
        ) row'
        into v_showcase_json;
        
        if v_fallback = 0 then
        v_fallback_query := ' where is_fallback = $7 ';
        end if;
        if p_page1_item_number is null then
        v_from_row_number := (p_page_number * p_item_number - (p_item_number - 1));
        v_to_row_number := (p_page_number * p_item_number);
        else
        if p_page_number = 1 then
        v_from_row_number := (p_page_number * (p_page1_item_number - (p_page1_item_number - 1)));
                else
                  v_from_row_number := p_page1_item_number + (((p_page_number - 1) * p_item_number) - (p_item_number - 1));
                end if;
            v_to_row_number := p_page1_item_number + ((p_page_number - 1) * p_item_number);
        end if;
        
        
        if p_exclude_data is not null THEN
    
            -- select p_exclude_data->'data' into v_json1;
            
            v_json1 := p_exclude_data;
            
            for v_data in select * from jsonb_array_elements(v_json1)
            loop
                    select v_data->>'asset_id',
                    v_data->>'asset_type_id'
                    into v_asset_id,
                        v_asset_type_id1;
        
                if v_asset_type_id1 = 1 then
                    v_article_array := array_append(v_article_array,v_asset_id);
                elsif v_asset_type_id1 = 2 then
                  v_album_array := array_append(v_album_array,v_asset_id);
                elsif v_asset_type_id1 = 4 then
                  v_video_array := array_append(v_video_array,v_asset_id);
                end if;
    
            end loop;
            
               if v_article_array is not null then
                    v_article_qry := '(asset_id not in (select * from unnest($4) as asset_id) and asset_type_id = 1)';
                    v_article_qry_1 := '((asset_meta->>''asset_id'')::numeric not in (select * from unnest($4) as asset_id) and (asset_meta->>''content_type'')::numeric = 1)';
                    v_exclude_data_qry := 'and('|| v_article_qry ;
                    v_exclude_data_qry_1 := 'and('|| v_article_qry_1 ;
                end if;
    
                if v_album_array is not null then
                    v_album_qry := '(asset_id not in (select * from unnest($5) as asset_id) and asset_type_id = 2)';
                    v_album_qry_1 := '((asset_meta->>''asset_id'')::numeric not in (select * from unnest($4) as asset_id) and (asset_meta->>''content_type'')::numeric = 2)';
                    
                    
                    if v_exclude_data_qry = ' ' then
                       v_exclude_data_qry := 'and('|| v_album_qry ;
                       v_exclude_data_qry_1 := 'and('|| v_album_qry_1 ;
                     else
                       v_exclude_data_qry := v_exclude_data_qry ||' or '|| v_album_qry ;
                       v_exclude_data_qry_1 := v_exclude_data_qry_1 ||' or '|| v_album_qry_1 ;
                     end if;
    
              end if;
    
            if v_video_array is not null then
                v_video_qry := '(asset_id not in (select * from unnest($6) as asset_id) and asset_type_id = 4)';
                 v_video_qry_1 := '((asset_meta->>''asset_id'')::numeric not in (select * from unnest($4) as asset_id) and (asset_meta->>''content_type'')::numeric = 4)';
                
                if v_exclude_data_qry = ' ' then
                    v_exclude_data_qry := 'and('|| v_video_qry ;
                    v_exclude_data_qry_1 := 'and('|| v_video_qry_1 ;
                 else
                    v_exclude_data_qry := v_exclude_data_qry ||' or '|| v_video_qry ;
                    v_exclude_data_qry_1 := v_exclude_data_qry_1 ||' or '|| v_video_qry_1 ;
                 end if;
            end if;
    
            v_exclude_data_qry := v_exclude_data_qry || ')';
            v_exclude_data_qry_1 := v_exclude_data_qry_1 || ')';
    
    end if;
        
        select array_length(p_entity_role_map_id_arr, 1), array_length(p_other_entity_role_map_id_arr, 1),
                array_length(p_exclude_entity_role_map_id_arr, 1)
        into v_entity_count, v_other_entity_count,v_exclude_entity_count;
        
        
        if v_entity_count > 0 then
        v_entity_filter_query_al := ' and al.tagged_entity::int[] @> $1 ';
        v_entity_filter_query_tcam := ' and exists(select 1
        from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
        where aem.asset_id = (tcam.asset_meta->>''asset_id'')::numeric
        and aem.asset_type_id = (tcam.asset_meta->>''content_type'')::numeric
        and aem.entity_role_map_id
        in(select v_entity_role_map_id from unnest($1) u(v_entity_role_map_id))
        group by aem.asset_id, aem.asset_type_id
        having count(1) = '||v_entity_count||')';
        
        v_entity_filter_query_tcam1 := ' and exists(select 1
        from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
        where aem.asset_id =  tcam.asset_id
        and aem.asset_type_id = tcam.asset_type_id
        and aem.entity_role_map_id
        in(select v_entity_role_map_id from unnest($1) u(v_entity_role_map_id))
        group by aem.asset_id, aem.asset_type_id
        having count(1) = '||v_entity_count||')';
        
        end if;
        if v_other_entity_count > 0 then
        v_other_entity_filter_query_al := ' and al.tagged_entity::int[] && $2 ';
        v_other_entity_filter_query_tcam := ' and exists(select 1
        from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
        where aem.asset_id = tcam.asset_id
        and aem.asset_type_id = tcam.asset_type_id
        and aem.entity_role_map_id in(select v_other_entity_role_map_id from unnest($2) u(v_other_entity_role_map_id))
        group by aem.asset_id, aem.asset_type_id
        having count(1) = 1)';
        
        
        end if;
        if v_exclude_entity_count > 0 then
        v_exclude_entity_filter_query_al := ' and not al.tagged_entity && $3 ';
        v_exclude_entity_filter_query_tcam := ' and not exists(select 1
        from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
        where aem.asset_id = tcam.asset_id
        and aem.asset_type_id = tcam.asset_type_id
        and aem.entity_role_map_id in(select v_other_entity_role_map_id from unnest($3) u(v_other_entity_role_map_id))
        group by aem.asset_id, aem.asset_type_id
        having count(1) = 1)';
        end if;
        
        
      --raise notice '%',v_entity_role_map_id; 
        execute 'select count(1)
        from (select tcam.asset_id, tcam.asset_type_id
        from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
        where tcam.template_component_map_id = '||p_showcase_id
        ||' and tcam.asset_type_id = 12
        and asset_meta->>''asset_id'' is null
                and asset_meta->>''content_type'' is null
        '
        ||v_entity_filter_query_tcam1
        ||v_other_entity_filter_query_tcam
        ||v_exclude_entity_filter_query_tcam
        ||v_exclude_data_qry_1
        ||'union
        select tcam.asset_id, tcam.asset_type_id
        from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
        where tcam.template_component_map_id = '||p_showcase_id
        ||' and tcam.asset_type_id = 12
        and asset_meta->>''asset_id'' is not null
                and asset_meta->>''content_type'' is not null'
        ||v_entity_filter_query_tcam
        ||v_other_entity_filter_query_tcam
        ||v_exclude_entity_filter_query_tcam
        ||v_exclude_data_qry_1
        ||'union
        select al.asset_id, al.asset_type_id
        from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
        where al.asset_type_id in(1,2,4)
        and al.is_published = 1
        and al.is_trashed = 0
        and (al.asset_id,al.asset_type_id) not in(select tcam.asset_id, tcam.asset_type_id
        from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
        where tcam.template_component_map_id = '||p_showcase_id||'
        and tcam.asset_type_id <> 12) '
        ||v_entity_filter_query_al
        ||v_other_entity_filter_query_al
        ||v_exclude_entity_filter_query_al
        ||v_exclude_data_qry
        ||' and '||v_fallback||' = 1) tab'
        into v_assets_count
        using p_entity_role_map_id_arr::int[], p_other_entity_role_map_id_arr::int[],
        p_exclude_entity_role_map_id_arr::int[],v_article_array,v_album_array,v_video_array;
        
        
        v_showcase_json := jsonb_set(v_showcase_json,'{data,count}',('"'||v_assets_count||'"')::text::jsonb,false);
    
        execute 'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
        from (select asset_id, asset_type_id, asset_order, is_fallback
        from (select asset_id, asset_type_id, row_number() over(order by is_fallback, asset_order) as asset_order,
        is_fallback, row_number() over(order by is_fallback, asset_order) as slno
        from (select tcam.asset_id, tcam.asset_type_id, tcam.asset_order, 0 as is_fallback
        from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
        where tcam.template_component_map_id = '||p_showcase_id
        ||' and tcam.asset_type_id = 12
        and asset_meta->>''asset_id'' is null
                and asset_meta->>''content_type'' is null'
        ||v_entity_filter_query_tcam1
        ||v_other_entity_filter_query_tcam
        ||v_exclude_entity_filter_query_tcam
        ||v_exclude_data_qry_1
        ||'union
        select (asset_meta->>''asset_id'')::numeric as asset_id,(asset_meta->>''content_type'')::numeric as asset_type_id, tcam.asset_order, 0 as is_fallback
        from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
        where tcam.template_component_map_id = '||p_showcase_id
        ||'and tcam.asset_type_id = 12
        and asset_meta->>''asset_id'' is not null
                and asset_meta->>''content_type'' is not null'
        ||v_entity_filter_query_tcam
        ||v_other_entity_filter_query_tcam
        ||v_exclude_entity_filter_query_tcam
        ||v_exclude_data_qry_1
        ||'union
        select al.asset_id, al.asset_type_id, row_number() over(order by al.published_date desc) as asset_order,
        1 as is_fallback
        from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
        where al.asset_type_id in(1,2,4)
        and al.is_published = 1
        and al.is_trashed = 0
        and (al.asset_id, al.asset_type_id) not in(select tcam.asset_id, tcam.asset_type_id
        from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
        where tcam.template_component_map_id = '||p_showcase_id||'
        and tcam.asset_type_id <> 12) '
        ||v_entity_filter_query_al
        ||v_other_entity_filter_query_al
        ||v_exclude_entity_filter_query_al
        ||v_exclude_data_qry
        ||') tab_a'
        ||v_fallback_query
        ||') tab_b
        where slno between '||v_from_row_number||' and '||v_to_row_number||'
        ) row'
        into v_assets_json
        using p_entity_role_map_id_arr::int[], p_other_entity_role_map_id_arr::int[], 
        p_exclude_entity_role_map_id_arr::int[],v_article_array,v_album_array,v_video_array,v_fallback;
        
        execute 'with tab as
        (select (jsonb_array_elements(a->''data'')->>''asset_id'')::numeric as asset_id,
        (jsonb_array_elements(a->''data'')->>''asset_type_id'')::numeric as asset_type_id,
        (jsonb_array_elements(a->''data'')->>''asset_order'')::numeric as asset_order,
        (jsonb_array_elements(a->''data'')->>''is_fallback'')::numeric as is_fallback
        from (select $1::jsonb as a) tab_a
        )
        select (json_agg(row_to_json(row))::jsonb)
        from (select tab_d.template_component_asset_map_id, tab_d.template_component_map_id, tab_d.asset_id,
        tab_d.asset_type_id as asset_type,
        jsonb_set(tab_d.asset_meta,''{image_id}'',''null'',false) as asset_meta,
        tab_d.asset_order,
        tab_d.published_date as publish_date,
        tab_d.published_version_number,
        (select array_to_json(array_agg(tab))
        from (select aem.priority, aem.entity_role_map_id,
        em.entity_name as name, aem.is_linkable, aem.is_visible,
        tab_d.asset_id,
        tab_d.asset_type_id,
        em.canonical_url as canonical,
        em.entity_display_name as ent_disp_name,
        em.entity_url,
        case when ec.entity_category_id is not null then 1 else 0 end as is_lang
        from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
        join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
        on erm.entity_role_map_id = aem.entity_role_map_id
        join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
        on em.entity_master_id = erm.entity_master_id
        left join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_category ec
        on ec.entity_role_id = erm.entity_role_id
        and ec.category_name = ''Language''
        where aem.asset_id = tab_d.asset_id
        and aem.asset_type_id = tab_d.asset_type_id
        )tab
        ) as entitydata,
        (select array_to_json(array_agg(tab))
        from (select tab_d.asset_id, tab_d.asset_type_id, u.user_id as author_id, u.display_name as author_name,
        u.full_name, u.user_name, pam.content_provider_id as content_source_id,
        cp.content_provider_name
        from '||p_schema_prefix||'.'||p_schema_prefix||'_author_action aa
        join '||p_schema_prefix||'.'||p_schema_prefix||'_user u
        on u.user_id = aa.author_id
        left join '||p_schema_prefix||'.'||p_schema_prefix||'_provider_author_map pam
        on aa.author_id = pam.author_id
        left join '||p_schema_prefix||'.'||p_schema_prefix||'_content_provider cp
        on pam.content_provider_id = cp.content_provider_id
        where aa.asset_id = tab_d.asset_id
        and aa.asset_type_id = tab_d.asset_type_id
        and aa.action_id = 4
        )tab
        ) as author
        from (select tcam.template_component_asset_map_id,
        tcam.template_component_map_id, (case when (asset_meta->>''asset_id'')::numeric is null then tcam.asset_id else
        (asset_meta->>''asset_id'')::numeric end )as asset_id,
        (case when (asset_meta->>''content_type'')::numeric is null then tcam.asset_type_id else
        (asset_meta->>''content_type'')::numeric end )as asset_type_id,
        tcam.asset_meta, t.asset_order,
        tcam.published_date,
        tcam.published_version_number,
        null as total_assets
        from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
        join tab t
        on t.asset_id = tcam.asset_id
        and t.asset_type_id = tcam.asset_type_id
        union
        select null as template_component_asset_map_id, null as template_component_map_id,
        al.asset_id, al.asset_type_id,
        (select row_to_json(row)::jsonb
        from(select null as url, al.short_desc as desc, al.asset_title as title, al.asset_id,
        null as image_id, al.image_file_name as image_name, al.image_path, 1 as responsive, al.title_alias,
        null as video_embed, al.asset_type_id as content_type, null as mob_image_id,
        null as score_wicket, null as mob_image_name, null as mob_image_path,
        null as content_source_id,true as show_content
        ) row
        )::jsonb as asset_meta, t.asset_order, al.published_date,
        al.published_version_number, al.total_assets
        from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
        join tab t
        on t.asset_id = al.asset_id
        and t.asset_type_id = al.asset_type_id
        union
        select null as template_component_asset_map_id, null as template_component_map_id,
        al.asset_id, al.asset_type_id,
        (select row_to_json(row)::jsonb
        from(select  null as url, al.short_desc as desc, al.asset_title as title, al.asset_id,
        null as image_id, al.image_file_name as image_name, al.image_path, 1 as responsive, al.title_alias,
        null as video_embed, al.asset_type_id as content_type, null as mob_image_id,
        null as score_wicket, null as mob_image_name, null as mob_image_path,
        null as content_source_id,true as show_content
        ) row
        )::jsonb as asset_meta, t.asset_order, al.published_date,
        al.published_version_number, al.total_assets
        from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
        join tab t
        on t.asset_id = al.asset_id
        and t.asset_type_id = al.asset_type_id
        where t.is_fallback = 1
        ) tab_d
        left join '||p_schema_prefix||'.'||p_schema_prefix||'_article a
        on a.article_id = tab_d.asset_id
        and tab_d.asset_type_id = 1
        order by asset_order
        ) row'
        into v_showcase_asset_json
        using v_assets_json,null,null,v_article_array,v_album_array,v_video_array;
        v_showcase_json := jsonb_set(v_showcase_json,'{data,asset_map}',v_showcase_asset_json,false);
        if v_showcase_json is null then
        p_result := 0;
        p_showcase_json := '{"data":null}'::jsonb;
        else
        p_result := 1;
        p_showcase_json := v_showcase_json;
        end if;
        /*exception
        when others then
        p_result := -1;
        p_showcase_json := '{"data":[]}'::jsonb;*/
        end;
$_$;


--
