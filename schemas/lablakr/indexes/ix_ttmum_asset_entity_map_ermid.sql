-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: lablakr; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON lablakr.lablakr_asset_entity_map USING btree (entity_role_map_id);


--
