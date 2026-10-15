-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labfg; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labfg.labfg_page USING btree (alias);


--
