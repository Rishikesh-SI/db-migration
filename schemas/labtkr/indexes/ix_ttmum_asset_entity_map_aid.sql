-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: ix_ttmum_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_aid; Type: INDEX; Schema: labtkr; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_aid ON labtkr.labtkr_asset_entity_map USING btree (asset_id);


--
