-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_page_alias
-- Type: INDEX

-- Name: ix_ppb_page_alias; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_page_alias ON ppb.ppb_page USING btree (alias);


--
