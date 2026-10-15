-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labkiyg; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labkiyg.labkiyg_page USING btree (alias);


--
