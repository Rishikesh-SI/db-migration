-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_tcs_asset_entity_map_aid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_asset_entity_map_aid ON tcs.tcs_asset_entity_map USING btree (asset_id);


--
