-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_album_asset_map_aid
-- Type: INDEX

-- Name: ix_isl_album_asset_map_aid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_album_asset_map_aid ON isl.isl_album_asset_map USING btree (album_id);


--
