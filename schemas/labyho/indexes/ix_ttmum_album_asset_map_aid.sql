-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_ttmum_album_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_album_asset_map_aid; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_ttmum_album_asset_map_aid ON labyho.labyho_album_asset_map USING btree (album_id);


--
