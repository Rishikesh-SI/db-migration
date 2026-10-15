-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON labbsc_old.labbsc_asset_entity_map USING btree (entity_role_map_id);


--
