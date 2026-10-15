-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: labdsg; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON labdsg.labdsg_asset_entity_map USING btree (entity_role_map_id);


--
