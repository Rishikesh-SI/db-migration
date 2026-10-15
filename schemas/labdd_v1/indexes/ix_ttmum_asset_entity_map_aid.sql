-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: ix_ttmum_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_aid; Type: INDEX; Schema: labdd_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_aid ON labdd_v1.labdd_v1_asset_entity_map USING btree (asset_id);


--
