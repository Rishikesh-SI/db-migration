-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ppb_asset_entity_map_ermid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_asset_entity_map_ermid ON ppb.ppb_asset_entity_map USING btree (entity_role_map_id);


--
