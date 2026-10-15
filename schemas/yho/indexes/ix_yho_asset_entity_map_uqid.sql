-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_asset_entity_map_uqid
-- Type: INDEX

-- Name: ix_yho_asset_entity_map_uqid; Type: INDEX; Schema: yho; Owner: -
--

CREATE UNIQUE INDEX ix_yho_asset_entity_map_uqid ON yho.yho_asset_entity_map USING btree (entity_role_map_id, asset_type_id, asset_id);


--
