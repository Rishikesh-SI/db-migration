-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_album_asset_map_aid
-- Type: INDEX

-- Name: ix_hsl_album_asset_map_aid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_album_asset_map_aid ON hsl.hsl_album_asset_map USING btree (album_id);


--
