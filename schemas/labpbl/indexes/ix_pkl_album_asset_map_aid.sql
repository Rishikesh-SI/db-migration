-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_album_asset_map_aid
-- Type: INDEX

-- Name: ix_pkl_album_asset_map_aid; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_album_asset_map_aid ON labpbl.labpbl_album_asset_map USING btree (album_id);


--
