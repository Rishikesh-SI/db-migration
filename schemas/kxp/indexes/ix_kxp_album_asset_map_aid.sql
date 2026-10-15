-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_album_asset_map_aid
-- Type: INDEX

-- Name: ix_kxp_album_asset_map_aid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_album_asset_map_aid ON kxp.kxp_album_asset_map USING btree (album_id);


--
