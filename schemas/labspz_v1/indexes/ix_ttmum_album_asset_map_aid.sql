-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: ix_ttmum_album_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_album_asset_map_aid; Type: INDEX; Schema: labspz_v1; Owner: -
--

CREATE INDEX ix_ttmum_album_asset_map_aid ON labspz_v1.labspz_v1_album_asset_map USING btree (album_id);


--
