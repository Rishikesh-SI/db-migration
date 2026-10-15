-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: ix_ttmum_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_atid; Type: INDEX; Schema: labkc_v1_02042024; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_atid ON labkc_v1_02042024.labkc_v1_asset_entity_map USING btree (asset_type_id);


--
