-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labgfg; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labgfg.labgfg_page USING btree (alias);


--
