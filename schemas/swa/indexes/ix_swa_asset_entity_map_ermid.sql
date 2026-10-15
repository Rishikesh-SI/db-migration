-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_swa_asset_entity_map_ermid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_asset_entity_map_ermid ON swa.swa_asset_entity_map USING btree (entity_role_map_id);


--
