-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_album_asset_map_aid
-- Type: INDEX

-- Name: ix_khi_album_asset_map_aid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_album_asset_map_aid ON khi.khi_album_asset_map USING btree (album_id);


--
