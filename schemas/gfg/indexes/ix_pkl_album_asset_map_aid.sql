-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_album_asset_map_aid
-- Type: INDEX

-- Name: ix_pkl_album_asset_map_aid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_album_asset_map_aid ON gfg.gfg_album_asset_map USING btree (album_id);


--
