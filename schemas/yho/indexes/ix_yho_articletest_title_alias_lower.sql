-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_articletest_title_alias_lower
-- Type: INDEX

-- Name: ix_yho_articletest_title_alias_lower; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_articletest_title_alias_lower ON ONLY yho.yho_article_test USING btree (lower((title_alias)::text));


--
