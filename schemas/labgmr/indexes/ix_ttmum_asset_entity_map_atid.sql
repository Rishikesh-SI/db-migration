-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: ix_ttmum_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_atid; Type: INDEX; Schema: labgmr; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_atid ON labgmr.labgmr_asset_entity_map USING btree (asset_type_id);


--
