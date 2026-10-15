-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labwafdemo; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labwafdemo.labwafdemo_page USING btree (alias);


--
