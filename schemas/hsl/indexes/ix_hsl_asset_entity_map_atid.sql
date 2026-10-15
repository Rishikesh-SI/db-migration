-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_hsl_asset_entity_map_atid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_asset_entity_map_atid ON hsl.hsl_asset_entity_map USING btree (asset_type_id);


--
