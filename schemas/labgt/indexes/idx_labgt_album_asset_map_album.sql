-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_labgt_album_asset_map_album
-- Type: INDEX

-- Name: idx_labgt_album_asset_map_album; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_labgt_album_asset_map_album ON labgt.labgt_album_asset_map USING btree (album_id, asset_type_id);


--
