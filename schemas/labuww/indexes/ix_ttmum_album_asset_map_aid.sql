-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_ttmum_album_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_album_asset_map_aid; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_ttmum_album_asset_map_aid ON labuww.labuww_album_asset_map USING btree (album_id);


--
