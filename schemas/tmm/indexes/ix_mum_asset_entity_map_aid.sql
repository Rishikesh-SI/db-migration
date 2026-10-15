-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_mum_asset_entity_map_aid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_asset_entity_map_aid ON tmm.tmm_asset_entity_map USING btree (asset_id);


--
