-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_ttmum_asset_list_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_aid; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_aid ON labmi.labmi_asset_list USING btree (asset_id);


--
