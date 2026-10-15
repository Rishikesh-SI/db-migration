-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_album_asset_map_aid
-- Type: INDEX

-- Name: ix_tsk_album_asset_map_aid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_album_asset_map_aid ON labtcs.labtcs_album_asset_map USING btree (album_id);


--
