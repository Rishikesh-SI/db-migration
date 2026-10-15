-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_upy_asset_entity_map_aid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_asset_entity_map_aid ON upy.upy_asset_entity_map USING btree (asset_id);


--
