-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_page_alias
-- Type: INDEX

-- Name: ix_tcs_page_alias; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_page_alias ON tcs.tcs_page USING btree (alias);


--
