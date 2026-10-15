-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_ttmum_asset_list_aidatid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_aidatid; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_aidatid ON labmi_v1.labmi_v1_asset_list USING btree (asset_id, asset_type_id);


--
