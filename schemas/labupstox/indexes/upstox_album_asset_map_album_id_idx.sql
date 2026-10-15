-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_album_asset_map_album_id_idx
-- Type: INDEX

-- Name: upstox_album_asset_map_album_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_album_asset_map_album_id_idx ON labupstox.labupstox_album_asset_map USING btree (album_id);


--
