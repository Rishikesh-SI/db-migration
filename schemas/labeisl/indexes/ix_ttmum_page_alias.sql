-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labeisl; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labeisl.labeisl_page USING btree (alias);


--
