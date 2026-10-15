-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_hierarchy
-- Type: MATERIALIZED VIEW

-- Name: labfih_hierarchy; Type: MATERIALIZED VIEW; Schema: labfih; Owner: -
--

CREATE MATERIALIZED VIEW labfih.labfih_hierarchy AS
 SELECT t.page_id,
    t.parent_id,
    t.level,
    t.branch,
    t.ord
   FROM public.connectby('labfih.labfih_page'::text, 'page_id'::text, 'parent_id'::text, 'page_id'::text, '0'::text, 0, ','::text) t(page_id numeric, parent_id numeric, level integer, branch text, ord integer)
  WITH NO DATA;


--
