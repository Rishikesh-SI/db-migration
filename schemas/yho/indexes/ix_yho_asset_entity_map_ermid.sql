-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_yho_asset_entity_map_ermid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_asset_entity_map_ermid ON yho.yho_asset_entity_map USING btree (entity_role_map_id);


--
