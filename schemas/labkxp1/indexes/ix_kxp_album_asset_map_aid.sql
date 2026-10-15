-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_album_asset_map_aid
-- Type: INDEX

-- Name: ix_kxp_album_asset_map_aid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_album_asset_map_aid ON labkxp1.labkxp_album_asset_map USING btree (album_id);


--
