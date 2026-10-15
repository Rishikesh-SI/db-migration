-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON labuww.labuww_asset_entity_map USING btree (entity_role_map_id);


--
