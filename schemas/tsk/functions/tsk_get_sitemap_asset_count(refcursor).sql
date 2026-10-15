-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_get_sitemap_asset_count(refcursor)
-- Type: FUNCTION

-- Name: tsk_get_sitemap_asset_count(refcursor); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_get_sitemap_asset_count(p_sitemap_asset_count_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

begin
    
    open p_sitemap_asset_count_cur for
    select case entity_role_map_id when 7925 then 'hindi' when 7926 then 'english' else null end as language, assets, total
	from
    (
        select aem.entity_role_map_id, 'news' assets, count(1) total
        from tsk.tsk_asset_list al
        join tsk.tsk_asset_entity_map aem
        on aem.asset_id = al.asset_id
        and aem.asset_type_id = al.asset_type_id
        where al.published_date <= current_timestamp at time zone 'utc'
        and al.is_published = 1
        and al.asset_type_id = coalesce(null,al.asset_type_id)
        and aem.entity_role_map_id in (select entity_id
                                       from   unnest(array[7925,7926]) u(entity_id))
        and al.asset_type_id = 1
        group by aem.entity_role_map_id
        union
        /*select aem.entity_role_map_id, 'photos' assets, count(1) total
        from tsk.tsk_asset_list al
        join tsk.tsk_asset_entity_map aem
        on aem.asset_id = al.asset_id
        and aem.asset_type_id = al.asset_type_id
        where al.published_date <= current_timestamp at time zone 'utc'
        and al.is_published = 1
        and al.asset_type_id = coalesce(null,al.asset_type_id)
        and aem.entity_role_map_id in (select entity_id
                                       from   unnest(array[7925,7926]) u(entity_id))
        and al.asset_type_id = 2
        group by aem.entity_role_map_id
        union
        select aem.entity_role_map_id, 'videos' assets, count(1) total
        from tsk.tsk_asset_list al
        join tsk.tsk_asset_entity_map aem
        on aem.asset_id = al.asset_id
        and aem.asset_type_id = al.asset_type_id
        where al.published_date <= current_timestamp at time zone 'utc'
        and al.is_published = 1
        and al.asset_type_id = coalesce(null,al.asset_type_id)
        and aem.entity_role_map_id in (select entity_id
                                       from   unnest(array[7925,7926]) u(entity_id))
        and al.asset_type_id = 4
        group by aem.entity_role_map_id
        union*/
        select aem.entity_role_map_id, 'post' assets, count(1) total
        from tsk.tsk_asset_list al
        join tsk.tsk_asset_entity_map aem
        on aem.asset_id = al.asset_id
        and aem.asset_type_id = al.asset_type_id
        where al.published_date <= current_timestamp at time zone 'utc'
        and al.is_published = 1
        and al.asset_type_id = coalesce(null,al.asset_type_id)
        and aem.entity_role_map_id in (select entity_id
                                       from   unnest(array[7925,7926]) u(entity_id))
        -- and al.asset_type_id in(1,2,4)
        and al.asset_type_id in(2,4)
        group by aem.entity_role_map_id
    )a
    union
    select 'hindi' as language, 'players' as assets, count(1) total
	from   tsk.tsk_entity_master em
    join   tsk.tsk_entity_role_map erm
    on     erm.entity_master_id = em.entity_master_id
    join   tsk.tsk_entity_role er
    on     er.entity_role_id = erm.entity_role_id
    where  er.entity_type_id = 2
    and    em.canonical_url is not null
    union
    select 'english' as language, 'players' as assets, count(1) total
	from   tsk.tsk_entity_master em
    join   tsk.tsk_entity_role_map erm
    on     erm.entity_master_id = em.entity_master_id
    join   tsk.tsk_entity_role er
    on     er.entity_role_id = erm.entity_role_id
    where  er.entity_type_id = 2
    and    em.canonical_url is not null
    order by language, assets;
	
end;

 $$;


--
