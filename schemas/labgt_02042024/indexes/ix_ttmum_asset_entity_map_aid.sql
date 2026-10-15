-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: ix_ttmum_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_aid; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_aid ON labgt_02042024.labgt_asset_entity_map USING btree (asset_id);


--
