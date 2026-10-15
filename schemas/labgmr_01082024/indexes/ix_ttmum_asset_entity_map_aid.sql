-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: ix_ttmum_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_aid; Type: INDEX; Schema: labgmr_01082024; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_aid ON labgmr_01082024.labgmr_asset_entity_map USING btree (asset_id);


--
