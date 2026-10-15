-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_album_asset_map_aid
-- Type: INDEX

-- Name: ix_rfg_album_asset_map_aid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_album_asset_map_aid ON rfg.rfg_album_asset_map USING btree (album_id);


--
