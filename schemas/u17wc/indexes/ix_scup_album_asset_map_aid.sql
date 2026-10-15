-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_album_asset_map_aid
-- Type: INDEX

-- Name: ix_scup_album_asset_map_aid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_album_asset_map_aid ON u17wc.u17wc_album_asset_map USING btree (album_id);


--
