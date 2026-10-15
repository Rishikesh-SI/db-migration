-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_seo_data_asset_id_asset_type_id_idx
-- Type: INDEX

-- Name: upstox_seo_data_asset_id_asset_type_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_seo_data_asset_id_asset_type_id_idx ON upstox.upstox_seo_data USING btree (asset_id, asset_type_id);


--
