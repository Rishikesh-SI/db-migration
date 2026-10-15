-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_album_asset_map_album_id_idx
-- Type: INDEX

-- Name: labbsc_dev_album_asset_map_album_id_idx; Type: INDEX; Schema: labbsc_dev; Owner: -
--

CREATE INDEX labbsc_dev_album_asset_map_album_id_idx ON labbsc_dev.labbsc_dev_album_asset_map USING btree (album_id);


--
