-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: idx_eam_asset_entity_filter
-- Type: INDEX

-- Name: idx_eam_asset_entity_filter; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX idx_eam_asset_entity_filter ON labkc_v1.labkc_v1_asset_entity_map USING btree (asset_type_id, entity_role_map_id, asset_id);


--
