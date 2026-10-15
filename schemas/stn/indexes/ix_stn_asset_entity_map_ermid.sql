-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_stn_asset_entity_map_ermid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_asset_entity_map_ermid ON stn.stn_asset_entity_map USING btree (entity_role_map_id);


--
