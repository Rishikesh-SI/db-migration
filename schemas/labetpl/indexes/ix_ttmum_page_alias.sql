-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labetpl; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labetpl.labetpl_page USING btree (alias);


--
