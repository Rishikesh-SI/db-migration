-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labgmr; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labgmr.labgmr_page USING btree (alias);


--
