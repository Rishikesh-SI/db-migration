-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_album_asset_map_album_id_idx
-- Type: INDEX

-- Name: lablsg_album_asset_map_album_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_album_asset_map_album_id_idx ON fanxp_lsg.lablsg_album_asset_map USING btree (album_id);


--
