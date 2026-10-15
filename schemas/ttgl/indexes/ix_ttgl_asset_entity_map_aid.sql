-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_ttgl_asset_entity_map_aid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_asset_entity_map_aid ON ttgl.ttgl_asset_entity_map USING btree (asset_id);


--
