-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: ix_ttmum_asset_list_published_date
-- Type: INDEX

-- Name: ix_ttmum_asset_list_published_date; Type: INDEX; Schema: labsm; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_published_date ON labsm.labsm_asset_list USING btree (published_date);


--
