-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_mum_asset_entity_map_atid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_asset_entity_map_atid ON dhm.dhm_asset_entity_map USING btree (asset_type_id);


--
