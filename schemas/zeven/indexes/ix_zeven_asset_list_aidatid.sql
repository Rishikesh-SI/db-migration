-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_asset_list_aidatid
-- Type: INDEX

-- Name: ix_zeven_asset_list_aidatid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_asset_list_aidatid ON zeven.zeven_asset_list USING btree (asset_id, asset_type_id);


--
