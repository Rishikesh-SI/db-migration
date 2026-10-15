-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: yho_article_test_2017_lower_idx
-- Type: INDEX

-- Name: yho_article_test_2017_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX yho_article_test_2017_lower_idx ON public.yho_article_test_2017 USING btree (lower((title_alias)::text));


--
