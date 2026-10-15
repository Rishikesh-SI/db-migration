-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_aid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_aid ON labw88.labw88_asset_entity_map USING btree (asset_id);


--
