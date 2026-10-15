-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_author_action_asset_type_id_asset_id_idx
-- Type: INDEX

-- Name: upstox_author_action_asset_type_id_asset_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_author_action_asset_type_id_asset_id_idx ON labupstox.labupstox_author_action USING btree (asset_type_id, asset_id);


--
