-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: labdd_v1_30april24; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON labdd_v1_30april24.labdd_v1_asset_entity_map USING btree (entity_role_map_id);


--
