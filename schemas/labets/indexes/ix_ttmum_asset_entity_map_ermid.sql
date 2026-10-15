-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: labets; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON labets.labets_asset_entity_map USING btree (entity_role_map_id);


--
