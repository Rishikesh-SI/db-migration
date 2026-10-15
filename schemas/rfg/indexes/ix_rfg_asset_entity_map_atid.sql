-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_rfg_asset_entity_map_atid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_asset_entity_map_atid ON rfg.rfg_asset_entity_map USING btree (asset_type_id);


--
