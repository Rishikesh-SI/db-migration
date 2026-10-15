-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_asset_list_published_date
-- Type: INDEX

-- Name: ix_tfa_asset_list_published_date; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_asset_list_published_date ON tfa.tfa_asset_list USING btree (published_date);


--
