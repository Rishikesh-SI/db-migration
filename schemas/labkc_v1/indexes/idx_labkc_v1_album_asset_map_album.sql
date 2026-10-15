-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_labkc_v1_album_asset_map_album
-- Type: INDEX

-- Name: idx_labkc_v1_album_asset_map_album; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_labkc_v1_album_asset_map_album ON labkc_v1.labkc_v1_album_asset_map USING btree (album_id, asset_type_id);


--
