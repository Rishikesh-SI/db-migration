-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_kxp_asset_entity_map_ermid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_asset_entity_map_ermid ON kxp.kxp_asset_entity_map USING btree (entity_role_map_id);


--
