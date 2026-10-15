-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labrstg.labrstg_page USING btree (alias);


--
