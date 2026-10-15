-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_album_asset_map_album_id_idx
-- Type: INDEX

-- Name: upstox_album_asset_map_album_id_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_album_asset_map_album_id_idx ON upstox.upstox_album_asset_map USING btree (album_id);


--
