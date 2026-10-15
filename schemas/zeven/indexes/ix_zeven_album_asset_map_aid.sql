-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_album_asset_map_aid
-- Type: INDEX

-- Name: ix_zeven_album_asset_map_aid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_album_asset_map_aid ON zeven.zeven_album_asset_map USING btree (album_id);


--
