-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: idx_labwis_album_asset_map_album
-- Type: INDEX

-- Name: idx_labwis_album_asset_map_album; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX idx_labwis_album_asset_map_album ON labwis.labwis_album_asset_map USING btree (album_id, asset_type_id);


--
