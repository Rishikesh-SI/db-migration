-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_labfih_album_asset_map_album
-- Type: INDEX

-- Name: idx_labfih_album_asset_map_album; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_labfih_album_asset_map_album ON labfih.labfih_album_asset_map USING btree (album_id, asset_type_id);


--
