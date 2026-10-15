-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON labsrk.labsrk_asset_entity_map USING btree (entity_role_map_id);


--
