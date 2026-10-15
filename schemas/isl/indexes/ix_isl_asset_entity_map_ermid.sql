-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_isl_asset_entity_map_ermid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_asset_entity_map_ermid ON isl.isl_asset_entity_map USING btree (entity_role_map_id);


--
