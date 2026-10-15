-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_page_alias
-- Type: INDEX

-- Name: ix_mum_page_alias; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_page_alias ON dhm.dhm_page USING btree (alias);


--
