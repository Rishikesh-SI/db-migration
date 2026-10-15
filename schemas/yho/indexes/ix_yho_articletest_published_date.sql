-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_articletest_published_date
-- Type: INDEX

-- Name: ix_yho_articletest_published_date; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_articletest_published_date ON ONLY yho.yho_article_test USING btree (published_date DESC);


--
