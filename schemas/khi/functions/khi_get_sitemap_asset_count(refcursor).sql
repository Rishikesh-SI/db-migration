-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_get_sitemap_asset_count(refcursor)
-- Type: FUNCTION

-- Name: khi_get_sitemap_asset_count(refcursor); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_get_sitemap_asset_count(p_sitemap_asset_count_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

begin
    
    open p_sitemap_asset_count_cur for
    select case entity_role_map_id when 7925 then 'Hindi' when 7926 then 'English' else null end as language, assets, total
	from
    (
        select aem.entity_role_map_id, 'News' assets, count(1) total
        from khi.khi_asset_list al
        join khi.khi_asset_entity_map aem
        on aem.asset_id = al.asset_id
        and aem.asset_type_id = al.asset_type_id
        where al.published_date <= current_timestamp at time zone 'utc'
        and al.is_published = 1
        and al.asset_type_id = coalesce(null,al.asset_type_id)
        and aem.entity_role_map_id in (select entity_id
                                       from   unnest(array[7925,7926]) U(entity_id))
        and al.asset_type_id = 1
        group by aem.entity_role_map_id
        union
        /*select aem.entity_role_map_id, 'Photos' assets, count(1) total
        from khi.khi_asset_list al
        join khi.khi_asset_entity_map aem
        on aem.asset_id = al.asset_id
        and aem.asset_type_id = al.asset_type_id
        where al.published_date <= current_timestamp at time zone 'utc'
        and al.is_published = 1
        and al.asset_type_id = coalesce(null,al.asset_type_id)
        and aem.entity_role_map_id in (select entity_id
                                       from   unnest(array[7925,7926]) U(entity_id))
        and al.asset_type_id = 2
        group by aem.entity_role_map_id
        union
        select aem.entity_role_map_id, 'Videos' assets, count(1) total
        from khi.khi_asset_list al
        join khi.khi_asset_entity_map aem
        on aem.asset_id = al.asset_id
        and aem.asset_type_id = al.asset_type_id
        where al.published_date <= current_timestamp at time zone 'utc'
        and al.is_published = 1
        and al.asset_type_id = coalesce(null,al.asset_type_id)
        and aem.entity_role_map_id in (select entity_id
                                       from   unnest(array[7925,7926]) U(entity_id))
        and al.asset_type_id = 4
        group by aem.entity_role_map_id
        union*/
        select aem.entity_role_map_id, 'Post' assets, count(1) total
        from khi.khi_asset_list al
        join khi.khi_asset_entity_map aem
        on aem.asset_id = al.asset_id
        and aem.asset_type_id = al.asset_type_id
        where al.published_date <= current_timestamp at time zone 'utc'
        and al.is_published = 1
        and al.asset_type_id = coalesce(null,al.asset_type_id)
        and aem.entity_role_map_id in (select entity_id
                                       from   unnest(array[7925,7926]) U(entity_id))
        -- and al.asset_type_id in(1,2,4)
        and al.asset_type_id in(2,4,5)
        group by aem.entity_role_map_id
    )a
    union
    select 'Hindi' as language, 'Players' as assets, count(1) total
	from   khi.khi_entity_master em
    join   khi.khi_entity_role_map erm
    on     erm.entity_master_id = em.entity_master_id
    join   khi.khi_entity_role er
    on     er.entity_role_id = erm.entity_role_id
    where  er.entity_type_id = 2
    and    em.canonical_url is not null
    union
    select 'English' as language, 'Players' as assets, count(1) total
	from   khi.khi_entity_master em
    join   khi.khi_entity_role_map erm
    on     erm.entity_master_id = em.entity_master_id
    join   khi.khi_entity_role er
    on     er.entity_role_id = erm.entity_role_id
    where  er.entity_type_id = 2
    and    em.canonical_url is not null
    order by language, assets;
	
end;

$$;


--
