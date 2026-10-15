-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: ix_ttmum_album_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_album_asset_map_aid; Type: INDEX; Schema: labmi_v1_bkp; Owner: -
--

CREATE INDEX ix_ttmum_album_asset_map_aid ON labmi_v1_bkp.labmi_v1_album_asset_map USING btree (album_id);


--
