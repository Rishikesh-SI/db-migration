-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: yho_article_test_2019
-- Type: TABLE ATTACH

-- Name: yho_article_test_2019; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY yho.yho_article_test ATTACH PARTITION public.yho_article_test_2019 FOR VALUES FROM ('2019-01-01 00:00:00') TO ('2020-01-01 00:00:00');


--
