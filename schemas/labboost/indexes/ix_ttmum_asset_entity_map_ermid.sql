-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: ix_ttmum_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_ermid; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_ermid ON labboost.labboost_asset_entity_map USING btree (entity_role_map_id);


--
