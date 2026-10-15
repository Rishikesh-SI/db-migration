-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: labmcfc_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON labmcfc_v1.labmcfc_v1_asset_entity_map USING btree (entity_role_map_id);


--
