-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_album_asset_map_aid
-- Type: INDEX

-- Name: ix_tsk_album_asset_map_aid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_album_asset_map_aid ON tsk.tsk_album_asset_map USING btree (album_id);


--
