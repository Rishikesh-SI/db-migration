-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_rfg_asset_entity_map_ermid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_asset_entity_map_ermid ON rfg.rfg_asset_entity_map USING btree (entity_role_map_id);


--
