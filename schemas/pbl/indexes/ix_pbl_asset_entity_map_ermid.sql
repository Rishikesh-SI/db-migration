-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_pbl_asset_entity_map_ermid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_asset_entity_map_ermid ON pbl.pbl_asset_entity_map USING btree (entity_role_map_id);


--
