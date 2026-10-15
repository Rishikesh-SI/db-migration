-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_asset_entity_map_uqid
-- Type: INDEX

-- Name: ix_swa_asset_entity_map_uqid; Type: INDEX; Schema: swa; Owner: -
--

CREATE UNIQUE INDEX ix_swa_asset_entity_map_uqid ON swa.swa_asset_entity_map USING btree (asset_id, asset_type_id, entity_role_map_id);


--
