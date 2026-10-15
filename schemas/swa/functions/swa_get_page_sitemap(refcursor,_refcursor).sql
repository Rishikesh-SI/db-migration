-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_page_sitemap(refcursor, refcursor)
-- Type: FUNCTION

-- Name: swa_get_page_sitemap(refcursor, refcursor); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_page_sitemap(p_eng_page_cur refcursor, p_hin_page_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

begin

	open p_eng_page_cur for
    select alias as page_url
    from
    (
        select p2.alias
        from swa.swa_page p1
        join swa.swa_page p2
        on p1.page_id = p2.page_id
        where p1.is_active = 1
        and p1.is_deleted = 0
        and p1.asset_type_id is null
        and p1.is_published = 1
        and p1.alias not like '(hi/)%'
        and p2.alias not like 'hi%'
        and p2.alias not like'(.*)/(.*)/(.*)/(attachment)/(.*)'
        and p1.alias like replace(p2.alias,'^','^^')
        and p1.is_custom_menu !=1
        union
        select substring(alias,7) as alias
        from swa.swa_page
        where is_active = 1
        and is_deleted = 0
        and asset_type_id is null
        and is_published = 1
        and alias like '(hi/)%'
        and  alias like replace(alias,'^','^^')
        and is_custom_menu !=1
    ) tab;
    
    open p_hin_page_cur for
    select alias as page_url
    from
    (
        select p2.alias
        from swa.swa_page p1
        join swa.swa_page p2
        on p1.page_id = p2.page_id
        where p1.is_active = 1
        and p1.is_deleted = 0
        and p1.asset_type_id is null
        and p1.is_published = 1
        and p1.alias not like '(hi/)%'
        and p2.alias like 'hi/%'
        and p2.alias not like'(.*)/(.*)/(.*)/(attachment)/(.*)'
        and p1.alias like replace(p2.alias,'^','^^')
        and p1.is_custom_menu !=1
        union
        select 'hi/'||substring(alias,7) as alias
        from swa.swa_page
        where is_active = 1
        and is_deleted = 0
        and asset_type_id is null
        and is_published = 1
        and alias like '(hi/)%'
        and  alias like replace(alias,'^','^^')
        and is_custom_menu !=1
    ) tab;
    
end;

$$;


--
