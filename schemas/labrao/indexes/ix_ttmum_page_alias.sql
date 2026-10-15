-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labrao; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labrao.labrao_page USING btree (alias);


--
