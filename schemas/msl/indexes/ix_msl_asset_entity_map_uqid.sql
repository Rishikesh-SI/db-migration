-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_msl_asset_entity_map_uqid
-- Type: INDEX

-- Name: ix_msl_asset_entity_map_uqid; Type: INDEX; Schema: msl; Owner: -
--

CREATE UNIQUE INDEX ix_msl_asset_entity_map_uqid ON msl.msl_asset_entity_map USING btree (asset_id, asset_type_id, entity_role_map_id);


--
