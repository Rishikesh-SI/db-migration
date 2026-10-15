-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: yho_article_test_2019_lower_idx
-- Type: INDEX ATTACH

-- Name: yho_article_test_2019_lower_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX yho.ix_yho_articletest_title_alias_lower ATTACH PARTITION public.yho_article_test_2019_lower_idx;


--
