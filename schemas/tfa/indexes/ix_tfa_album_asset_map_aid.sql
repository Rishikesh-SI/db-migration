-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_album_asset_map_aid
-- Type: INDEX

-- Name: ix_tfa_album_asset_map_aid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_album_asset_map_aid ON tfa.tfa_album_asset_map USING btree (album_id);


--
