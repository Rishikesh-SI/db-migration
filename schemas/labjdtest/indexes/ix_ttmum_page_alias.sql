-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labjdtest; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labjdtest.labjdtest_page USING btree (alias);


--
