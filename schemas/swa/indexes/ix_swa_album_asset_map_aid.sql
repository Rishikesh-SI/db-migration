-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_album_asset_map_aid
-- Type: INDEX

-- Name: ix_swa_album_asset_map_aid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_album_asset_map_aid ON swa.swa_album_asset_map USING btree (album_id);


--
