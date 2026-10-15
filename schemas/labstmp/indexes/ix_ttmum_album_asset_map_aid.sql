-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_ttmum_album_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_album_asset_map_aid; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_ttmum_album_asset_map_aid ON labstmp.labstmp_album_asset_map USING btree (album_id);


--
