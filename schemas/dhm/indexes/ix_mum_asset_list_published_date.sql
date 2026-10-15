-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_asset_list_published_date
-- Type: INDEX

-- Name: ix_mum_asset_list_published_date; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_asset_list_published_date ON dhm.dhm_asset_list USING btree (published_date);


--
