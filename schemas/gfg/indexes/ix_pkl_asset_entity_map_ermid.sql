-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_pkl_asset_entity_map_ermid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_asset_entity_map_ermid ON gfg.gfg_asset_entity_map USING btree (entity_role_map_id);


--
