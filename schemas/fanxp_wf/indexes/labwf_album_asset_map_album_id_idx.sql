-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_album_asset_map_album_id_idx
-- Type: INDEX

-- Name: labwf_album_asset_map_album_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_album_asset_map_album_id_idx ON fanxp_wf.labwf_album_asset_map USING btree (album_id);


--
