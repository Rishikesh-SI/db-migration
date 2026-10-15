-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_page_alias
-- Type: INDEX

-- Name: ix_tfa_page_alias; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_page_alias ON tfa.tfa_page USING btree (alias);


--
