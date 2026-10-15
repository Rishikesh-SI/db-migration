-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: ix_ttmum_album_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_album_asset_map_aid; Type: INDEX; Schema: labtmum; Owner: -
--

CREATE INDEX ix_ttmum_album_asset_map_aid ON labtmum.labtmum_album_asset_map USING btree (album_id);


--
