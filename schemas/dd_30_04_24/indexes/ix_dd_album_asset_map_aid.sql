-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_album_asset_map_aid
-- Type: INDEX

-- Name: ix_dd_album_asset_map_aid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_album_asset_map_aid ON dd_30_04_24.dd_album_asset_map USING btree (album_id);


--
