-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: article_upd_2016
-- Type: TABLE ATTACH

-- Name: article_upd_2016; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY yho.yho_article_upd ATTACH PARTITION public.article_upd_2016 FOR VALUES IN ('2016');


--
