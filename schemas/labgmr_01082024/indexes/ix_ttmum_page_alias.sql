-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labgmr_01082024; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labgmr_01082024.labgmr_page USING btree (alias);


--
