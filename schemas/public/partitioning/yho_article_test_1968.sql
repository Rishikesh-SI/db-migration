-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: yho_article_test_1968
-- Type: TABLE ATTACH

-- Name: yho_article_test_1968; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY yho.yho_article_test ATTACH PARTITION public.yho_article_test_1968 FOR VALUES FROM ('1968-01-01 00:00:00') TO ('1969-01-01 00:00:00');


--
