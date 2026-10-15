-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_asset_draft_asset_type_id_idx
-- Type: INDEX

-- Name: upstox_asset_draft_asset_type_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_asset_draft_asset_type_id_idx ON upstox.upstox_asset_draft USING btree (asset_type_id);


--
