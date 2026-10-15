-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_asset_search_view
-- Type: VIEW

-- Name: abp_asset_search_view; Type: VIEW; Schema: abpp; Owner: -
--

CREATE VIEW abpp.abp_asset_search_view AS
 SELECT al.asset_list_id,
    al.asset_title,
    al.title_alias,
    al.short_desc,
    c.entities
   FROM (( SELECT b.asset_list_id,
            string_agg(lower(b.entities), ','::text) AS entities
           FROM ( SELECT a.asset_list_id,
                    (jsonb_array_elements(a.entitydata) ->> 'name'::text) AS entities
                   FROM ( SELECT al_1.asset_list_id,
                            ((ad.asset_data -> 'data'::text) -> 'entitydata'::text) AS entitydata
                           FROM (abpp.abp_asset_draft ad
                             JOIN abpp.abp_asset_list al_1 ON (((al_1.asset_id = ad.asset_id) AND (al_1.asset_type_id = ad.asset_type_id) AND (al_1.published_version_number = ad.version_number))))
                          WHERE (al_1.asset_type_id = ANY (ARRAY[(1)::numeric, (2)::numeric, (4)::numeric]))) a
                  ORDER BY a.asset_list_id DESC
                 LIMIT 10000) b
          GROUP BY b.asset_list_id) c
     JOIN abpp.abp_asset_list al ON ((al.asset_list_id = c.asset_list_id)));


--
