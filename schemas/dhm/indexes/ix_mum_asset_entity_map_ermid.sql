-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_mum_asset_entity_map_ermid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_asset_entity_map_ermid ON dhm.dhm_asset_entity_map USING btree (entity_role_map_id);


--
