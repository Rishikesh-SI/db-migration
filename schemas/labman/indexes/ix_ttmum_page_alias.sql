-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labman; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labman.labman_page USING btree (alias);


--
