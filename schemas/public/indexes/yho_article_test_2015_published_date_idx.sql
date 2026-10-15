-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: yho_article_test_2015_published_date_idx
-- Type: INDEX

-- Name: yho_article_test_2015_published_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX yho_article_test_2015_published_date_idx ON public.yho_article_test_2015 USING btree (published_date DESC);


--
