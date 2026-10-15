-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labgrl; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labgrl.labgrl_page USING btree (alias);


--
