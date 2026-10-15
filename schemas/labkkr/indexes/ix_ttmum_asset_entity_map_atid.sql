-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: ix_ttmum_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_atid; Type: INDEX; Schema: labkkr; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_atid ON labkkr.labkkr_asset_entity_map USING btree (asset_type_id);


--
