-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: ix_ttmum_album_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_album_asset_map_aid; Type: INDEX; Schema: labecn_bkp05092024; Owner: -
--

CREATE INDEX ix_ttmum_album_asset_map_aid ON labecn_bkp05092024.labecn_album_asset_map USING btree (album_id);


--
