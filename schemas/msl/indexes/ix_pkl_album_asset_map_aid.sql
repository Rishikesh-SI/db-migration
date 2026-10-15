-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_album_asset_map_aid
-- Type: INDEX

-- Name: ix_pkl_album_asset_map_aid; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_album_asset_map_aid ON msl.msl_album_asset_map USING btree (album_id);


--
