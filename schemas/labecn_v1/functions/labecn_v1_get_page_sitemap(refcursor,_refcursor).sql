-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_get_page_sitemap(refcursor, refcursor)
-- Type: FUNCTION

-- Name: labecn_v1_get_page_sitemap(refcursor, refcursor); Type: FUNCTION; Schema: labecn_v1; Owner: -
--

CREATE FUNCTION labecn_v1.labecn_v1_get_page_sitemap(p_eng_page_cur refcursor, p_hin_page_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

begin

	open p_eng_page_cur for
    select alias as page_url
    from
    (
        select p2.alias
        from labecn_v1.labecn_v1_page p1
        join labecn_v1.labecn_v1_page p2
        on p1.page_id = p2.page_id
        where p1.is_active = 1
        and p1.is_deleted = 0
        and p1.asset_type_id is null
        and p1.is_published = 1
        and p1.alias not like '(hi/)%'
        and p2.alias not like 'hi%'
        and p2.alias not like'(.*)/(.*)/(.*)/(attachment)/(.*)'
        and p1.alias like replace(p2.alias,'^','^^')
        union
        select substring(alias,7) as alias
        from labecn_v1.labecn_v1_page
        where is_active = 1
        and is_deleted = 0
        and asset_type_id is null
        and is_published = 1
        and alias like '(hi/)%'
        and  alias like replace(alias,'^','^^')
    ) tab;
    
    open p_hin_page_cur for
    select alias as page_url
    from
    (
        select p2.alias
        from labecn_v1.labecn_v1_page p1
        join labecn_v1.labecn_v1_page p2
        on p1.page_id = p2.page_id
        where p1.is_active = 1
        and p1.is_deleted = 0
        and p1.asset_type_id is null
        and p1.is_published = 1
        and p1.alias not like '(hi/)%'
        and p2.alias like 'hi/%'
        and p2.alias not like'(.*)/(.*)/(.*)/(attachment)/(.*)'
        and p1.alias like replace(p2.alias,'^','^^')
        union
        select 'hi/'||substring(alias,7) as alias
        from labecn_v1.labecn_v1_page
        where is_active = 1
        and is_deleted = 0
        and asset_type_id is null
        and is_published = 1
        and alias like '(hi/)%'
        and  alias like replace(alias,'^','^^')
    ) tab;
    
end;

 $$;


--
