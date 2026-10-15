-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON labrs_2602.labrs_asset_entity_map USING btree (entity_role_map_id);


--
