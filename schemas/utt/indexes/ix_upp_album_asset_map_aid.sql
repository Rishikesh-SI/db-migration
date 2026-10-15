-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_album_asset_map_aid
-- Type: INDEX

-- Name: ix_upp_album_asset_map_aid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_album_asset_map_aid ON utt.utt_album_asset_map USING btree (album_id);


--
