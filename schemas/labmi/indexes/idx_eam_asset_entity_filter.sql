-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: idx_eam_asset_entity_filter
-- Type: INDEX

-- Name: idx_eam_asset_entity_filter; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX idx_eam_asset_entity_filter ON labmi.labmi_asset_entity_map USING btree (asset_type_id, entity_role_map_id, asset_id);


--
