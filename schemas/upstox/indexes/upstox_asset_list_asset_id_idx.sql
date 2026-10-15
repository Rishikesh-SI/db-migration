-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_asset_list_asset_id_idx
-- Type: INDEX

-- Name: upstox_asset_list_asset_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_asset_list_asset_id_idx ON upstox.upstox_asset_list USING btree (asset_id);


--
