-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: ix_ttmum_asset_list_aidatid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_aidatid; Type: INDEX; Schema: labpr; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_aidatid ON labpr.labpr_asset_list USING btree (asset_id, asset_type_id);


--
