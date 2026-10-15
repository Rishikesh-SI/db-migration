-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_page_alias
-- Type: INDEX

-- Name: ix_stn_page_alias; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_page_alias ON stn.stn_page USING btree (alias);


--
