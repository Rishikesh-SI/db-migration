-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON labw88.labw88_asset_entity_map USING btree (entity_role_map_id);


--
