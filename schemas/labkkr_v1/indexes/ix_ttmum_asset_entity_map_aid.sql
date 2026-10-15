-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: ix_ttmum_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_aid; Type: INDEX; Schema: labkkr_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_aid ON labkkr_v1.labkkr_v1_asset_entity_map USING btree (asset_id);


--
