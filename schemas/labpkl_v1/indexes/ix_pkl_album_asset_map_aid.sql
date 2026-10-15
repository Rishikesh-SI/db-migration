-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_album_asset_map_aid
-- Type: INDEX

-- Name: ix_pkl_album_asset_map_aid; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_album_asset_map_aid ON labpkl_v1.labpkl_v1_album_asset_map USING btree (album_id);


--
