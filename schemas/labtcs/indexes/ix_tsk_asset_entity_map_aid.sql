-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_tsk_asset_entity_map_aid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_asset_entity_map_aid ON labtcs.labtcs_asset_entity_map USING btree (asset_id);


--
