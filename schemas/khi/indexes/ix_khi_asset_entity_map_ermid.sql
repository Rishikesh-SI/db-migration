-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_khi_asset_entity_map_ermid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_asset_entity_map_ermid ON khi.khi_asset_entity_map USING btree (entity_role_map_id);


--
