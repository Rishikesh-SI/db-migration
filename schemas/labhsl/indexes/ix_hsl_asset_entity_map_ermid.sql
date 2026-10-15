-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_hsl_asset_entity_map_ermid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_asset_entity_map_ermid ON labhsl.labhsl_asset_entity_map USING btree (entity_role_map_id);


--
