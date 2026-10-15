-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_album_asset_map_aid
-- Type: INDEX

-- Name: ix_mum_album_asset_map_aid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_album_asset_map_aid ON tmm.tmm_album_asset_map USING btree (album_id);


--
