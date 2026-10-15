-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_asset_draft_asset_id_idx
-- Type: INDEX

-- Name: upstox_asset_draft_asset_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_asset_draft_asset_id_idx ON labupstox.labupstox_asset_draft USING btree (asset_id);


--
