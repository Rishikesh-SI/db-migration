-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_page_alias
-- Type: INDEX

-- Name: ix_mum_page_alias; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_page_alias ON tmm.tmm_page USING btree (alias);


--
