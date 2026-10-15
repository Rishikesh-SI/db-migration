-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_asset_list_aidatid
-- Type: INDEX

-- Name: ix_dd_asset_list_aidatid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_asset_list_aidatid ON dd_30_04_24.dd_asset_list USING btree (asset_id, asset_type_id);


--
