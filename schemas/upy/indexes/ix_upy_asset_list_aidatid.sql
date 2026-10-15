-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_asset_list_aidatid
-- Type: INDEX

-- Name: ix_upy_asset_list_aidatid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_asset_list_aidatid ON upy.upy_asset_list USING btree (asset_id, asset_type_id);


--
