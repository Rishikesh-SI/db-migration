-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_asset_list_published_date
-- Type: INDEX

-- Name: ix_swa_asset_list_published_date; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_asset_list_published_date ON swa.swa_asset_list USING btree (published_date);


--
