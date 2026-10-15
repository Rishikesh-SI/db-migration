-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labpcm; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labpcm.labpcm_page USING btree (alias);


--
