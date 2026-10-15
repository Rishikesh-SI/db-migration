-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: idx_labgt01_v1_album_asset_map_album
-- Type: INDEX

-- Name: idx_labgt01_v1_album_asset_map_album; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX idx_labgt01_v1_album_asset_map_album ON labgt01_v1.labgt01_v1_album_asset_map USING btree (album_id, asset_type_id);


--
