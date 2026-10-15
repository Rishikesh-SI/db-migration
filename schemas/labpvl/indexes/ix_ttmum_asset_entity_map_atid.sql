-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_atid; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_atid ON labpvl.labpvl_asset_entity_map USING btree (asset_type_id);


--
