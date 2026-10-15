-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_pkl_asset_entity_map_ermid; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_asset_entity_map_ermid ON labpkl_v1.labpkl_v1_asset_entity_map USING btree (entity_role_map_id);


--
