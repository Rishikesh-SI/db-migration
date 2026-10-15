-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_tfa_asset_entity_map_ermid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_asset_entity_map_ermid ON tfa.tfa_asset_entity_map USING btree (entity_role_map_id);


--
