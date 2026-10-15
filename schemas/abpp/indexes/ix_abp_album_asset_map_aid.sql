-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_album_asset_map_aid
-- Type: INDEX

-- Name: ix_abp_album_asset_map_aid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_album_asset_map_aid ON abpp.abp_album_asset_map USING btree (album_id);


--
