-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_page_alias
-- Type: INDEX

-- Name: ix_swa_page_alias; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_page_alias ON swa.swa_page USING btree (alias);


--
