-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_album_asset_map_aid
-- Type: INDEX

-- Name: ix_scom_album_asset_map_aid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_album_asset_map_aid ON scom.scom_album_asset_map USING btree (album_id);


--
