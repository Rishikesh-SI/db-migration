-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_zeven_asset_entity_map_aid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_asset_entity_map_aid ON zeven.zeven_asset_entity_map USING btree (asset_id);


--
