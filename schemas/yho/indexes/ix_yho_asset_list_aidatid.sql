-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_asset_list_aidatid
-- Type: INDEX

-- Name: ix_yho_asset_list_aidatid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_asset_list_aidatid ON yho.yho_asset_list USING btree (asset_id, asset_type_id);


--
