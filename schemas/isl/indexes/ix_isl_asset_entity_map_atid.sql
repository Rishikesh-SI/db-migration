-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_isl_asset_entity_map_atid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_asset_entity_map_atid ON isl.isl_asset_entity_map USING btree (asset_type_id);


--
